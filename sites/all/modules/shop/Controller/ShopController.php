<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
function shopRegister(){
	global $base_url, $user_shop;
	
	if($user_shop->id != 0){
		drupal_goto($base_url);
	}

	if(isset($_POST['txtFormNameRegister'])){
		
		$dataInput = array();
		$dataInput ['user_name'] = FunctionLib::getParam('user_name','');
		$dataInput ['password'] = FunctionLib::getParam('password','');
		$dataInput ['rep_password'] = FunctionLib::getParam('rep_password','');
		$dataInput ['phone'] = FunctionLib::getParam('phone','');
		$dataInput ['email'] = FunctionLib::getParam('email','');
		$dataInput ['provice'] = FunctionLib::getParam('provice','');
		$dataInput ['agree'] = FunctionLib::getParam('agree','');
		$created 		= time();
		$errors = ValidForm::validInputData($dataInput);
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/dang-ky.html');
		}
		//check user and hash pass
		$check_user_exists = ShopUser::getUserExists($dataInput ['user_name'], $dataInput ['email']);

		if($check_user_exists){
			drupal_set_message('Tên đăng nhập hoặc email đã tồn tại. Vui lòng chọn lại!', 'error');
			drupal_goto($base_url.'/dang-ky.html');
		}else{
			require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
			$hash_pass = user_hash_password(trim($dataInput ['password']));
			$data_post = array(
				'user_name'=>$dataInput ['user_name'],
				'user_password'=>$hash_pass,
				'phone'=>$dataInput ['phone'],
				'email'=>$dataInput ['email'],
				'provice'=>$dataInput ['provice'],
				'is_shop'=>0,
				'status'=>0,
				'created'=>$created,
			);
			$query = ShopUser::insert($data_post);
			if($query){
				drupal_set_message('Đăng ký gian hàng thanh công!');
				drupal_goto($base_url);
			}
		}
	}
	$listProvices = ShopUser::getAllProvices(100);
	$data = array('listProvices' => $listProvices);

	$view = theme('shop-register', $data);
	return $view;
}

function shopLogin(){
	global $base_url, $user_shop;
	
	if($user_shop->id != 0){
		drupal_goto($base_url);
	}

	if(isset($_POST['txtFormNameLogin'])){
		
		$dataInput = array();
		$dataInput ['user_name_login'] = FunctionLib::getParam('user_name','');
		$dataInput ['password_login'] = FunctionLib::getParam('password','');
		
		$errors = ValidForm::validInputData($dataInput);
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/dang-nhập.html');
		}else{
			$arrOneItem = ShopUser::getUserExists($dataInput ['user_name_login']);
			if(!empty($arrOneItem)){
				ShopUser::checkLoginUserShop($arrOneItem[0], $dataInput ['password_login']);
			}else{
				drupal_set_message('Tên đăng nhập hoặc mật khẩu không đúng!', 'error');
				drupal_goto($base_url.'/dang-nhập.html');
			}
		}
	}
	$listProvices = ShopUser::getAllProvices(100);
	$data = array('listProvices' => $listProvices);

	$view = theme('shop-login', $data);
	return $view;
}

function shopLogout(){
	ShopUser::logoutUserShop();
}
