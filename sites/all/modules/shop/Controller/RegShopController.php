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

								$data_login = array('shop_time_login'=>time(), 'is_login'=>1);
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

	    $files = array(
			'bootstrap/lib/upload/cssUpload.css',
			'bootstrap/js/bootstrap.min.js',
			'bootstrap/lib/upload/jquery.uploadfile.js',
			'js/common_admin.js',
		);
		Loader::load('Core', $files);

		if(!empty($_POST['frmChangeInfo'])){
			$selectCateParent = FunctionLib::getParam('shop_category',array());
			$arrCateParent = (count($selectCateParent) > 2)? array_rand($selectCateParent,2): $selectCateParent;//lay 2 danh muc cha
			$shop_category = !empty($arrCateParent)? implode(',',$arrCateParent): '';
			$dataInput = array(
						'shop_category'=>array('value'=>$shop_category, 'require'=>1, 'messages'=>'Chọn danh mục sản phẩm!'),
						'shop_name'=>array('value'=>FunctionLib::getParam('shop_name',''), 'require'=>1, 'messages'=>'Tên gian hàng không được trống!'),
						'shop_phone'=>array('value'=>FunctionLib::getParam('shop_phone','')),
						'shop_address'=>array('value'=>FunctionLib::getParam('shop_address',''), 'require'=>0, 'messages'=>''),
						'shop_email'=>array('value'=>FunctionLib::getParam('shop_email',''), 'require'=>1, 'messages'=>'Email không được trống!'),
						'shop_about'=>array('value'=>FunctionLib::getParam('shop_about',''), 'require'=>0, 'messages'=>''),
						'shop_province'=>array('value'=>FunctionLib::getIntParam('shop_province',''), 'require'=>0, 'messages'=>'Chọn tỉnh thành!'),
						'shop_transfer'=>array('value'=>FunctionLib::getParam('shop_transfer',''), 'require'=>0, 'messages'=>''),
					);
			
			$arrPhone = $dataInput['shop_phone']['value'];
			$arrMail = $dataInput['shop_email']['value'];
			$errors = ValidForm::validInputData($dataInput);
			
			$i=0;
			foreach($arrPhone as $key=>$val){
				if($val == ''){
					unset($arrPhone[$key]);
				}else{
					$i++;
				}
				if($i>3){
					unset($arrPhone[$key]);
				}
			}
			if(empty($arrPhone)){
				$arrPhone = array();
			}

			$i=0;
			foreach($arrMail as $key=>$val){
				$check_valid_mail = ValidForm::checkRegexEmail($val);
				if(!$check_valid_mail){
					unset($arrMail[$key]);
				}else{
					$i++;	
				}
				if($i>3){
					unset($arrMail[$key]);
				}
			}
			if(empty($arrMail)){
				$arrMail = array();
			}

			if($errors != ''){
				drupal_set_message($errors, 'error');
				drupal_goto($base_url.'/sua-thong-tin-gian-hang.html');
			}
			$data_post = array(
				'shop_category'=>$dataInput ['shop_category']['value'],
				'shop_name'=>$dataInput ['shop_name']['value'],
				'shop_phone'=>serialize($arrPhone),
				'shop_address'=>$dataInput ['shop_address']['value'],
				'shop_email'=>serialize($arrMail),
				'shop_about'=>$dataInput ['shop_about']['value'],
				'shop_province'=>$dataInput ['shop_province']['value'],
				'shop_transfer'=>$dataInput ['shop_transfer']['value'],
			);

			$data_post['shop_category_name'] = '';
			RegShop::updateId($data_post, $user_shop->shop_id);
			if(Cache::CACHE_ON){
				$key_cache = Cache::VERSION_CACHE.Cache::CACHE_USER_SHOP_ID.$user_shop->shop_id;
				$key_cache2 = Cache::VERSION_CACHE.Cache::CACHE_TREE_MENU_CATEGORY_USER_SHOP_ID.$user_shop->shop_id;
				$cache = new Cache();
				$cache->do_remove($key_cache);
				$cache->do_remove($key_cache2);
			}
			drupal_set_message('Cập nhật thông tin gian hàng thành công!');
			drupal_goto($base_url.'/quan-ly-gian-hang.html');
		}
		$listProvinces = DataCommon::getAllProvices();
		$arrCategoryParent = DataCommon::getListCategoryParent();
		$arrShopCate = ($user_shop->shop_category != '')? explode(',',$user_shop->shop_category): array();

		return theme('editInfoShop', array('listProvinces'=>$listProvinces,
			'arrShopCate'=>$arrShopCate,
			'arrCategoryParent'=>$arrCategoryParent));
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

	public function forgotPass(){
		global $base_url;
		
		if(!empty($_POST)){
			$user_shop = FunctionLib::getParam('user_shop','');
			$email_shop = FunctionLib::getParam('email_shop','');
			$form_name = FunctionLib::getParam('txtFormForgotPass','');
			
			if($user_shop != '' && $email_shop != '' && $form_name == 'txtFormForgotPass'){
				$errors = '';
				
				$check_valid_name = ValidForm::checkRegexName($user_shop);
				if(!$check_valid_name){
					$errors .= 'Tên đăng nhập không được có dấu!<br/>';
				}

				$check_valid_mail = ValidForm::checkRegexEmail($email_shop);
				if(!$check_valid_mail){
					$errors .= 'Email không đúng định dạng!<br/>';
				}

				if($errors != ''){
					drupal_set_message($errors, 'error');
					return theme('forgotPass', array('user_shop' => $user_shop, 'shop_email' => $email_shop));
				}

				$userExist = RegShop::getShopByCondMail($user_shop, $email_shop);
				
				if(!empty($userExist)){
					$shop_id = $userExist[0]->shop_id;
					$pass = self::randomString(5);

					require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
					$hash_pass = user_hash_password($pass);
					
					$data_post = array('user_password'=>$hash_pass);
					RegShop::updateId($data_post, $shop_id);

					$linkpath = $base_url.'/dang-nhap.html';
					$contentEmail = '<b>Thay đổi mật khẩu tại ShopCuaTui.COM.VN</b><br/>';
					$contentEmail .= 'Chào: '.$userExist[0]->user_shop.'<br/>';
					$contentEmail .= 'Dưới đây là thông tin đăng nhập<br/><br/>';
					$contentEmail .= '<b>Tên đăng nhập:</b> '.$userExist[0]->user_shop.'<br/>';
					$contentEmail .= '<b>Mật khẩu:</b> '.$pass.'<br/><br/>';
					$contentEmail .= '<a href="'.$linkpath.'">Bấm vào để đăng nhập</a><br/><br/>';
					$contentEmail .= 'Ghi chú: Bạn hay đăng nhập và thay đổi mật khẩu cho bảo mật lần đăng nhập sau.';
					
    				$subject = 'Khôi phục mật khẩu:';
					auto_send_mail('Shop', $contentEmail, $email_shop, $subject);
					drupal_set_message('Hệ thống đã gửi một thư tới địa chỉ email này!');
				}else{
					drupal_set_message('Không đúng tên đăng nhập hoặc email đăng ký shop!', 'error');
					return theme('forgotPass', array('shop_email' => $email_shop));
				}
			}else{
				drupal_set_message('Email khôi phục mật khẩu không được trống. Hệ thống sẽ gửi mail tới địa chỉ này!');
				drupal_goto($base_url.'/quen-mat-khau.html');
			}
		}
		return theme('forgotPass');
	}
	public function ajaxCheckShopExist(){
		global $base_url, $user_shop;
		
		if($user_shop->shop_id != 0){
			drupal_goto($base_url);
		}
		
		$user_shop = FunctionLib::getParam('user_shop','');
    	$user_pass = FunctionLib::getParam('user_pass','');
    	$shop_phone = FunctionLib::getParam('shop_phone','');
    	$shop_email = FunctionLib::getParam('shop_email','');
    	
    	$check_valid_name = ValidForm::checkRegexName($user_shop);
		if(!$check_valid_name){
			$err['check_name'] = 'Tên đăng nhập không được có dấu!<br/>';
		}
		$check_valid_mail = ValidForm::checkRegexEmail($shop_email);
		if(!$check_valid_mail){
			$err['check_mail'] = 'Email không đúng định dạng!<br/>';
		}
		$check_valid_pass = ValidForm::checkRegexPass($user_pass, 6);
		if(!$check_valid_pass){
			$err['check_pass'] = 'Mật khẩu không được có dấu!<br/>';
		}
		if(!empty($err)){
    		echo json_encode($err);die;
    	}
    	$err = RegShop::checkNamePhoneMail($user_shop, $shop_phone, $shop_email);
    	if(!empty($err)){
    		echo json_encode($err);die;
    	}else{
    		echo '';die;
    	}
	}
	public static function randomString($length=5){
		$str = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$strLength = strlen($str);
	    $random_string = '';
	    for($i=0; $i<=$length; $i++) {
	        $random_string .= $str[rand(0, $strLength - 1)];
	    }
	    return $random_string;
	}
}