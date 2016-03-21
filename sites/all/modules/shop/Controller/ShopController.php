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
		$dataInput ['name_alias'] = FunctionLib::getParam('txtNameShop','');
		$dataInput ['user_name'] = FunctionLib::getParam('txtName','');
		$dataInput ['password'] = FunctionLib::getParam('txtPass','');
		$dataInput ['rep_password'] = FunctionLib::getParam('txtRePass','');
		$dataInput ['phone'] = FunctionLib::getParam('txtMobile','');
		$dataInput ['email'] = FunctionLib::getParam('txtEmail','');
		$dataInput ['provice'] = FunctionLib::getParam('txtProvice','');
		$created 		= time();

		$errors = ValidForm::validInputData($dataInput);
		if($errors != ''){
			drupal_set_message($errors, 'error');
		}
		//check user and hash pass
		$check_user_exists = ShopUser::getUserExists($dataInput ['user_name'], $dataInput ['email']);
		if($check_user_exists){
			drupal_set_message('Tên đăng nhập hoặc mail đã tồn tại. Vui lòng chọn lại!', 'error');
		}else{
			require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
			$hash_pass = user_hash_password(trim($dataInput ['password']));
			$data_post = array(
				'name_shop'=>$dataInput ['name_alias'],
				'name'=>$dataInput ['user_name'],
				'pass'=>$hash_pass,
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
	$view = theme('shop-login');
	return $view;
}