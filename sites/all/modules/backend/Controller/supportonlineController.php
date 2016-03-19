<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
function indexSupportonline(){
	global $base_url;
	
	$totalItem = 0;
	$limit = SITE_RECORD_PER_PAGE;
	$pager = '';
	$dataSearch = array();
	$dataSearch['keyword'] = AdminLib::getParam('keyword','');
	$dataSearch['status'] = AdminLib::getParam('status','');
	$arrFields=array('id', 'title', 'mobile', 'skyper', 'yahoo', 'created', 'order_no', 'status');

	$result = SupportOnline::getSearch($dataSearch, $arrFields, $limit, $totalItem, $pager);
	$view = theme('indexSupportOnline',array(
								'title'=>'Quản lý bài viết',
								'result' => $result,
								'dataSearch' => $dataSearch,
								'base_url' => $base_url,
								'totalItem' =>$totalItem,
								'pager' =>$pager,));
	return $view;
}

function formSupportonlineAction(){
	global $base_url, $user;

	$Stdio = new Stdio();

	$param = arg();
	$arrOneItem = array();

	if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
		$arrFields = array('id','title', 'yahoo', 'skyper', 'mobile', 'email', 'order_no', 'status');
		$arrOneItem = SupportOnline::getOne($arrFields, $param[3]);
	}

	if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){

		$title 	= isset($_POST['title']) ? trim($_POST['title']) : '';
		$yahoo 	= isset($_POST['yahoo']) ? trim($_POST['yahoo']) : '';
		$skyper = isset($_POST['skyper']) ? trim($_POST['skyper']) : '';
		$mobile = isset($_POST['mobile']) ? trim($_POST['mobile']) : '';
		$email 	= isset($_POST['email']) ? trim($_POST['email']) : '';
		$order_no	= isset($_POST['order_no']) ? intval($_POST['order_no']) : 1;
		$status		= isset($_POST['status']) ? intval($_POST['status']) : 0;

		$uid		= $user->uid;
		$created	= time();

		$check_email = ValidForm::checkRegexEmail($email);
		if(!$check_email){
			drupal_set_message('Email sai cấu trúc.Vui lòng thử lại!', 'error');
			if($param[3]>-1){
				drupal_goto($base_url.'/admincp/supportonline/edit/'.$param[3]);
			}else{
				drupal_goto($base_url.'/admincp/supportonline/add');
			}
		}

		$data_post = array(
					'title'=>$title,
					'yahoo'=>$yahoo,
					'skyper'=>$skyper,
					'mobile'=>$mobile,
					'email'=>$email,
					'order_no'=>$order_no,
					'status'=>$status,
					'uid'=>$uid,
					'created'=>$created,
				);

		if($param[3] > 0){
			unset($data_post['uid']);
			unset($data_post['created']);
			SupportOnline::updateId($data_post, $param[3]);
			drupal_set_message('Sửa bài viết thành công.');
			drupal_goto($base_url.'/admincp/supportonline');

		}else{
			$query = SupportOnline::insert($data_post);
			if($query){
				drupal_set_message('Thêm bài viết thành công.');
				drupal_goto($base_url.'/admincp/supportonline');
			}
		}
	}

	$data = array(
				'arrOneItem'=>$arrOneItem,				
			);

	$view = theme('addSupportOnline',$data);
	return $view;
}

function deleteSupportonlineAction(){
	global $base_url;
	$SupportOnline = new SupportOnline();
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