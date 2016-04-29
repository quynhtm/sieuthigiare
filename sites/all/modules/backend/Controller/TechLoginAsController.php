<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 04/2016
* @Version	 : 1.0
*/

class TechLoginAsController{
	
	function techLoginAs(){
		global $user, $base_url;
		
		if(isset($user->name) && ($user->name == 'admin' || $user->name == 'manager')){
			$check_login = check_login();
			if($check_login){
				$user_shop = FunctionLib::getParam('shop', '');
				if($user_shop != ''){
					$result = TechLoginAs::getShopName($user_shop);
					if(!empty($result)){
						Session::createSessionUserShop($result);
						drupal_goto($base_url.'/quan-ly-gian-hang.html');
					}else{
						drupal_goto($base_url.'/page-404.html');
					}
				}else{
					drupal_goto($base_url.'/page-404.html');
				}
			}else{
				drupal_goto($base_url.'/page-403.html');
			}
		}else{
			drupal_goto($base_url.'/page-403.html');
		}
	}
}