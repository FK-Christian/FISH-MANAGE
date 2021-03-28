<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Schema;

class AppServiceProvider extends ServiceProvider {

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register() {
        $loader = \Illuminate\Foundation\AliasLoader::getInstance();  
        $loader->alias('CRUDBooster', 'App\Crudbooster\helpers\BaseCRUDBooster');
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot() {
        Schema::defaultStringLength(191);
    }

}
