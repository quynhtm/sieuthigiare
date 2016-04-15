<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ContactShopController{
	private $arrStatus = array(-1 => '--Chọn trạng thái--', CONTACT_NEW => 'Liên hệ mới', CONTACT_OK => 'Đã xác nhận', CONTACT_SUCCESS => 'Đã xử lý');
	public function contactShop(){
		global $base_url, $user_shop;
		if($user_shop->shop_id == 0){
			drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
			drupal_goto($base_url);
		}

		$limit = SITE_RECORD_PER_PAGE;
		$arrFields = array('contact_id','contact_title', 'contact_content','contact_status','contact_time_creater');
		$result = ContactShop::getSearchListItems($limit, $arrFields);

		//FunctionLib::Debug($result);
		return theme('contactShop',array(
									'title'=>'Liên hệ với quản trị site',
									'arrStatus' => $this->arrStatus,
									'result' => $result['data'],
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));
	}

	public function contactFormShop(){
		global $base_url, $user_shop;

		if($user_shop->shop_id == 0){
			drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
			drupal_goto($base_url);
		}

		$files = array(
			'bootstrap/lib/ckeditor/ckeditor.js',
			'bootstrap/lib/ckeditor/config.js',
		);
		Loader::loadJSExt('Core', $files);

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$data = array(
					'contact_title'=>array('value'=>FunctionLib::getParam('contact_title',''), 'require'=>1, 'messages'=>'Bạn chưa nhập tiêu đề liên hệ'),
					'contact_content'=>array('value'=>FunctionLib::getParam('contact_content',''), 'require'=>1, 'messages'=>'Bạn chưa nhập nội dung liên hệ!'),

					'contact_user_id_send'=>array('value'=>$user_shop->shop_id, 'require'=>0),
					'contact_user_name_send'=>array('value'=>$user_shop->shop_name, 'require'=>0),
					'contact_phone_send'=>array('value'=>$user_shop->shop_phone, 'require'=>0),
					'contact_email_send'=>array('value'=>$user_shop->shop_email, 'require'=>0),
					'contact_type'=>array('value'=>CONTACT_TYPE_SEND, 'require'=>0),//kiểu gửi
					'contact_reason'=>array('value'=>CONTACT_REASON_SHOP, 'require'=>0),//shop gửi
					'contact_status'=>array('value'=>CONTACT_NEW, 'require'=>0),
					'contact_time_creater'=>array('value'=>time(), 'require'=>0),

				);
			$errors = ValidForm::validInputData($data);

			if($errors != ''){
				drupal_set_message($errors, 'error');
				drupal_goto($base_url.'/gui-lien-he.html');
			}else{
				ContactShop::save($data);
				drupal_goto($base_url.'/lien-he-quan-tri.html');
			}
		}
		return theme('contactFormShop',
			array('title'=>'Gửi liên hệ cho quản trị'));
	}

}
