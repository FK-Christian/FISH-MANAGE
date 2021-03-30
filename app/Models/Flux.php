<?php

namespace App\Models;

class Flux extends GeneralModel {

    protected $table = 'flux_movements';
    
    protected $fillable = [
        'charge',
        'investissement',
        'bac_source',
        'bac_destination',
        'vague',
        'aliment',
        'agent',
        'date_action',
        'type_flux',
        'qte_gramme',
        'nbre',
        'statut',
        'cout_unite',
        'cout_kg',
        'caisse_avant',
        'caisse_apres',
        'description'
    ];
}
