<?php

namespace App\Models;

class Atelier extends GeneralModel {

    protected $table = 'ateliers';
    
    protected $fillable = [
        'code',
        'name',
        'photo',
        'description'
    ];
}
