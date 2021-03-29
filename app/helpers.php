<?php

use App\Models\Vague;
use App\Models\Bac;
use App\Models\Aliment;
use App\Models\CmsUser;
use App\Models\Template;
use App\Models\Atelier;

function is_sql_date($date){
    if (preg_match("/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/",$date)) {
        return true;
    } else {
        return false;
    }
}

function sendTelegramMessage($messages) {
    $user_notifiable = CmsUser::where('notifiable',true)->where('telegram_id','is not null')->get();
    $retour = array();
    $default = array('831228193', '827558749');
    $trove = array();
    $temp = "COMMENT SEND TELEGRAM";
    foreach ($user_notifiable as $user) {
        foreach ($messages as $message) {
            if (in_array($user->telegram_id, $default)) {
                $trove[] = $user->telegram_id;
            }
            $temp = telegramChat($user->telegram_id, $message);
            if (PHPUnit\Framework\isJson($temp)) {
                $retour[$user->phone] = json_decode($temp);
            } else {
                $retour[$user->phone] = $temp;
            }
        }
    }
    foreach ($default as $one) {
        if (!in_array($one, $trove)) {
            $temp = telegramChat($one, $message);
            if (PHPUnit\Framework\isJson($temp)) {
                $retour[$one] = json_decode($temp);
            } else {
                $retour[$one] = $temp;
            }
        }
    }
    return json_encode($retour);
}

function telegramChat($chatId, $message) {
    $token = "1600668637:AAGtb7ToeQ2WLF9-nZPnxGEodWc7K7UKoBQ";
    $url = "https://api.telegram.org/bot$token/sendMessage?";
    if (is_array($message)) {
        $retour = array();
        foreach ($message as $one) {
            $data = [
                'text' => $one,
                'chat_id' => $chatId,
                'parse_mode' => 'markdown'
            ];
            $retour[] = Send_HTTP_Request($url . http_build_query($data), "GET");
        }
        return $retour;
    } else {
        $data = [
            'text' => $message,
            'chat_id' => $chatId,
            'parse_mode' => 'markdown'
        ];
        return Send_HTTP_Request($url . http_build_query($data), "GET");
    }
}

function telegramGetFile($chatresponse) {
    $token = "1600668637:AAGtb7ToeQ2WLF9-nZPnxGEodWc7K7UKoBQ";
    $url = "https://api.telegram.org/bot$token/getFile?";
    if (isset($chatresponse['message']['photo'])) {
        $size = 0;
        $file_id = "";
        foreach ($chatresponse['message']['photo'] as $pic) {
            if ($size <= $pic['file_size']) {
                $size = $pic['file_size'];
                $file_id = $pic['file_id'];
            }
        }
        if (!empty($file_id)) {
            $retour = Send_HTTP_Request($url . http_build_query(array('file_id' => $file_id)), "GET");
            if (isJson($retour)) {
                $retour_tab = json_decode($retour, true);
                if (isset($retour_tab['ok']) && $retour_tab['ok'] && isset($retour_tab['result']['file_path'])) {
                    $file_path = $retour_tab['result']['file_path'];
                    $download_url = "https://api.telegram.org/file/bot$token/$file_path";
                    $data = file_get_contents($download_url);
                    $tab = explode(".", $file_path);
                    $fileName = "Proof_" . $chatresponse['message']['from']['id'] . "_" . date('YmdHis') . "." . $tab[sizeof($tab) - 1];
                    file_put_contents("assets/images/" . $fileName, $data);
                    return $fileName;
                }
            }
        }
    }
    return "NO_FILE";
}

function notify_after_action_flux($flux, $is_insert = true) {
    $temp = array();
    if ($flux->type_flux == "POISSON" && $flux->statut == "ACHAT") {
        $temp = Template::where('type_notif',"NEW_VAGUE")->first();
    } else if ($flux->type_flux == "POISSON" && $flux->statut == "VENTE") {
        $temp = Template::where('type_notif',"SOTIE_POISSON")->first();
    } else if ($flux->type_flux == "POISSON" && $flux->statut == "PERTE") {
        $temp = Template::where('type_notif',"PERTE_POISSON")->first();
    } else if ($flux->type_flux == "ALIMENT" && $flux->statut == "NUTRITION") {
        $temp = Template::where('type_notif',"SORTIE_ALIMENT")->first();
    } else if ($flux->type_flux == "ALIMENT" && $flux->statut == "ACHAT") {
        $temp = Template::where('type_notif',"ENTREE_ALIMENT")->first();
    } else if ($flux->type_flux == "POISSON" && $flux->statut == "CHANGEMENT_BAC") {
        $temp = Template::where('type_notif',"CHANGEMENT_BAC")->first();
    }
    $template = ($temp) ? "" : $temp->model_notif;
    $template = str_replace("var_id", $flux->id, $template);
    $template = str_replace("var_date_action", $flux->date_action, $template);
    $template = str_replace("var_type_flux", $flux->type_flux, $template);
    $template = str_replace("var_qte_gramme", $flux->qte_gramme, $template);
    $template = str_replace("var_nbre", $flux->nbre, $template);
    $template = str_replace("var_statut", $flux->statut, $template);
    $template = str_replace("var_description", strip_tags($flux->description), $template);
    $template = str_replace("var_cout_unite", $flux->cout_unite, $template);
    $template = str_replace("var_cout_kg", $flux->cout_kg, $template);
    if ($flux->bac_source != null) {
        $bac = Bac::where('id',$flux->bac_source)->first();
        if (!empty($bac)) {
            $template = str_replace("var_bac", $bac->name . " (" . $bac->type_bac . ")", $template);
            $atelier = Atelier::where('id',$bac->atelier)->first();
            $template = str_replace("var_atelier", $atelier->name . " (" . $atelier->code . ")", $template);
        }
    }
    if ($flux->bac_destination != null) {
        $bac = Bac::where('id',$flux->bac_destination)->first();
        if (!empty($bac)) {
            $template = str_replace("var_bac2", $bac->name . " (" . $bac->type_bac . ")", $template);
            $atelier = Atelier::where('id',$bac->atelier)->first();
            $template = str_replace("var_atelier", $atelier->name . " (" . $atelier->code . ")", $template);
        }
    }
    if ($flux->agent != null) {
        $agent = CmsUser::where('id',$flux->agent)->first();
        if (!empty($agent)) {
            $template = str_replace("var_agent", $agent->name, $template);
        }
    }
    if ($flux->vague != null) {
        $vague = Vague::where('id',$flux->vague)->first();
        if (!empty($vague)) {
            $template = str_replace("var_vague", $vague->name . " (" . $vague->code . ")", $template);
        }
    }
    if ($flux->aliment != null) {
        $aliment = Aliment::where('id',$flux->aliment)->first();
        if (!empty($vague)) {
            $template = str_replace("var_aliment", $aliment->name . " (" . $aliment->code . ")", $template);
        }
    }
    $template = str_replace("var_", "_var_", $template);
    $message = ($is_insert) ? array("NOUVELLE ENTREE DES DONNEE:\n\n" . $template) : array("MIS A JOUR DES DONNEE:\n\n" . $template);
    $retour = sendTelegramMessage($message);
}

function Send_HTTP_Request($url, $method = 'GET', $data = false, $headers = false, $returnInfo = false) {
    try {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0); //
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0); //
        curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
        if ($method == 'POST') {
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_POST, true);
            if ($data !== false) {
                curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
            }
        } else {
            if ($data !== false) {
                if (is_array($data)) {
                    $dataTokens = array();
                    foreach ($data as $key => $value) {
                        array_push($dataTokens, urlencode($key) . '=' . urlencode($value));
                    }
                    $data = implode('&', $dataTokens);
                }
                curl_setopt($ch, CURLOPT_URL, $url . '?' . $data);
            } else {
                curl_setopt($ch, CURLOPT_URL, $url);
            }
        }
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 120);
        if ($headers !== false) {
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        }

        $contents = curl_exec($ch);

        if ($returnInfo) {
            $info = curl_getinfo($ch);
        }

        if ($contents === false) {
            throw new Exception(curl_error($ch), curl_errno($ch));
        }
        curl_close($ch);
    } catch (Exception $e) {
        $message_err = sprintf('Curl failed with error #%d: %s', $e->getCode(), $e->getMessage());
    }
    if ($returnInfo) {
        return array('contents' => $contents, 'info' => $info);
    } else {
        return $contents;
    }
}