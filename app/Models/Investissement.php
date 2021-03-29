<?php

namespace App\Models;

class Investissement extends GeneralModel {

    protected $table = 'investissements';
    
        protected $fillable = [
            'balance',
            'agent',
            'start_date',
            'last_modification',
            'max_to_give'
    ];

}
