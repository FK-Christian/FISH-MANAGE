<?php

namespace App\Models;


class Bac extends GeneralModel {

    protected $table = 'bacs';
    
    protected $fillable = [
        'atelier',
        'code',
        'type_bac',
        'nbre',
        'name',
        'photo',
        'description'
    ];
}
