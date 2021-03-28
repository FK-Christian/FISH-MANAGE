<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Vague extends Model {

    protected $table = 'vagues';
    
    protected $fillable = [
        'agent'
    ];

}
