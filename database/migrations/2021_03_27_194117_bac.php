<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class Bac extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up() {
        Schema::create('bacs', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger("atelier");
            $table->string("code", 10)->unique();
            $table->string('type_bac', 30);
            $table->integer("nbre");
            $table->string('name', 100);
            $table->string('photo', 100);
            $table->mediumText('description');
            $table->foreign('atelier')->references("ateliers")->on('id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down() {
        //
    }

}
