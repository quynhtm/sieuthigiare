<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/

class RegShopController{

	static $table_action = TABLE_USER_SHOP;
	static $primary_key_user_shop = 'shop_id';
	
	public function registerShop(){
		global $base_url, $user_shop;
		
		if($user_shop->shop_id != 0){
			drupal_goto($base_url);
		}
		$listProvices = DataCommon::getAllProvices();
		if(isset($_POST['txtFormNameRegister'])){
			$user_shop = FunctionLib::getParam('user_shop','');
			$user_password = FunctionLib::getParam('user_password','');
			$rep_user_password = FunctionLib::getParam('rep_user_password','');
			$shop_phone = FunctionLib::getParam('shop_phone','');
			$shop_email = FunctionLib::getParam('shop_email','');
			$shop_province = FunctionLib::getParam('shop_province','');
			$dataInput = array(
							'user_shop'=>array('value'=>trim($user_shop), 'require'=>1, 'messages'=>'Tên đăng nhập không được trống!'),
							'user_password'=>array('value'=>trim($user_password), 'require'=>1, 'messages'=>'Mật khẩu không được trống!'),
							'rep_user_password'=>array('value'=>trim($rep_user_password), 'require'=>1, 'messages'=>'Nhập lại mật khẩu không được trống!'),
							'shop_phone'=>array('value'=>trim($shop_phone), 'require'=>1, 'messages'=>'Số điện thoại không được trống!'),
							'shop_email'=>array('value'=>trim($shop_email), 'require'=>1, 'messages'=>'Email không được trống!'),
							'shop_province'=>array('value'=>trim($shop_province), 'require'=>1, 'messages'=>'Chọn 1 tỉnh thành!'),
							'agree'=>array('value'=>FunctionLib::getParam('agree',''), 'require'=>1, 'messages'=>'Bạn chưa đồng ý với điều khoản của chúng tôi!'),
							'shop_created'=>array('value'=>time(), 'require'=>0, 'messages'=>''),
						);
			
			$errors = ValidForm::validInputData($dataInput);
			$check_valid_name = ValidForm::checkRegexName($dataInput ['user_shop']['value']);
			if(!$check_valid_name){
				$errors .= 'Tên đăng nhập không được có dấu!<br/>';
			}
			$check_valid_mail = ValidForm::checkRegexEmail($dataInput ['shop_email']['value']);
			if(!$check_valid_mail){
				$errors .= 'Email không đúng định dạng!<br/>';
			}
			if($errors != ''){
				drupal_set_message($errors, 'error');
				$optionProvices = FunctionLib::getOption($listProvices, $shop_province);
				return $view = theme('registerShop',
					array('optionProvices' => $optionProvices,
						'user_shop' => $user_shop,
						'user_password' => $user_password,
						'rep_user_password' => $rep_user_password,
						'shop_phone' => $shop_phone,
						'shop_email' => $shop_email
					));
			}

			//check shop and hash pass
			$check_shop_exists = RegShop::checkNamePhoneMail($dataInput['user_shop']['value'], $dataInput['shop_phone']['value'], $dataInput['shop_email']['value']);
			if(!empty($check_shop_exists)){
				$arrError = implode('<br/>', $check_shop_exists);
				drupal_set_message($arrError, 'error');
				drupal_goto($base_url.'/dang-ky.html');
			}else{
				if($dataInput['user_password']['value'] == $dataInput['rep_user_password']['value']){
					$check_valid_pass = ValidForm::checkRegexPass($dataInput['user_password']['value'], 6);
					if($check_valid_pass){
						require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
						$hash_pass = user_hash_password(trim($dataInput ['user_password']['value']));
						$data_post = array(
							'user_shop'=>$dataInput ['user_shop']['value'],
							'user_password'=>$hash_pass,
							'shop_phone'=>$dataInput ['shop_phone']['value'],
							'shop_email'=>$dataInput ['shop_email']['value'],
							'shop_province'=>$dataInput ['shop_province']['value'],
							'is_shop'=>SHOP_FREE,
							'shop_status'=>STASTUS_SHOW,
							'number_limit_product'=>SHOP_NUMBER_PRODUCT_FREE,
							'shop_created'=>$dataInput ['shop_created']['value'],
						);
						$query = RegShop::insert($data_post);
						if($query){
							$getItemUserShop = RegShop::getShopByCond($dataInput ['user_shop']['value']);
							if(!empty($getItemUserShop)){
								$user_shop = $getItemUserShop[0];
								Session::createSessionUserShop($user_shop);

								$data_login = array('time_access'=>time(), 'is_login'=>1);
		    					DB::updateId(self::$table_action, self::$primary_key_user_shop, $data_login, $user_shop->shop_id);
							}
							drupal_set_message('Đăng ký gian hàng thành công!');
							drupal_goto($base_url.'/sua-thong-tin-gian-hang.html');
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

		$optionProvices = FunctionLib::getOption($listProvices, 22);
		$view = theme('registerShop', array('optionProvices' => $optionProvices));
		return $view;
	}

	public function loginShop(){
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
				$arrOneItem = RegShop::getShopByCond($dataInput ['user_shop_login']['value']);
				if(!empty($arrOneItem)){
					$shop_status = $arrOneItem[0]->shop_status;
					if($shop_status == STASTUS_SHOW){
						RegShop::checkLoginShop($arrOneItem[0], $dataInput ['password_shop_login']['value']);
					}else{
						drupal_set_message('Gian hàng của bạn đang bị khóa hoặc chưa kiểm duyệt. Liên hệ với ban quản trị!', 'error');
						drupal_goto($base_url.'/dang-nhap.html');
					}
					
				}else{
					drupal_set_message('Tên đăng nhập hoặc mật khẩu không đúng!', 'error');
					drupal_goto($base_url.'/dang-nhap.html');
				}
			}
		}
		$listProvices = DataCommon::getAllProvices();
		$data = array('listProvices' => $listProvices);

		$view = theme('loginShop', $data);
		return $view;
	}

	public function editInfoShop(){
		global $base_url, $user_shop;
		if($user_shop->shop_id == 0){
			drupal_goto($base_url);
		}

		$files = array(
	       'bootstrap/lib/ckeditor/ckeditor.js',
	       'bootstrap/lib/ckeditor/config.js',
	    );
	    Loader::loadJSExt('Core', $files);

		if(!empty($_POST['frmChangeInfo'])){
			$dataInput = array(
						'shop_category'=>array('value'=>FunctionLib::getIntParam('shop_category',''), 'require'=>1, 'messages'=>'Chọn danh mục sản phẩm!'),
						'shop_name'=>array('value'=>FunctionLib::getParam('shop_name',''), 'require'=>1, 'messages'=>'Tên gian hàng không được trống!'),
						'shop_phone'=>array('value'=>FunctionLib::getParam('shop_phone',''), 'require'=>1, 'messages'=>'Số điện thoại không được trống!'),
						'shop_address'=>array('value'=>FunctionLib::getParam('shop_address',''), 'require'=>0, 'messages'=>''),
						'shop_email'=>array('value'=>FunctionLib::getParam('shop_email',''), 'require'=>1, 'messages'=>'Email không được trống!'),
						'shop_about'=>array('value'=>FunctionLib::getParam('shop_about',''), 'require'=>0, 'messages'=>''),
						'shop_province'=>array('value'=>FunctionLib::getIntParam('shop_province',''), 'require'=>0, 'messages'=>'Chọn tỉnh thành!'),
						'shop_transfer'=>array('value'=>FunctionLib::getParam('shop_transfer',''), 'require'=>0, 'messages'=>''),

					);

			$errors = ValidForm::validInputData($dataInput);
			$check_valid_mail = ValidForm::checkRegexEmail($dataInput ['shop_email']['value']);
			if(!$check_valid_mail){
				$errors .= 'Email không đúng định dạng!<br/>';
			}
			//check phone, mail
			$check_valid_mail_phone = RegShop::checkMailPhoneOfShop($user_shop->shop_id, $dataInput ['shop_email']['value'], $dataInput ['shop_phone']['value']);
			if($check_valid_mail_phone != ''){
				$errors .= $check_valid_mail_phone;
			}
			if($errors != ''){
				drupal_set_message($errors, 'error');
				drupal_goto($base_url.'/sua-thong-tin-gian-hang.html');
			}

			$data_post = array(
				'shop_category'=>$dataInput ['shop_category']['value'],
				'shop_name'=>$dataInput ['shop_name']['value'],
				'shop_phone'=>$dataInput ['shop_phone']['value'],
				'shop_address'=>$dataInput ['shop_address']['value'],
				'shop_email'=>$dataInput ['shop_email']['value'],
				'shop_about'=>$dataInput ['shop_about']['value'],
				'shop_province'=>$dataInput ['shop_province']['value'],
				'shop_transfer'=>$dataInput ['shop_transfer']['value'],
			);

			if($dataInput ['shop_category']['value'] > 0){
				$arrCat = DataCommon::getCategoryById($dataInput ['shop_category']['value']);
				if(!empty($arrCat)){
					$data_post['shop_category_name'] = $arrCat->category_name;
				}
			}
			
			RegShop::updateId($data_post, $user_shop->shop_id);
			if(Cache::CACHE_ON){
				$key_cache = Cache::VERSION_CACHE.Cache::CACHE_USER_SHOP_ID.$user_shop->shop_id;
				$cache = new Cache();
				$cache->do_remove($key_cache);
			}
			drupal_set_message('Cập nhật thông tin gian hàng thành công!');
			drupal_goto($base_url.'/quan-ly-gian-hang.html');
		}
		$listProvinces = DataCommon::getAllProvices();
		$arrCategoryParent = DataCommon::getListCategoryParent();
		$dataCategory['shop_category'] = $user_shop->shop_category;
		$optionCategoryParent = FunctionLib::getOption(array(-1=>'Chọn danh mục cha') + $arrCategoryParent, $dataCategory['shop_category']);

		return $view = theme('editInfoShop', array('listProvinces'=>$listProvinces, 'optionCategoryParent'=>$optionCategoryParent));
	}

	public function editPassShop(){
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

			$arrUser = RegShop::getShopByCond($dataInput['user_shop_login']['value']);
			if(!empty($arrUser) && $arrUser[0]->shop_id == $user_shop->shop_id){
				if($dataInput['user_shop_password']['value'] == $dataInput['user_shop_rep_password']['value']){
					$check_valid_pass = ValidForm::checkRegexPass($dataInput['user_shop_password']['value'], 6);
					if($check_valid_pass){
						require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
						$hash_pass = user_hash_password($dataInput['user_shop_password']['value']);
						$data_post = array(
							'user_password'=>$hash_pass,
						);
						$query = RegShop::updateId($data_post, $user_shop->shop_id);
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
		return $view = theme('editPassShop');
	}

	public function logoutShop(){
		RegShop::logoutShop();
	}

	public function ajaxCheckShopExist(){
		global $base_url, $user_shop;
		
		if($user_shop->shop_id != 0){
			drupal_goto($base_url);
		}
		
		$user_shop = FunctionLib::getParam('user_shop','');
    	$shop_phone = FunctionLib::getParam('shop_phone','');
    	$shop_email = FunctionLib::getParam('shop_email','');
    	$err = RegShop::checkNamePhoneMail($user_shop, $shop_phone, $shop_email);
    	if(!empty($err)){
    		echo json_encode($err);die;
    	}else{
    		echo '';die;
    	}
	}
}