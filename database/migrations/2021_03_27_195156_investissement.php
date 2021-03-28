<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class Investissement extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up() {
        Schema::create('investissements', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger("agent");
            $table->timestamp('start_date')->useCurrent();
            $table->timestamp('last_modification')->useCurrent();
            $table->double('balance');
            $table->double('max_to_give');
            $table->boolean('status')->default(true);
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
