<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class FluxMovement extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up() {
        Schema::create('flux_movements', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger("charge")->nullable();
            $table->unsignedInteger("investissement")->nullable();
            $table->unsignedInteger("bac_source")->nullable();
            $table->unsignedInteger("bac_destination")->nullable();
            $table->unsignedInteger("vague")->nullable();
            $table->unsignedInteger("aliment")->nullable();
            $table->unsignedInteger("agent");
            $table->timestamp('date_action')->useCurrent();
            $table->string('type_flux',20);
            $table->double('qte_gramme');
            $table->integer('nbre');
            $table->string('statut',20);
            $table->double('cout_unite');
            $table->double('cout_kg');
            $table->mediumText('description');
            $table->foreign('charge')->references("charges")->on('id');
            $table->foreign('investissement')->references("investissements")->on('id');
            $table->foreign('bac_source')->references("bacs")->on('id');
            $table->foreign('bac_destination')->references("bacs")->on('id');
            $table->foreign('vague')->references("vagues")->on('id');
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
