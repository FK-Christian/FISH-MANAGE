<?php

namespace App\Models;

class Vague extends GeneralModel {

    protected $table = 'vagues';
    protected $primaryKey = 'id';
    
    protected $fillable = [
        'agent',
        'date_entree',
        'date_sortie',
        'date_prevu_sortie',
        'name',
        'poids_unite',
        'prix_unite',
        'nbre_entree',
        'nbre_sortie',
        'nbre_perte',
        'description'
    ];

}
