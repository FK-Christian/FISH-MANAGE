<?php

namespace App\Models;

class Preuve extends GeneralModel {

    protected $table = 'preuves';
    
    protected $fillable = [
        'agent',
        'flux',
        'date_entree',
        'photo',
        'description'
    ];
}
