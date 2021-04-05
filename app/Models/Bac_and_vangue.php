<?php

namespace App\Models;

class Bac_and_vangue extends GeneralModel {
    protected $table = 'bac_and_vangues';
    protected $fillable = [
        'id',
        'bac',
        'vague',
        'nbre'
    ];
}
