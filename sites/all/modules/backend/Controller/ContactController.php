<?php
/*
* QuynhTM
*/
class ContactController{

	private $arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
	
	public function __construct(){
			
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

		return $view = theme('indexContact',array(
									'title'=>'Danh sách liên hệ',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));

	}

	function formContactAction(){
		global $base_url;
		$param = arg();
		$arrItem = array();
		$item_id = 0;
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$item_id = (int)$param[3];
			$arrItem = Contact::getItemById(array(), $item_id);
			//FunctionLib::Debug($arrItem);
		}

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$dataInput = array(
				'province_name'=>array('value'=>FunctionLib::getParam('province_name',''), 'require'=>1, 'messages'=>'Tên tỉnh thành không được trống!'),
				'province_position'=>array('value'=>FunctionLib::getParam('province_position',100)),
				'province_status'=>array('value'=>FunctionLib::getParam('province_status','')),
			);

			$errors = ValidForm::validInputData($dataInput);
			if($errors != ''){
				drupal_set_message($errors, 'error');
				if($item_id > 0){
					drupal_goto($base_url.'/admincp/contact/edit/'.$item_id);
				}else{
					drupal_goto($base_url.'/admincp/contact/add');
				}
			}else{
				Province::save($dataInput, $item_id);
				drupal_goto($base_url.'/admincp/contact');
			}
		}
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->province_status) ? $arrItem->province_status: -1);
		return $view = theme('addContact',
			array('arrItem'=>$arrItem,
				'item_id'=>$item_id,
				'title'=>'Liên hệ',
				'optionStatus'=>$optionStatus));
	}

	function deleteContactAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : array();
			if(!empty($listId)){
				foreach($listId as $item_id){
					if($item_id > 0){
						Contact::deleteId($item_id);
					}
				}
				drupal_set_message('Xóa bài viết thành công.');
			}
		}
		drupal_goto($base_url.'/admincp/contact');
	}
}