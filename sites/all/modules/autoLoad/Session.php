<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/

class Session{
	
	public static function setAnonymousUserShop() {
		$user_shop = new stdClass();
		if(!isset($_SESSION['user_shop'])){
			$user_shop->shop_id = 0;
			$user_shop->is_login = 0;
		}else{
			$user_shop = $_SESSION['user_shop'];
		}
		return $user_shop;
	}

	public static function createUserShop($obj=null){
		if($obj != null){
			$_SESSION['user_shop'] = $obj;
			return true;
		}
		return false;
	}

	public static function destroyUserShop(){
	  	session_destroy();
	}
}