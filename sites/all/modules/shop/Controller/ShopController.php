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
		
		$txtNameShop= isset($_POST['txtNameShop']) ? trim($_POST['txtNameShop']) : '';
		$txtName 	= isset($_POST['txtName']) ? trim($_POST['txtName']) : '';
		$txtPass 	= isset($_POST['txtPass']) ? trim($_POST['txtPass']) : '';
		$txtRePass 	= isset($_POST['txtRePass']) ? trim($_POST['txtRePass']) : '';
		$txtMobile	= isset($_POST['txtMobile']) ? trim($_POST['txtMobile']) : '';
		$txtEmail	= isset($_POST['txtEmail']) ? trim($_POST['txtEmail']) : '';
		$txtProvice	= isset($_POST['txtProvice']) ? intval($_POST['txtProvice']) : 0;
		$created 	= time();

		$errors = '';
		if($txtNameShop == ''){
			$errors .= 'Tên gian hàng không được trống!<br/>';
		}
		if($txtName == ''){
			$errors .= 'Tên đăng nhập không được trống!<br/>';
		}else{
			$check_name = ValidForm::checkRegexName($txtName);
			if(!$check_name){
				$errors .= 'Tên đăng nhập chỉ gồm các chữ cái, số, dấu gạch dưới và @!<br/>';
			}
		}
		if($txtPass == ''){
			$errors .= 'Mật khẩu ko được trống!<br/>';
		}else{
			$check_pass = ValidForm::checkRegexPass($txtPass, 6);
			if(!$check_pass){
				$errors .= 'Mật khẩu phải không có dấu và lớn hơn 6 ký tự!<br/>';
			}
			if($txtPass != $txtRePass){
				$errors .= 'Mật khẩu nhập không khớp!<br/>';
			}
		}
		if($txtEmail != ''){
			$check_email = ValidForm::checkRegexEmail($txtEmail);
			if(!$check_email){
				$errors .= 'Email sai cấu trúc!<br/>';		
			}
		}
		if($txtMobile == ''){
			$errors .= 'Số điện thoại không được trống!<br/>';
		}elseif($txtMobile != ''){
			$check_phone = ValidForm::checkRegexPhone($txtMobile);
			if(!$check_phone){
				$errors .= 'Số điện thoại sai cấu trúc!<br/>';		
			}
		}
		if($txtProvice == 0){
			$errors .= 'Bạn chọn vui lòng chọn tỉnh/thành!<br/>';
		}
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/dang-ky.html');
		}
		//check user and hash pass
		$check_user_exists = ShopUser::getUserExists($txtName, $txtEmail);
		if($check_user_exists){
			drupal_set_message('Tên đăng nhập hoặc mail đã tồn tại. Vui lòng chọn lại!', 'error');
			drupal_goto($base_url.'/dang-ky.html');
		}else{
			require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
			$hash_pass = user_hash_password(trim($txtPass));
			$data_post = array(
				'name_shop'=>$txtNameShop,
				'name'=>$txtName,
				'pass'=>$hash_pass,
				'phone'=>$txtMobile,
				'mail'=>$txtEmail,
				'provice'=>$txtProvice,
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
		$txtName 	= isset($_POST['txtName']) ? trim($_POST['txtName']) : '';
		$txtPass 	= isset($_POST['txtPass']) ? trim($_POST['txtPass']) : '';

		$errors = '';
		if($txtName == ''){
			$errors .= 'Tên đăng nhập không được trống!<br/>';
		}
		if($txtPass == ''){
			$errors .= 'Mật khẩu không được trống!<br/>';
		}
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/dang-nhập.html');
		}else{
			
		}

	}
	$view = theme('shop-login');
	return $view;
}