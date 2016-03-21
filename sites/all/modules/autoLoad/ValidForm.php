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
	//trim, stripslashes, htmlspecialchars string
	public static function input($str='') {
		$str = trim($str);
		$str = stripslashes($str);
		$str = htmlspecialchars($str);
		return $str;
	}
}