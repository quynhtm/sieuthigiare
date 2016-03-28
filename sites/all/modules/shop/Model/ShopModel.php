<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ShopUser{
	static $table_action = TABLE_USER_SHOP;
	static $table_action_provice = TABLE_PROVINCE;
	static $primary_key_user_shop = 'shop_id';
	static $primary_key_province_shop = 'province_id';

	public static function insert($dataInsert){
		if(!empty($dataInsert)){
			return DB::insertOneItem(self::$table_action, $dataInsert);	
		}
		return false;
	}

	public static function getUserExists($name='', $mail=''){
		if($name != ''){
			return DB:: getItembyCond(self::$table_action, self::$primary_key_user_shop, '', self::$primary_key_user_shop.' ASC', "user_shop='".$name."'", 1);
		}
		if($mail != ''){
			return DB:: getItembyCond(self::$table_action, self::$primary_key_user_shop, '', self::$primary_key_user_shop.' ASC', "shop_email='".$mail."'", 1);
		}
		return false;
	}

	public static function getAllProvices($limit=100){
		if($limit > 0){
			return DB::getItembyCond(self::$table_action_provice, 'province_id, province_name', '', self::$primary_key_province_shop.' ASC', 'province_status=1', $limit);
		}
		return false;
	}

	public static function checkLoginUserShop($user_shop = null, $password = ''){
		global $base_url;
		
		if(is_object($user_shop) && !empty($user_shop) && $password != ''){
			require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');

			$stored_hash = $user_shop->user_password;
			$type = substr($stored_hash, 0, 3);
		
			switch ($type) {
				case '$S$':
					$hash = _password_crypt('sha512', $password, $stored_hash);
					break;
				case '$H$':
				case '$P$':
				      $hash = _password_crypt('md5', $password, $stored_hash);
				      break;
		    	default:
		      		return FALSE;
		    }
		    if($hash && $hash == $stored_hash){
		    	Session::createUserShop($user_shop);
		    	$data_login = array('time_access'=>time(), 'is_login'=>1);
		    	DB::updateId(self::$table_action, self::$primary_key_user_shop, $data_login, $user_shop->shop_id);
		    	drupal_goto($base_url);
		    }else{
		    	drupal_set_message('Tên đăng nhập hoặc mật khẩu không đúng!', 'error');
				drupal_goto($base_url.'/dang-nhap.html');
		    }
		}else{
			drupal_set_message('Tên đăng nhập hoặc mật khẩu không đúng!', 'error');
			drupal_goto($base_url.'/dang-nhap.html');
		}
	}

	public static function logoutUserShop(){
		global $base_url, $user_shop;
		Session::destroyUserShop();
		$data_login = array('time_access'=>time(), 'is_login'=>0);
		DB::updateId(self::$table_action, self::$primary_key_user_shop, $data_login, $user_shop->shop_id);
		drupal_goto($base_url);
	}

}