<?php

namespace App\Models;

class Aliment extends GeneralModel {
    protected $table = 'aliments';
    
    protected $fillable = [
        'code',
        'name',
        'stock_en_g',
        'photo',
        'description'
    ];
}
