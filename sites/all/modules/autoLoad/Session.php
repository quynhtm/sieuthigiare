<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/

class Session{
	static $session_time_out = 3600;
	static $table_user_shop = TABLE_USER_SHOP;
	static $primary_key_user_shop = 'shop_id';

	public static function setAnonymousUserShop() {
		global $user_shop;

		if(!isset($_SESSION['user_shop'])){
			$user_shop = new stdClass();
			$user_shop->shop_id = 0;
			$user_shop->is_login = 0;
		}else{
			$user_shop = $_SESSION['user_shop'];
			if(isset($user_shop->expires) && self::$session_time_out <= time() - $user_shop->expires){
				$user_shop = new stdClass();
				$user_shop->shop_id = 0;
				$user_shop->is_login = 0;
				session_destroy();
			}else{
				$get_user_shop = DB::getItembyCond(self::$table_user_shop, '*', '', self::$primary_key_user_shop.' ASC', self::$primary_key_user_shop.'='.$user_shop->shop_id, 1);
				if(!empty($get_user_shop)){
					$user_shop = $get_user_shop[0];
				}
				$user_shop->expires = time() + self::$session_time_out;
				$_SESSION['user_shop'] = $user_shop;
			}
		}
		return $user_shop;
	}

	public static function createUserShop($obj=null){
		if($obj != null){
			if(!isset($obj->expires)){
				$obj->expires = time() + self::$session_time_out;
			}
			$_SESSION['user_shop'] = $obj;
			return true;
		}
		return false;
	}

	public static function destroyUserShop(){
	  	session_destroy();
	}
}