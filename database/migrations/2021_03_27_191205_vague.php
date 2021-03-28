<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class Vague extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up() {
        Schema::create('vagues', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger("agent");
            $table->timestamp('date_entree')->useCurrent();
            $table->timestamp('date_sortie')->useCurrent();
            $table->timestamp('date_prevu_sortie')->useCurrent();
            $table->string('name',100);
            $table->double('poids_unite');
            $table->double('prix_unite');
            $table->integer('nbre_entree');
            $table->integer('nbre_sortie');
            $table->integer('nbre_perte');
            $table->mediumText('description');
            $table->foreign('agent')->references("cms_users")->on('id');
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
