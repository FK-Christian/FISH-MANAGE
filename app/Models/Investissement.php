<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Investissement extends Model {

    protected $table = 'investissements';
    
        protected $fillable = [
            'balance',
            'agent',
            'start_date',
            'last_modification',
            'max_to_give'
    ];

}
