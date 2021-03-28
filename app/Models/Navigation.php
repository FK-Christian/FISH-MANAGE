<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Navigation extends Model {

    protected $table = 'navigations';
    
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

    public function createdBy() {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function parent() {
        return $this->belongsTo(Document::class, 'parent');
    }

    public function paidBy() {
        return $this->belongsTo(User::class, 'paid_by');
    }

    public function verifiedBy() {
        return $this->belongsTo(User::class, 'verified_by');
    }

    public function activities() {
        return $this->hasMany(Activity::class, 'document_id', 'id')
                        ->orderByDesc('id');
    }
}
