<?php
/*
* QuynhTM
*/
class ContactController{
	//1: liên hệ mới, 2: đã xác nhận,3: đã xử lý
	private $arrStatus = array(-1 => 'Tất cả', CONTACT_NEW => 'Liên hệ mới', CONTACT_OK => 'Đã xác nhận', CONTACT_SUCCESS => 'Đã xử lý');
	private $arrReason = array(-1 => 'Tất cả', CONTACT_REASON_CUSTOMER => 'Khách hàng gửi', CONTACT_REASON_SHOP => 'Shop gửi');

	public function __construct(){
		$files = array(
			'bootstrap/lib/ckeditor/ckeditor.js',
			'bootstrap/lib/ckeditor/config.js',
		);
		Loader::loadJSExt('Core', $files);
        $files = array(
            'bootstrap/css/bootstrap.css',
            'css/font-awesome.css',
            'css/core.css',
        );
        Loader::load('Core', $files);

        $files = array(
        	'View/css/admin.css',
            'View/js/admin.js',
        );
        Loader::load('Admin', $files);
	}

	function indexContact(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['contact_title'] = FunctionLib::getParam('contact_title','');
		$dataSearch['contact_user_name_send'] = FunctionLib::getParam('contact_user_name_send','');
		$dataSearch['contact_email_send'] = FunctionLib::getParam('contact_email_send','');
		$dataSearch['contact_phone_send'] = FunctionLib::getParam('contact_phone_send','');
		$dataSearch['contact_reason'] = FunctionLib::getParam('contact_reason', -1);
		$dataSearch['contact_status'] = FunctionLib::getParam('contact_status', -1);

		$getFields = array();
		$result = Contact::getSearchListItems($dataSearch,$limit,$getFields);

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['contact_status']);
		$optionReason = FunctionLib::getOption($this->arrReason, $dataSearch['contact_reason']);

		return $view = theme('indexContact',array(
									'title'=>'Danh sách liên hệ',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'optionReason' => $optionReason,
									'arrStatus' => $this->arrStatus,
									'arrReason' => $this->arrReason,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));

	}

	function formContactAction(){
		global $base_url;
		$param = arg();
		$contact = array();
		$item_id = 0;
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$item_id = (int)$param[3];
			$contact = Contact::getItemById(array(), $item_id);
		}

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$contact_status = FunctionLib::getParam('contact_status',CONTACT_NEW);
			$contact_content_reply = FunctionLib::getParam('contact_content_reply','');
			if(trim($contact_content_reply) != ''){
				$dataInput = array(
					'contact_content_reply'=>array('value'=>$contact_content_reply),
					'contact_status'=>array('value'=>CONTACT_SUCCESS),
					'contact_time_update'=>array('value'=>time()),
				);
			}else{
				$dataInput = array(
					'contact_status'=>array('value'=>$contact_status),
					'contact_time_update'=>array('value'=>time()),
				);
			}

			Contact::save($dataInput, $item_id);
			drupal_goto($base_url.'/admincp/contact');
		}

		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($contact->contact_status)? $contact->contact_status : CONTACT_NEW);
		return $view = theme('addContact',
			array('contact'=>$contact,
				'item_id'=>$item_id,
				'optionStatus'=>$optionStatus,
				'arrReason' => $this->arrReason,
				'title'=>'Liên hệ'));
	}

}