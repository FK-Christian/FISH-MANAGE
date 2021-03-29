<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Request;
use Illuminate\Support\Facades\Log;
use App\Models\Navigation;
use App\Models\Vague;
use App\Models\Bac;
use App\Models\Aliment;
use App\Models\CmsUser;
use App\Models\Preuve;
use App\Models\Flux;

class ApiWebhookController extends \crocodicstudio\crudbooster\controllers\ApiController {

    private $navigation;
    
    function __construct() {
        $this->table = "navigations";
        $this->permalink = "webhook";
        $this->method_type = "post";
    }

    public function hook_before(&$received_data) {
        $received_data = Request::all();
        $this->navigation = new \stdClass();
        $this->navigation->customer_chat_id = $received_data['message']['from']['id'];
        $this->navigation->customer_message = isset($received_data['message']['text']) ? $received_data['message']['text'] : 'picture_send';
        $this->navigation->customer_name = $received_data['message']['from']['last_name'] . " " . $received_data['message']['from']['first_name'];
        $this->navigation->file_name = telegramGetFile($received_data);
        $this->getCurrentPosition();
        $this->evaluateInput();
        $this->getNextPosition();
        telegramChat($this->navigation->customer_chat_id, $this->navigation->customer_message_answer);
    }

    public function hook_query(&$query) {
        //This method is to customize the sql query
    }

    public function hook_after($postdata, &$result) {
        //This method will be execute after run the main process
    }
    
    
    
    private function update_data_collected($var_name, $value, $reset = false) {
        $nav = Navigation::findOrFail($this->navigation->customer_chat_id);
        $to_update = array();
        if ($reset) {
            $to_update = array('last_date' => date('Y-m-d H:i:s'), 'step' => "HOME_HOME", 'data_collected' => json_encode(array()));
        } else {
            $data_collected = json_decode($nav->data_collected, true);
            $data_collected[$var_name] = $value;
            $to_update = array('last_date' => date('Y-m-d H:i:s'), 'data_collected' => json_encode($data_collected));
        }
        $nav->update($to_update);
    }
    
    private function update_vague_or_bac_nbre($id, $nbre, $is_vague = false, $is_nbre_sortie = true) {
        if ($is_vague) {
            $vague = Vague::findOrFail($id);
            if ($is_nbre_sortie) {
                $vague->update(array('nbre_sortie' => ($vague->nbre_sortie + $nbre)));
            } else {
                $vague->update(array('nbre_perte' => ($vague->nbre_perte + $nbre)));
            }
        } else {
            $bac = Bac::findOrFail($id);
            $bac->update(array('nbre' => ($bac->nbre + $nbre)));
        }
    }

    private function update_aliment_stock($id, $qte) {
        $aliment = Aliment::findOrFail($id);
        $aliment->update(array('stock_en_g' => $aliment->stock_en_g + $qte));
    }
    
    private function get_user_and_dataSaved() {
        $nav = Navigation::findOrFail($this->navigation->customer_chat_id);
        $retour = json_decode($nav->data_collected, true);
        $user = CmsUser::where('telegram_id',$this->navigation->customer_chat_id)->first();
        $retour['agent'] = ($user) ? null : $user->id;
        $retour['date_action'] = date('Y-m-d H:i:s');
        return $retour;
    }
    
    private function getCurrentPosition() {
        $navigation_save = Navigation::where('chat_id',$this->navigation->customer_chat_id)->first();
        Log::debug("NAVIGATION IN: ".json_encode($this->navigation));
        Log::debug("NAVIGATION DB: ".json_encode($navigation_save));
        if (!$navigation_save) {
            $toSave['chat_id'] = "" . $this->navigation->customer_chat_id;
            $toSave['name'] = $this->navigation->customer_name;
            $toSave['step'] = "HOME_HOME";
            $toSave['data_collected'] = json_encode(array());
            $toSave['last_date'] = date('Y-m-d H:i:s');
            Navigation::create($toSave);
            $this->navigation->customer_current_step = "HOME_HOME";
            $this->navigation->customer_next_step = "HOME_HOME";
        } else {
            $this->navigation->customer_current_step = $navigation_save->step;
            $this->navigation->customer_next_step = "UNDEFINE_UNDEFINE";
            $navigation_save->update(array('last_date' => date('Y-m-d H:i:s')));
        }
    }
    
    private function evaluateInput() {
        $value = $this->navigation->customer_message;
        $userCheck = CmsUser::where('telegram_id',$this->navigation->customer_chat_id)->first();
        if (strcmp(trim(strtoupper($value)), "RESET") == 0) {
            $this->navigation->customer_next_step = $this->getStepCode("HOME_HOME");
            $this->update_data_collected("home", $value, true);
        } else if (!$userCheck) {
            $this->navigation->customer_next_step = $this->getStepCode("HOME_NOTFOUND");
            $this->navigation->error = true;
            $this->update_data_collected("home", $value, true);
        } else {
            if (strcasecmp($this->navigation->customer_current_step, $this->navigation->customer_next_step) != 0) {
                $val = explode("_", $this->navigation->customer_current_step);
                $step = strtoupper($val[1]);
                $service = $val[0];
                switch ($step) {
                    case "HOME":
                        if ((ctype_digit($value) && $value <= 8 && 0 < $value)) {
                            $this->navigation->customer_next_step = $this->getStepCode("HOME_$value");
                            $this->update_data_collected("home", $value);
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "BAC":
                        if ((ctype_digit($value))) {
                            $bac = Bac::where('id',$value)->get(); //$this->get_data_by("*", "bacs", "id = $value");
                            if (!empty($bac)) {
                                $this->navigation->customer_next_step = $this->getStepCode($service . "_BAC");
                                $this->update_data_collected("bac_source", $value);
                            } else {
                                $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                                $this->navigation->error = true;
                            }
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "BAC2":
                        if ((ctype_digit($value))) {
                            $bac = Bac::where('id',$value)->get();
                            if (!empty($bac)) {
                                $this->navigation->customer_next_step = $this->getStepCode($service . "_BAC2");
                                $this->update_data_collected("bac_destination", $value);
                            } else {
                                $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                                $this->navigation->error = true;
                            }
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "VAGUE":
                        if ((ctype_digit($value))) {
                            $vague = Vague::where('id',$value)->get();
                            if (!empty($vague)) {
                                $this->navigation->customer_next_step = $this->getStepCode($service . "_VAGUE");
                                $this->update_data_collected("vague", $value);
                            } else {
                                $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                                $this->navigation->error = true;
                            }
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "ALIMENT":
                        if ((ctype_digit($value))) {
                            $aliment = Aliment::where('id',$value)->get();
                            if (!empty($aliment)) {
                                $this->navigation->customer_next_step = $this->getStepCode($service . "_ALIMENT");
                                $this->update_data_collected("aliment", $value);
                            } else {
                                $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                                $this->navigation->error = true;
                            }
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "ID":
                        if ((ctype_digit($value)) && $value > 0) {
                            $flux = Flux::where('id',$value)->get();
                            if (!empty($flux)) {
                                $this->navigation->customer_next_step = $this->getStepCode($service . "_ID");
                                $this->update_data_collected("id", $value);
                            } else {
                                $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                                $this->navigation->error = true;
                            }
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "QTE":
                        if ((ctype_digit($value)) && $value > 0) {
                            $this->navigation->customer_next_step = $this->getStepCode($service . "_QTE");
                            $this->update_data_collected("qte_gramme", $value);
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "PDU":
                        if ((is_numeric($value))) {
                            $this->navigation->customer_next_step = $this->getStepCode($service . "_PDU");
                            $this->update_data_collected("poids_unite", $value);
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "PU":
                        if ((ctype_digit($value)) && $value > 0) {
                            $this->navigation->customer_next_step = $this->getStepCode($service . "_PU");
                            $this->update_data_collected("cout_unite", $value);
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "PUKG":
                        if ((ctype_digit($value)) && $value > 0) {
                            $this->navigation->customer_next_step = $this->getStepCode($service . "_PUKG");
                            $this->update_data_collected("cout_kg", $value);
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "PKG":
                        if ((ctype_digit($value)) && $value > 0) {
                            $this->navigation->customer_next_step = $this->getStepCode($service . "_PKG");
                            $this->update_data_collected("poids_kg", $value);
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "NBRE":
                        if ((ctype_digit($value)) && $value != 0) {
                            $this->navigation->customer_next_step = $this->getStepCode($service . "_NBRE");
                            $this->update_data_collected("nbre", $value);
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "NBREP":
                        if ((ctype_digit($value)) && $value > 0) {
                            $this->navigation->customer_next_step = $this->getStepCode($service . "_NBREP");
                            $this->update_data_collected("nbre_photo", $value);
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "MESSAGE":
                        $this->navigation->customer_next_step = $this->getStepCode($service . "_MESSAGE");
                        $this->update_data_collected("description", $value);
                        break;
                    case "PHOTO":
                        if (strcmp($this->navigation->file_name, "NO_FILE") == 0) {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        } else {
                            $data = $this->get_user_and_dataSaved();
                            $nbre = $data['nbre_photo'];
                            $position_suivante = ($nbre + 1);
                            for ($i = 1; $i <= $nbre; $i++) {
                                $next_to_save = "photo_$i";
                                if (!isset($data[$next_to_save])) {
                                    $this->update_data_collected($next_to_save, $this->navigation->file_name);
                                    $position_suivante = ($i + 1);
                                    break;
                                }
                            }
                            if ($position_suivante > $nbre) {
                                $this->navigation->customer_next_step = $this->getStepCode($service . "_PHOTO") . "_$position_suivante";
                            } else {
                                $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            }
                        }
                        break;
                    case "DATE1":
                        if ((is_sql_date($value))) {
                            $this->navigation->customer_next_step = $this->getStepCode($service . "_DATE1");
                            $this->update_data_collected("date_debut", $value);
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                    case "DATE2":
                        if ((is_sql_date($value))) {
                            $this->navigation->customer_next_step = $this->getStepCode($service . "_DATE2");
                            $this->update_data_collected("date_fin", $value);
                        } else {
                            $this->navigation->customer_next_step = $this->navigation->customer_current_step;
                            $this->navigation->error = true;
                        }
                        break;
                }
                $navigation_save = Navigation::where('chat_id',$this->navigation->customer_chat_id)->first();
                $navigation_save->update(array('last_date' => date('Y-m-d H:i:s'), 'step' => $this->navigation->customer_next_step));
            }
        }
    }
    
    private function getNextPosition() {
        $val = explode("_", $this->navigation->customer_next_step);
        $step = strtoupper($val[1]);
        switch ($step) {
            case "END":
                $save = false;
                $user_data = $this->get_user_and_dataSaved();
                $save_flux['agent'] = isset($user_data['agent']) ? $user_data['agent'] : null;
                $save_flux['date_action'] = isset($user_data['date_action']) ? $user_data['date_action'] : null;
                $save_flux['bac_source'] = isset($user_data['bac_source']) ? $user_data['bac_source'] : null;
                $save_flux['bac_destination'] = isset($user_data['bac_destination']) ? $user_data['bac_destination'] : null;
                $save_flux['vague'] = isset($user_data['vague']) ? $user_data['vague'] : null;
                $save_flux['aliment'] = isset($user_data['aliment']) ? $user_data['aliment'] : null;
                $save_flux['nbre'] = isset($user_data['nbre']) ? $user_data['nbre'] : 0;
                $save_flux['qte_gramme'] = isset($user_data['qte_gramme']) ? $user_data['qte_gramme'] : 0;
                $save_flux['description'] = isset($user_data['description']) ? $user_data['description'] : null;
                $save_flux['cout_unite'] = isset($user_data['cout_unite']) ? $user_data['cout_unite'] : 0;
                $save_flux['cout_kg'] = isset($user_data['cout_kg']) ? $user_data['cout_kg'] : 0;
                switch (strtoupper($val[0])) {
                    case "NOUVELLE-VAGUE":
                        $save = true;
                        $vague_save = array();
                        $vague_save['agent'] = $save_flux['agent'];
                        $vague_save['date_entree'] = $save_flux['date_action'];
                        $vague_save['date_sortie'] = $save_flux['date_action'];
                        $vague_save['date_prevu_sortie'] = $save_flux['date_action'];
                        $vague_save['poids_unite'] = $user_data['poids_unite'];
                        $vague_save['prix_unite'] = $user_data['cout_unite'];
                        $vague_save['nbre_entree'] = $save_flux['nbre'];
                        $vague_save['name'] = "VAGUE-" . date('Ymd');
                        $vague_save['nbre_sortie'] = 0;
                        $vague_save['nbre_perte'] = 0;
                        $vague_save['description'] = $save_flux['description'];
                        Vague::create($vague_save);
                        $save_flux['vague'] = Vague::where('name',$vague_save['name'])->first()->id;
                        $save_flux['type_flux'] = "POISSON";
                        $save_flux['statut'] = "ACHAT";
                        $save_flux['qte_gramme'] = $vague_save['poids_unite'];
                        $this->save_vague_or_bac_nbre($save_flux['bac_source'], $save_flux['nbre']);
                        $this->navigation->customer_message_answer = "Votre enregistrement a ete fait avec succes\n";
                        break;
                    case "PERTE-POISSON":
                        $save = true;
                        $save_flux['type_flux'] = "POISSON";
                        $save_flux['statut'] = "PERTE";
                        $this->save_vague_or_bac_nbre($save_flux['bac_source'], (-1) * $save_flux['nbre']);
                        $this->save_vague_or_bac_nbre($save_flux['vague'], $save_flux['nbre'], true, false);
                        $this->navigation->customer_message_answer = "Votre enregistrement a ete fait avec succes\n";
                        break;
                    case "NUTRITION-POISSON":
                        $save = true;
                        $save_flux['type_flux'] = "ALIMENT";
                        $save_flux['statut'] = "NUTRITION";
                        $this->save_aliment_stock($save_flux['aliment'], (-1) * $save_flux['qte_gramme']);
                        $this->navigation->customer_message_answer = "Votre enregistrement a ete fait avec succes\n";
                        break;
                    case "ACHAT-ALIMENT":
                        $save = true;
                        $save_flux['type_flux'] = "ALIMENT";
                        $save_flux['statut'] = "ACHAT";
                        $save_flux['qte_gramme'] = $user_data['poids_kg']*1000;
                        $this->save_aliment_stock($save_flux['aliment'], ($user_data['qte_gramme']));
                        $this->navigation->customer_message_answer = "Votre enregistrement a ete fait avec succes\n";
                        break;
                    case "CHANGEMENT-BAC":
                        $save = true;
                        $save_flux['type_flux'] = "POISSON";
                        $save_flux['statut'] = "CHANGEMENT_BAC";
                        $this->save_vague_or_bac_nbre($save_flux['bac_source'], (-1) * $save_flux['nbre']);
                        $this->save_vague_or_bac_nbre($save_flux['bac_destination'], $save_flux['nbre']);
                        $this->navigation->customer_message_answer = "Votre enregistrement a ete fait avec succes\n";
                        break;
                    case "VENTE-POISSON":
                        $save = true;
                        $save_flux['type_flux'] = "POISSON";
                        $save_flux['statut'] = "VENTE";
                        $this->save_vague_or_bac_nbre($save_flux['bac_source'], (-1) * $save_flux['nbre']);
                        $this->save_vague_or_bac_nbre($save_flux['vague'], $save_flux['nbre'], true);
                        $this->navigation->customer_message_answer = "Votre enregistrement a ete fait avec succes\n";
                        break;
                    case "PH0TO-PREUVE":
                        $nbre = $user_data['nbre_photo'];
                        for ($i = 1; $i <= $nbre; $i++) {
                            $to_save_preuve['flux'] = $user_data['id'];
                            $to_save_preuve['date_entree'] = date('Y-m-d H:i:s');
                            $to_save_preuve['photo'] = $user_data['photo_' . $i];
                            $to_save_preuve['description'] = $user_data['description'];
                            $to_save_preuve['agent'] = $user_data['agent'];
                            Preuve::create($to_save_preuve);
                        }
                        $this->navigation->customer_message_answer = "Votre enregistrement a ete fait avec succes\n";
                        break;
                    case "JOURNAL":
                        $date1 = $user_data['date_debut'] . " 00:00:01";
                        $date2 = $user_data['date_fin'] . " 23:59:59";
                        $data = Flux::where('date_action','between',"'$date1' AND '$date2'")->orderBy('date_action', 'desc')->offset(0)->limit(10)->get();
                        $liste = array();
                        foreach ($data as $one) {
                            $temp_message = "ID: " . $one->id . "\n";
                            $agent = CmsUser::findOrFail($one->agent);
                            $temp_message .= "AGENT: " . $agent->name . "\n";
                            if ($one->bac_souce != null) {
                                $bac_source = Bac::findOrFail($one->bac_souce);
                                $temp_message .= "Bac source: " . $bac_source->name . " (" . $bac_source->code . ")\n";
                            }
                            if ($one->bac_destination != null) {
                                $bac_destination = Bac::findOrFail($one->bac_destination);
                                $temp_message .= "Bac destination: " . $bac_destination->name . " (" . $bac_destination->code . ")\n";
                            }
                            if ($one->vague != null) {
                                $vague = Vague::findOrFail($one->vague);
                                $temp_message .= "Vague: " . $vague->name . " (" . $vague->code . ")\n";
                            }
                            if ($one->aliment != null) {
                                $aliment = Aliment::findOrFail($one->aliment);
                                $temp_message .= "Aliment: " . $aliment->name . "\n";
                            }
                            $temp_message .= "DATE: " . $one->date_action . "\n";
                            $temp_message .= "TYPE: " . $one->type_flux . "\n";
                            $temp_message .= "STATUT: " . $one->statut . "\n";
                            $temp_message .= "MASSE(g): " . $one->qte_gramme . "\n";
                            $temp_message .= "Nombre: " . $one->nbre . "\n";
                            $temp_message .= "Cout(unitaire): " . $one->cout_unite . "\n";
                            $temp_message .= "Cout(kg): " . $one->cout_kg . "\n";
                            $temp_message .= "Description: " . $one->description . "\n";
                            $liste[] = $temp_message;
                        }
                        if (empty($liste)) {
                            $this->navigation->customer_message_answer = "Pas de transaction danc cette periode...\n";
                        } else {
                            $this->navigation->customer_message_answer = $liste;
                        }
                        break;
                }
                if ($save) {
                    $flux = Flux::create($save_flux);
                    notify_after_action_flux($flux);
                }
                $this->update_data_collected('', '', true);
                break;
            case "HOME":
                $this->navigation->customer_message_answer = ""
                        . "BONJOUR Mr/Mme Quelle action voullez-vous faire ?\n\n"
                        . "1- Nouvelle vague de poisson\n"
                        . "2- Perte de poisson\n"
                        . "3- Nutrition des poissons\n"
                        . "4- Achat aliment pour poisson\n"
                        . "5- Changement de Bac, tri de poisson\n"
                        . "6- Vente de poisson\n"
                        . "7- Enregistrement photo\n"
                        . "8- Journal";
                break;
            case "NOTFOUND":
                $this->navigation->customer_message_answer = "Desole vous etes pas enregistre dans la base.\n";
                break;
            case "BAC":
                $lesBacs = Bac::orderBy('id','asc')->get(); //$this->get_data_by("*", "bacs", "1=1", '', '', 'id asc');
                $this->navigation->customer_message_answer = "Veillez choisir le bac source\n\n";
                foreach ($lesBacs as $oneBac) {
                    $this->navigation->customer_message_answer .= $oneBac->id . "- " . $oneBac->name . " (" . $oneBac->type_bac . ")\n";
                }
                break;
            case "VAGUE":
                $lesVagues = Vague::orderBy('id','asc')->get();
                $this->navigation->customer_message_answer = "Veillez choisir la vague de poisson\n\n";
                foreach ($lesVagues as $oneVague) {
                    $this->navigation->customer_message_answer .= $oneVague->id . "- " . $oneVague->name . " (" . $oneVague->date_entree . ")\n";
                }
                break;
            case "BAC2":
                $lesBacs = Bac::orderBy('id','asc')->get();
                $this->navigation->customer_message_answer = "Veillez choisir le bac destination\n\n";
                foreach ($lesBacs as $oneBac) {
                    $this->navigation->customer_message_answer .= $oneBac->id . "- " . $oneBac->name . " (" . $oneBac->type_bac . ")\n";
                }
                break;
            case "ALIMENT":
                $lesAliments = Aliment::orderBy('id','asc')->get();
                $this->navigation->customer_message_answer = "Veillez choisir l'aliment\n\n";
                foreach ($lesAliments as $oneFood) {
                    $this->navigation->customer_message_answer .= $oneFood->id . "- " . $oneFood->name . " (" . $oneFood->code . ")\n";
                }
                break;
            case "NBRE":
                $this->navigation->customer_message_answer = "Veillez entrer le nombre\n";
                break;
            case "NBREP":
                $this->navigation->customer_message_answer = "Veillez entrer le nombre de photo a fournir\n";
                break;
            case "QTE":
                $this->navigation->customer_message_answer = "Veillez entrer la quantite en gramme\n";
                break;
            case "DATE1":
                $this->navigation->customer_message_answer = "Veillez entrer la date de debut(ex: 2020-02-20)\n";
                break;
            case "DATE2":
                $this->navigation->customer_message_answer = "Veillez entrer la date de fin (ex: 2021-03-15)\n";
                break;
            case "ID":
                $this->navigation->customer_message_answer = "Veillez le numero de transaction\n";
                break;
            case "PUKG":
                $this->navigation->customer_message_answer = "Veillez entrer le prix du Kg\n";
                break;
            case "PKG":
                $this->navigation->customer_message_answer = "Veillez entrer la masse en Kg\n";
                break;
            case "MESSAGE":
                $this->navigation->customer_message_answer = "Votre commentaire / remarque\n";
                break;
            case "PU":
                $this->navigation->customer_message_answer = "Quel est le prix unitaire\n";
                break;
            case "PDU":
                $this->navigation->customer_message_answer = "Quel est la masse unitaire en gramme\n";
                break;
            case "PHOTO":
                $this->navigation->customer_message_answer = "Veuillez entrez la photo Numero " . $val[2] . "\n";
                break;
        }
    }
    
    private function getStepCode($cle) {
        $liste = array(
            "HOME_1" => "NOUVELLE-VAGUE_BAC",
            "HOME_2" => "PERTE-POISSON_BAC",
            "HOME_3" => "NUTRITION-POISSON_BAC",
            "HOME_4" => "ACHAT-ALIMENT_ALIMENT",
            "HOME_5" => "CHANGEMENT-BAC_BAC",
            "HOME_6" => "VENTE-POISSON_BAC",
            "HOME_7" => "PH0TO-PREUVE_ID",
            "HOME_8" => "JOURNAL_DATE1",
            "JOURNAL_DATE1" => "JOURNAL_DATE2",
            "JOURNAL_DATE2" => "JOURNAL_END",
            "PH0TO-PREUVE_ID" => "PH0TO-PREUVE_NBREP",
            "PH0TO-PREUVE_NBREP" => "PH0TO-PREUVE_PHOTO_1",
            "PH0TO-PREUVE_PHOTO" => "PH0TO-PREUVE_MESSAGE",
            "PH0TO-PREUVE_MESSAGE" => "PH0TO-PREUVE_END",
            "NUTRITION-POISSON_BAC" => "NUTRITION-POISSON_ALIMENT",
            "NUTRITION-POISSON_ALIMENT" => "NUTRITION-POISSON_QTE",
            "NUTRITION-POISSON_QTE" => "NUTRITION-POISSON_MESSAGE",
            "NUTRITION-POISSON_MESSAGE" => "NUTRITION-POISSON_END",
            "ACHAT-ALIMENT_ALIMENT" => "ACHAT-ALIMENT_ALIMENT",
            "ACHAT-ALIMENT_ALIMENT" => "ACHAT-ALIMENT_PKG",
            "ACHAT-ALIMENT_PKG" => "ACHAT-ALIMENT_PUKG",
            "ACHAT-ALIMENT_PUKG" => "ACHAT-ALIMENT_MESSAGE",
            "ACHAT-ALIMENT_MESSAGE" => "ACHAT-ALIMENT_END",
            "CHANGEMENT-BAC_BAC" => "CHANGEMENT-BAC_BAC2",
            "CHANGEMENT-BAC_BAC2" => "CHANGEMENT-BAC_QTE",
            "CHANGEMENT-BAC_QTE" => "CHANGEMENT-BAC_NBRE",
            "CHANGEMENT-BAC_NBRE" => "CHANGEMENT-BAC_MESSAGE",
            "CHANGEMENT-BAC_MESSAGE" => "CHANGEMENT-BAC_END",
            "PERTE-POISSON_BAC" => "PERTE-POISSON_VAGUE",
            "PERTE-POISSON_VAGUE" => "PERTE-POISSON_QTE",
            "PERTE-POISSON_QTE" => "PERTE-POISSON_NBRE",
            "PERTE-POISSON_NBRE" => "PERTE-POISSON_MESSAGE",
            "PERTE-POISSON_MESSAGE" => "PERTE-POISSON_END",
            "VENTE-POISSON_BAC" => "VENTE-POISSON_VAGUE",
            "VENTE-POISSON_VAGUE" => "VENTE-POISSON_QTE",
            "VENTE-POISSON_QTE" => "VENTE-POISSON_NBRE",
            "VENTE-POISSON_NBRE" => "VENTE-POISSON_PU",
            "VENTE-POISSON_PU" => "VENTE-POISSON_PUKG",
            "VENTE-POISSON_PUKG" => "VENTE-POISSON_MESSAGE",
            "VENTE-POISSON_MESSAGE" => "VENTE-POISSON_END",
            "NOUVELLE-VAGUE_BAC" => "NOUVELLE-VAGUE_PDU",
            "NOUVELLE-VAGUE_PDU" => "NOUVELLE-VAGUE_PU",
            "NOUVELLE-VAGUE_PU" => "NOUVELLE-VAGUE_NBRE",
            "NOUVELLE-VAGUE_NBRE" => "NOUVELLE-VAGUE_MESSAGE",
            "NOUVELLE-VAGUE_MESSAGE" => "NOUVELLE-VAGUE_END"
        );
        if (isset($liste[$cle])) {
            return $liste[$cle];
        } else {
            $temp = explode("_", $cle);
            unset($temp[sizeof($temp) - 1]);
            $new_cle = join("_", $temp);
            return isset($liste[$new_cle]) ? $liste[$new_cle] : $cle;
        }
    }
}
