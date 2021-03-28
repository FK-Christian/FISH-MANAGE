<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class Preuve extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up() {
        Schema::create('preuves', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger("agent");
            $table->unsignedBigInteger("flux");
            $table->timestamp('date_entree')->useCurrent();
            $table->string('photo', 100);
            $table->mediumText('description');
            $table->foreign('agent')->references("cms_users")->on('id');
            $table->foreign('flux')->references("flux_movements")->on('id');
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
