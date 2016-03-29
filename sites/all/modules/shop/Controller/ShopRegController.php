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
		$check_user_exists = ShopUser::getUserExists($dataInput ['user_shop']['value']);

		if($check_user_exists){
			drupal_set_message('Tên đăng nhập hoặc email đã tồn tại. Vui lòng chọn lại!', 'error');
			drupal_goto($base_url.'/dang-ky.html');
		}else{
			if($dataInput['user_password']['value'] == $dataInput['rep_user_password']['value']){
				$check_valide = ValidForm::checkRegexPass($dataInput['user_password']['value'], 6);
				if($check_valide){
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
						drupal_set_message('Đăng ký gian hàng thành công!');
						drupal_goto($base_url);
					}
				}else{
					drupal_set_message('Mật khẩu không được có dấu và phải lớn hơn 6 ký tự!', 'error');
					drupal_goto($base_url.'/dang-ky.html');
				}
			}else{
				drupal_set_message('Mật khẩu không khớp và phải lớn hơn 6 ký tự!', 'error');
				drupal_goto($base_url.'/dang-ky.html');
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

function shopEditInfo(){
	global $base_url, $user_shop;
	if($user_shop->shop_id == 0){
		drupal_goto($base_url);
	}
	if(!empty($_POST['frmChangeInfo'])){
		$dataInput = array(
					'shop_name'=>array('value'=>FunctionLib::getParam('shop_name',''), 'require'=>1, 'messages'=>'Tên gian hàng không được trống!'),
					'shop_phone'=>array('value'=>FunctionLib::getParam('shop_phone',''), 'require'=>1, 'messages'=>'Số điện thoại không được trống!'),
					'shop_address'=>array('value'=>FunctionLib::getParam('shop_address',''), 'require'=>0, 'messages'=>''),
					'shop_email'=>array('value'=>FunctionLib::getParam('shop_email',''), 'require'=>1, 'messages'=>'Email không được trống!'),
					'shop_about'=>array('value'=>FunctionLib::getParam('shop_about',''), 'require'=>0, 'messages'=>''),
					'shop_province'=>array('value'=>FunctionLib::getParam('shop_province',''), 'require'=>0, 'messages'=>'Chọn 1 tỉnh thành!'),
				);
		$errors = ValidForm::validInputData($dataInput);
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/sua-thong-tin-gian-hang.html');
		}
		$data_post = array(
			'shop_name'=>$dataInput ['shop_name']['value'],
			'shop_phone'=>$dataInput ['shop_phone']['value'],
			'shop_address'=>$dataInput ['shop_address']['value'],
			'shop_email'=>$dataInput ['shop_email']['value'],
			'shop_about'=>$dataInput ['shop_about']['value'],
			'shop_province'=>0,
		);

		$query = ShopUser::updateId($data_post, $user_shop->shop_id);
		if($query){
			drupal_set_message('Cập nhật thông tin gian hàng thành công!');
			drupal_goto($base_url.'/quan-ly-gian-hang.html');
		}
	}
	return $view = theme('shopEditInfo');
}

function shopEditPassword(){
	global $base_url, $user_shop;

	if($user_shop->shop_id == 0){
		drupal_goto($base_url);
	}
	if(isset($_POST['frmEditPass'])){
		$dataInput = array(
						'user_shop_login'=>array('value'=>FunctionLib::getParam('user_shop_login',''), 'require'=>1, 'messages'=>'Tên đăng nhập không được trống!'),
						'user_shop_password'=>array('value'=>FunctionLib::getParam('user_shop_password',''), 'require'=>1, 'messages'=>'Mật khẩu không được trống!'),
						'user_shop_rep_password'=>array('value'=>FunctionLib::getParam('user_shop_rep_password',''), 'require'=>1, 'messages'=>'Nhập lại mật khẩu không được trống!'),
					);
		
		$errors = ValidForm::validInputData($dataInput);
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/doi-mat-khau.html');
		}

		$arrUser = ShopUser::getUserExists($dataInput['user_shop_login']['value']);
		if(!empty($arrUser) && $arrUser[0]->shop_id == $user_shop->shop_id){
			if($dataInput['user_shop_password']['value'] == $dataInput['user_shop_rep_password']['value']){
				$check_valide = ValidForm::checkRegexPass($dataInput['user_shop_password']['value'], 6);
				if($check_valide){
					require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
					$hash_pass = user_hash_password($dataInput['user_shop_password']['value']);
					$data_post = array(
						'user_password'=>$hash_pass,
					);
					$query = ShopUser::updateId($data_post, $user_shop->shop_id);
					if($query){
						drupal_set_message('Đổi mật khẩu thành công!');
						drupal_goto($base_url.'/quan-ly-gian-hang.html');
					}
				}else{
					drupal_set_message('Mật khẩu không được có dấu và phải lớn hơn 6 ký tự!', 'error');
					drupal_goto($base_url.'/doi-mat-khau.html');
				}
			}else{
				drupal_set_message('Mật khẩu không khớp và phải lớn hơn 6 ký tự!', 'error');
				drupal_goto($base_url.'/doi-mat-khau.html');
			}
		}else{
			drupal_set_message('Tên đăng nhập của bạn không đúng!', 'error');
			drupal_goto($base_url.'/doi-mat-khau.html');
		}
	}
	return $view = theme('shopEditPassword');
}

function shopLogout(){
	ShopUser::logoutUserShop();
}
