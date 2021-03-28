<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class Navigation extends Migration {

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up() {
        Schema::create('navigations', function (Blueprint $table) {
            $table->string('chat_id',20)->primary();
            $table->string("name",100);
            $table->string('step',100);
            $table->timestamp('last_date')->useCurrent();
            $table->mediumText('data_collected');
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
