<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ValidForm{
	//check regex email
	public static function checkRegexEmail($str=''){
		if($str != ''){
			$regex = '/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/';
			if (!preg_match($regex, $str)){
		    	return false;
			}
			return true;
		}
		return false;
	}
	//check regex url
	public static function checkRegexUrl($str=''){
		if($str != ''){
			$regex = '/\b(?:(?:https?|ftp):\/\/|www\.)[-a-z0-9+&@#\/%?=~_|!:,.;]*[-a-z0-9+&@#\/%=~_|]/i';
			if (!preg_match($regex, $str)){
		    	return false;
			}
			return true;
		}
		return false;
	}
	//check regix name login
	public static function checkRegexName($str=''){
		if($str != ''){
			$regex = '/^[a-zA-Z0-9_@]*$/';
			if (!preg_match($regex, $str)){
		    	return false;
			}
			return true;
		}
		return false;
	}
	//check regix name login
	public static function checkRegexPass($str='', $length=6){
		if($str != '' && $length > 0){
			if(strlen($str) < $length){
				return false;
			}else{
				$regex = '/^[a-zA-Z0-9_@&#%=~,;\{\}\(\)\^\$\.\+\*\?\/\ ]*$/';
				if (!preg_match($regex, $str)){
			    	return false;
				}
				return true;
			}
		}
		return false;
	}
	//check phone number
	public static function checkRegexPhone($str=''){
		if($str != ''){
			$regex = '/^[0-9() -]+$/';
			if (!preg_match($regex, $str)){
		    	return false;
			}
			return true;
		}
		return false;
	}

	//trim, stripslashes, htmlspecialchars string
	public static function input($str='') {
		$str = trim($str);
		$str = stripslashes($str);
		$str = htmlspecialchars($str);
		return $str;
	}

	public static function validInputData($dataInput){
		$errors = array();
		$message = '';
		
		foreach($dataInput as $k=>$v){

			if(isset($v['require']) && $v['require'] == 1){
				if(isset($v['value']) && $v['value'] == ''){
					$errors[] = $v['messages'];
				}
			}
		}
		//build loi thanh chuoi thong bao
		if(!empty($errors)){
			foreach($errors as $msg){
				$message .= $msg.'<br/>';
			}
		}
		return $message;



		if(isset($dataInput['user_name_login']) && trim($dataInput['user_name_login']) == ''){
			$errors[]= 'Tên đăng nhập không được trống!';
		}
		
		if(isset($dataInput['password_login']) && trim($dataInput['password_login']) == ''){
			$errors[]= 'Mật khẩu không được trống!';
		}

		if(isset($dataInput['name_alias']) && trim($dataInput['name_alias']) == ''){
			$errors[]= 'Tên gian hàng không được trống!';
		}

		if(isset($dataInput['user_name']) && trim($dataInput['user_name']) == ''){
			$errors[]= 'Tên đăng nhập không được trống!';
		}elseif(isset($dataInput['user_name']) && trim($dataInput['user_name']) != ''){
			$check_name = ValidForm::checkRegexName($dataInput['user_name']);
			if(!$check_name){
				$errors[] = 'Tên đăng nhập chỉ gồm những chữ cái, số, dấu gạch dưới và @!';
			}
		}
		if(isset($dataInput['password']) && trim($dataInput['password']) == ''){
			$errors[]= 'Mật khẩu không được trống!';
		}elseif(isset($dataInput['password']) && trim($dataInput['password']) != ''){
			$check_pass = ValidForm::checkRegexPass($dataInput['password'], 6);
			if(!$check_pass){
				$errors[]= 'Mật khẩu không được có dấu và lớn hơn 6 ký tự!';
			}
			if(isset($dataInput['password']) && trim($dataInput['password']) != ''
				&& isset($dataInput['rep_password']) && trim($dataInput['rep_password']) != ''
				&& $dataInput['password'] != $dataInput['rep_password']){
				$errors[]= 'Mật khẩu nhập không khớp!';
			}
		}

		if(isset($dataInput['email']) && trim($dataInput['email']) == ''){
			$check_email = ValidForm::checkRegexEmail($dataInput['email']);
			if(!$check_email){
				$errors[]= 'Email sai cấu trúc!';
			}
		}
		if(isset($dataInput['phone']) && trim($dataInput['phone']) == ''){
			$errors[]= 'Số điện thoại không được trống!';
		}elseif(isset($dataInput['phone']) && $dataInput['phone'] != ''){
			$check_phone = ValidForm::checkRegexPhone($dataInput['phone']);
			if(!$check_phone){
				$errors[]= 'Số điện thoại sai cấu trúc!';
			}
		}
		if(isset($dataInput['provice']) && trim($dataInput['provice']) == ''){
			$errors[]= 'Bạn vui lòng chọn tỉnh/thành!';
		}
		if(isset($dataInput['agree']) && trim($dataInput['agree']) == ''){
			$errors[]= 'Bạn chưa đồng ý với điều khoản của chúng tôi!';
		}
		//build lỗi thành chuỗi thông báo
		if(!empty($errors)){
			foreach($errors as $msg){
				$message .= $msg.'<br/>';
			}
		}
		return $message;
	}
}