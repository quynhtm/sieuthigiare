<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
function shopRegister(){
	global $base_url;
	
	if(isset($_POST['txtFormNameRegister'])){
		$dataInput = array();
		$dataInput ['name_alias'] = FunctionLib::getParam('name_alias','');
		$dataInput ['user_name'] = FunctionLib::getParam('user_name','');
		$dataInput ['password'] = FunctionLib::getParam('password','');
		$dataInput ['rep_password'] = FunctionLib::getParam('rep_password','');
		$dataInput ['phone'] = FunctionLib::getParam('phone','');
		$dataInput ['email'] = FunctionLib::getParam('email','');
		$dataInput ['provice'] = FunctionLib::getParam('provice','');
		$created 		= time();
		$errors = ValidForm::validInputData($dataInput);
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/dang-ky.html');
		}
		//check user and hash pass
		$check_user_exists = ShopUser::getUserExists($dataInput ['user_name'], $dataInput ['email']);
		if($check_user_exists){
			drupal_set_message('Tên đăng nhập hoặc mail đã tồn tại. Vui lòng chọn lại!', 'error');
			drupal_goto($base_url.'/dang-ky.html');
		}else{
			require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
			$hash_pass = user_hash_password(trim($dataInput ['password']));
			$data_post = array(
				'name_shop'=>$dataInput ['name_alias'],
				'user_name'=>$dataInput ['user_name'],
				'user_password'=>$hash_pass,
				'phone'=>$dataInput ['phone'],
				'mail'=>$dataInput ['mail'],
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
	global $base_url;
	if(isset($_POST['txtFormNameLogin'])){
		
		$dataInput = array();
		$dataInput ['user_name_login'] = FunctionLib::getParam('user_name','');
		$dataInput ['password_login'] = FunctionLib::getParam('password','');
		
		$errors = ValidForm::validInputData($dataInput);
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/dang-nhập.html');
		}else{

		}
	}
	$view = theme('shop-login');
	return $view;
}