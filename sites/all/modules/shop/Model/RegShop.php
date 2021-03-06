<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/

class RegShop{
	static $table_action = TABLE_USER_SHOP;
	static $primary_key_user_shop = 'shop_id';
	static $arrCategoryParent;

	public static function insert($dataInsert){
		if(!empty($dataInsert)){
			return DB::insertOneItem(self::$table_action, $dataInsert);	
		}
		return false;
	}

	public static function updateId($dataUpdate, $id = 0){
		if($id > 0 && !empty($dataUpdate)){
            return DB::updateId(self::$table_action, self::$primary_key_user_shop, $dataUpdate, $id);
		}
		return false;
	}

	public static function getShopByCond($name=''){
		if($name != ''){
			return DB:: getItembyCond(self::$table_action, '', '', self::$primary_key_user_shop.' ASC', "user_shop='".$name."'", 1);
		}
		return false;
	}

	public static function getShopByCondMail($name='', $mail=''){
		if($name !='' && $mail != ''){
			return DB:: getItembyCond(self::$table_action, '', '', self::$primary_key_user_shop.' ASC', "user_shop='".$name."' AND shop_email='".$mail."'", 1);
		}
		return false;
	}
	
	public static function checkNamePhoneMail($name='', $phone='', $mail=''){
		$errors = array();
		if($name != ''){
			$check_name = DB::getItembyCond(self::$table_action, self::$primary_key_user_shop, '', self::$primary_key_user_shop.' ASC', "user_shop='".$name."'", 1);
			if(!empty($check_name)){
				$errors['check_name'] = 'Tên đăng nhập đã tồn tại!';
			}
		}
		if($phone != ''){
			$check_phone = DB::getItembyCond(self::$table_action, self::$primary_key_user_shop, '', self::$primary_key_user_shop.' ASC', "shop_phone='".$phone."'", 1);	
			if(!empty($check_phone)){
				$errors['check_phone'] = 'Số điện thoại đã tồn tại!';
			}
		}
		if($mail != ''){
			$check_mail = DB::getItembyCond(self::$table_action, self::$primary_key_user_shop, '', self::$primary_key_user_shop.' ASC', "shop_email='".$mail."'", 1);	
			if(!empty($check_mail)){
				$errors['check_mail'] = 'Email đã tồn tại!';
			}
		}
		return $errors;
	}

	public static function checkMailPhoneOfShop($shop_id=0, $mail='', $phone=''){
		$errors = '';
		if($shop_id >0 && $phone != '' && $mail != ''){
			$check_mail = DB::getItembyCond(self::$table_action, self::$primary_key_user_shop, '', self::$primary_key_user_shop.' ASC', "shop_email='".$mail."' AND ".self::$primary_key_user_shop.'<>'.$shop_id, 1);
			$check_phone = DB::getItembyCond(self::$table_action, self::$primary_key_user_shop, '', self::$primary_key_user_shop.' ASC', "shop_phone='".$phone."' AND ".self::$primary_key_user_shop.'<>'.$shop_id, 1);
			if(!empty($check_mail)){
				$errors .= 'Email đã tồn tại. Vui lòng nhập lại! <br/>';
			}
			if(!empty($check_phone)){
				$errors .= 'Số điện thoại đã tồn tại. Vui lòng nhập lại! <br/>';
			}
		}else{
			$errors .= 'Bạn vui lòng nhập các trường có dấu (*)! <br/>';
		}
		return $errors;
	}

	public static function checkLoginShop($user_shop = null, $password = ''){
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
		    	Session::createSessionUserShop($user_shop);
		    	$data_login = array('shop_time_login'=>time(), 'is_login'=>1);
		    	DB::updateId(self::$table_action, self::$primary_key_user_shop, $data_login, $user_shop->shop_id);
		    	drupal_goto($base_url.'/danh-sach-don-hang.html');
		    }else{
		    	drupal_set_message('Tên đăng nhập hoặc mật khẩu không đúng!', 'error');
				drupal_goto($base_url.'/dang-nhap.html');
		    }
		}else{
			drupal_set_message('Tên đăng nhập hoặc mật khẩu không đúng!', 'error');
			drupal_goto($base_url.'/dang-nhap.html');
		}
	}

	public static function logoutShop(){
		global $base_url, $user_shop;
		Session::destroySessionUserShop();
		$data_login = array('shop_time_logout'=>time(), 'is_login'=>0);
		DB::updateId(self::$table_action, self::$primary_key_user_shop, $data_login, $user_shop->shop_id);
		drupal_goto($base_url);
	}

}