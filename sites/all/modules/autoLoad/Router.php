<?php 
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0 
*/
function check_login(){
	global $user;
	$isLogin = 0;
	if( in_array('Administrator', $user->roles) || in_array('Manager', $user->roles) ){
		$isLogin = 1;
	}else{
		$isLogin = 0;
	}

	return $isLogin;
}
function router_page(){
	global $base_url;
	$param = arg();
	if(check_login()){
		if($param[0] == 'admincp'){
			if(count($param) == 1){
				$pageAction = 'AdminDefault';
			}elseif(count($param) == 2){
				$pageAction = 'index'.ucfirst($param[1]);
			}else{
				if(isset($param[2]) && $param[2] != ''){
					if(in_array($param[2], array('add', 'edit'))){
						$pageAction = 'form'.ucfirst($param[1]).'Action';
					}else{
						$pageAction = $param[2].ucfirst($param[1]).'Action';						
					}
				}
			}
			
			if(isset($param[1]) && $param[1] != ''){
				$tmpClass = ucfirst($param[1]).'Controller';
			}else{
				$tmpClass = ucfirst($param[0]).'Controller';
			}

			if(class_exists($tmpClass)){
				$routerClass = new $tmpClass();
				return $routerClass->$pageAction();
			}else{
				drupal_goto($base_url);
			}
		}
	}else{
		drupal_goto($base_url);
	}
}

function menuLoad($class_controller=''){
	global $base_url;

	if($class_controller != ''){
		$arrPath = explode('/', $class_controller);
		if(count($arrPath) == 2){
			if(class_exists($arrPath[0])){
				$routerClass = new $arrPath[0]();
				if($arrPath[1] != ''){
					return $routerClass->$arrPath[1]();
				}
			}
		}
	}
	drupal_goto($base_url);
}