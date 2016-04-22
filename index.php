<?php
try{
	define('DRUPAL_ROOT', getcwd());
	
	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL);

	require_once DRUPAL_ROOT . '/includes/bootstrap.inc';
	drupal_bootstrap(DRUPAL_BOOTSTRAP_FULL);
	menu_execute_active_handler();
}catch(Exception $e){
    echo 'Caught exception: ',  $e->getMessage(), "\n";
}