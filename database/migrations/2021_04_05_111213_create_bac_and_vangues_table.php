<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBacAndVanguesTable extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up() {
        Schema::create('bac_and_vangues', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('bac');
            $table->unsignedInteger('vague');
            $table->integer("nbre");
            $table->timestamps();
            $table->foreign('bac')->references("bacs")->on('id');
            $table->foreign('vague')->references("vagues")->on('id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down() {
        Schema::dropIfExists('bac_and_vangues');
    }

}
