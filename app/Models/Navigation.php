<?php

namespace App\Models;

class Navigation extends GeneralModel {

    protected $table = 'navigations';
    protected $primaryKey = 'chat_id';
    protected $casts = [];
    protected $dates = ['last_date'];
    protected $fillable = [
        'chat_id',
        'name',
        'step',
        'last_date',
        'data_collected'
    ];
    public static $rules = [
        'name' => 'required',
        'description' => 'nullable',
        'step' => 'required',
        'last_date' => 'required'
    ];

}
