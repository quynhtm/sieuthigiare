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
				$regex = '/^[a-zA-Z0-9_@&#%=~,;\{\}\^\$\.\+\*\?\/\ ]*$/';
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

	public function validInputData($dataInput){
		$errors = array();
		$message = '';
		if(isset($dataInput['name_alias']) && trim($dataInput['name_alias']) == ''){
			$errors[]= 'T�n gian h�ng kh�ng ???c tr?ng!';
		}

		if(isset($dataInput['user_name']) && trim($dataInput['user_name']) == ''){
			$errors[]= 'T�n ??ng nh?p kh�ng ???c tr?ng!';
		}else{
			$check_name = ValidForm::checkRegexName($dataInput['user_name']);
			if(!$check_name){
				$errors[] = 'T�n ??ng nh?p ch? g?m c�c ch? c�i, s?, d?u g?ch d??i v� @!';
			}
		}
		if(isset($dataInput['password']) && trim($dataInput['password']) == ''){
			$errors[]= 'M?t kh?u ko ???c tr?ng!';
		}else{
			$check_pass = ValidForm::checkRegexPass($dataInput['password'], 6);
			if(!$check_pass){
				$errors[]= 'M?t kh?u ph?i kh�ng c� d?u v� l?n h?n 6 k� t?!';
			}
			if(isset($dataInput['password']) && trim($dataInput['password']) != ''
				&& isset($dataInput['rep_password']) && trim($dataInput['rep_password']) != ''
				&& $dataInput['password'] != $dataInput['rep_password']){
				$errors[]= 'M?t kh?u nh?p kh�ng kh?p!';
			}
		}
		if(isset($dataInput['email']) && trim($dataInput['email']) == ''){
			$check_email = ValidForm::checkRegexEmail($dataInput['email']);
			if(!$check_email){
				$errors[]= 'Email sai c?u tr�c!';
			}
		}
		if(isset($dataInput['phone']) && trim($dataInput['phone']) == ''){
			$errors[]= 'S? ?i?n tho?i kh�ng ???c tr?ng!';
		}elseif(isset($dataInput['phone']) && $dataInput['phone'] != ''){
			$check_phone = ValidForm::checkRegexPhone($dataInput['phone']);
			if(!$check_phone){
				$errors[]= 'S? ?i?n tho?i sai c?u tr�c!';
			}
		}
		if(isset($dataInput['provice']) && trim($dataInput['provice']) == ''){
			$errors[]= 'B?n ch?n vui l�ng ch?n t?nh/th�nh!';
		}
		//build l?i th�nh chu?i th�ng b�o
		if(!empty($errors)){
			foreach($errors as $msg){
				$message .= $msg.'<br/>';
			}
		}
		return $message;
	}
}