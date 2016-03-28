<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
function shopRegister(){
	global $base_url, $user_shop;
	
	if($user_shop->shop_id != 0){
		drupal_goto($base_url);
	}

	if(isset($_POST['txtFormNameRegister'])){
		
		$dataInput = array(
						'user_shop'=>array('value'=>FunctionLib::getParam('user_shop',''), 'require'=>1, 'messages'=>'Tên đăng nhập không được trống!'),
						'user_password'=>array('value'=>FunctionLib::getParam('user_password',''), 'require'=>1, 'messages'=>'Mật khẩu không được trống!'),
						'rep_user_password'=>array('value'=>FunctionLib::getParam('rep_user_password',''), 'require'=>1, 'messages'=>'Nhập lại mật khẩu không được trống!'),
						'shop_phone'=>array('value'=>FunctionLib::getParam('shop_phone',''), 'require'=>1, 'messages'=>'Số điện thoại không được trống!'),
						'shop_email'=>array('value'=>FunctionLib::getParam('shop_email',''), 'require'=>1, 'messages'=>'Email được trống!'),
						'shop_province'=>array('value'=>FunctionLib::getParam('shop_province',''), 'require'=>1, 'messages'=>'Chọn 1 tỉnh thành!'),
						'agree'=>array('value'=>FunctionLib::getParam('agree',''), 'require'=>1, 'messages'=>'Bạn chưa đồng ý với điều khoản của chúng tôi!'),
						'shop_created'=>array('value'=>time(), 'require'=>0, 'messages'=>''),
					);
		
		$errors = ValidForm::validInputData($dataInput);
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/dang-ky.html');
		}
		//check user and hash pass
		$check_user_exists = ShopUser::getUserExists($dataInput ['user_shop']['value'], $dataInput ['shop_email']['value']);

		if($check_user_exists){
			drupal_set_message('Tên đăng nhập hoặc email đã tồn tại. Vui lòng chọn lại!', 'error');
			drupal_goto($base_url.'/dang-ky.html');
		}else{
			require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
			$hash_pass = user_hash_password(trim($dataInput ['user_password']['value']));
			$data_post = array(
				'user_shop'=>$dataInput ['user_shop']['value'],
				'user_password'=>$hash_pass,
				'shop_phone'=>$dataInput ['shop_phone']['value'],
				'shop_email'=>$dataInput ['shop_email']['value'],
				'shop_province'=>$dataInput ['shop_province']['value'],
				'is_shop'=>0,
				'shop_status'=>0,
				'shop_created'=>$dataInput ['shop_created']['value'],
			);
			$query = ShopUser::insert($data_post);
			if($query){
				drupal_set_message('Đăng ký gian hàng thanh công!');
				drupal_goto($base_url);
			}
		}
	}
	$listProvices = ShopUser::getAllProvices(200);
	$data = array('listProvices' => $listProvices);

	$view = theme('shopRegister', $data);
	return $view;
}

function shopLogin(){
	global $base_url, $user_shop;
	
	if($user_shop->shop_id != 0){
		drupal_goto($base_url);
	}

	if(isset($_POST['txtFormNameLogin'])){
		
		$dataInput = array(
						'user_shop_login'=>array('value'=>FunctionLib::getParam('user_shop_login',''), 'require'=>1, 'messages'=>'Tên đăng nhập không được trống!'),
						'password_shop_login'=>array('value'=>FunctionLib::getParam('password_shop_login',''), 'require'=>1, 'messages'=>'Mật khẩu không được trống!'),
					);
		
		$errors = ValidForm::validInputData($dataInput);
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/dang-nhap.html');
		}else{
			$arrOneItem = ShopUser::getUserExists($dataInput ['user_shop_login']['value']);
			if(!empty($arrOneItem)){
				ShopUser::checkLoginUserShop($arrOneItem[0], $dataInput ['password_shop_login']['value']);
			}else{
				drupal_set_message('Tên đăng nhập hoặc mật khẩu không đúng!', 'error');
				drupal_goto($base_url.'/dang-nhap.html');
			}
		}
	}
	$listProvices = ShopUser::getAllProvices(200);
	$data = array('listProvices' => $listProvices);

	$view = theme('shopLogin', $data);
	return $view;
}

function shopLogout(){
	ShopUser::logoutUserShop();
}
