<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ValidForm{
	
	public static function checkRegexEmail($mail=''){
		$regex = '/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/';
		if (!preg_match($regex, $mail)) {
		    return 'Email đăng nhập sai mẫu. Vui lòng thử lại!';
		}
		return '';
	}

	public static function checkRegexPhone($phone=''){
		//code here
		return '';
	}
}