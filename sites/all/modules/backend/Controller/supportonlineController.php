<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class SupportonlineController{
	private $arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');

	public function __construct(){
			
        $files = array(
            'bootstrap/css/bootstrap.css',
            'css/font-awesome.css',
            'css/core.css',
            'js/common_admin.js',
        );
        Loader::load('Core', $files);

        $files = array(
        	'View/css/admin.css',
            'View/js/admin.js',
        );
        Loader::load('Admin', $files);
	}


	function indexSupportonline(){
		global $base_url;

		$limit = SITE_RECORD_PER_PAGE;
		
		$dataSearch['title'] = FunctionLib::getParam('title','');
		$dataSearch['status'] = FunctionLib::getParam('status', '');
		
		$arrFields=array('id', 'title', 'mobile', 'skyper', 'yahoo', 'created', 'order_no', 'status');
		$result = SupportOnline::getSearchListItems($dataSearch, $arrFields, $limit);
		
		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['status']);

		$view = theme('indexSupportOnline',array(
									'title'=>'Danh sách nick hỗ trợ trực tuyến',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));
		return $view;
	}

	function formSupportonlineAction(){
		global $base_url, $user;

		$param = arg();
		$id = 0;
		$arrOneItem = array();

		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$arrFields = array('id','title', 'yahoo', 'skyper', 'mobile', 'email', 'order_no', 'status');
			$arrOneItem = SupportOnline::getItemById($arrFields, $param[3]);
			$id = $param[3];
		}

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){

			$data = array(
						'title'=>array('value'=>FunctionLib::getParam('title',''), 'require'=>1, 'messages'=>'Tiêu đề không được trống!'),
						'yahoo'=>array('value'=>FunctionLib::getParam('yahoo',''), 'require'=>0, 'messages'=>''),
						'skyper'=>array('value'=>FunctionLib::getParam('skyper',''), 'require'=>0, 'messages'=>''),
						'mobile'=>array('value'=>FunctionLib::getParam('mobile',''), 'require'=>0, 'messages'=>''),
						'email'=>array('value'=>FunctionLib::getParam('email',''), 'require'=>0, 'messages'=>''),
						'order_no'=>array('value'=>FunctionLib::getParam('order_no',''), 'require'=>0, 'messages'=>''),
						'status'=>array('value'=>FunctionLib::getParam('status',''), 'require'=>0, 'messages'=>''),
						'uid'=>array('value'=>$user->uid, 'require'=>0, 'messages'=>''),
						'created'=>array('value'=>time(), 'require'=>0, 'messages'=>''),
					);

			$errors = ValidForm::validInputData($data);
			if($data['email']['value'] != ''){
				$check_email = ValidForm::checkRegexEmail($data['email']['value']);
				if(!$check_email){
					$errors .= 'Email sai cấu trúc!<br/>';
				}
			}

			if($errors != ''){
				drupal_set_message($errors, 'error');
				if($id > 0){
					drupal_goto($base_url.'/admincp/supportonline/edit/'.$id);
				}else{
					drupal_goto($base_url.'/admincp/supportonline/add');
				}
			}else{
				SupportOnline::save($data, $id);
				drupal_goto($base_url.'/admincp/supportonline');
			}
			
		}
		return $view = theme('addSupportOnline',array('arrOneItem'=>$arrOneItem));
	}

	function deleteSupportonlineAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : 0;
			foreach($listId as $item){
				if($item > 0){
					SupportOnline::deleteId($item);
				}
			}
			drupal_set_message('Xóa bài viết thành công.');
		}
		drupal_goto($base_url.'/admincp/supportonline');
	}
}