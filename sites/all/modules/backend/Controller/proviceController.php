<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
function indexProvice(){
	global $base_url;
	
	$totalItem = 0;
	$limit = SITE_RECORD_PER_PAGE;
	$pager = '';
	$dataSearch = array();
	$dataSearch['keyword'] = AdminLib::getParam('keyword','');
	$dataSearch['status'] = AdminLib::getParam('status','');
	$arrFields=array('id', 'title', 'created', 'status');

	$result = Provice::getSearch($dataSearch, $arrFields, $limit, $totalItem, $pager);
	$view = theme('indexProvice',array(
								'title'=>'Quản lý bài viết',
								'result' => $result,
								'dataSearch' => $dataSearch,
								'base_url' => $base_url,
								'totalItem' =>$totalItem,
								'pager' =>$pager,));
	return $view;
}

function formProviceAction(){
	global $base_url, $user;

	$param = arg();
	$arrOneItem = array();

	if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
		$arrFields=array('id', 'title', 'status');
		$arrOneItem = Provice::getOne($arrFields, $param[3]);
	}

	if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){

		$title 		= isset($_POST['title']) ? trim($_POST['title']) : '';
		$status		= isset($_POST['status']) ? intval($_POST['status']) : 0;
		$uid		= $user->uid;
		$created	= time();

		$errors = '';
		if($title==''){
			$errors .= 'Tên tỉnh ko được trống!<br/>';
		}
		if($errors != ''){
			drupal_set_message($errors, 'error');
			if(isset($param[3]) && $param[3] > 0){
				drupal_goto($base_url.'/admincp/provice/edit/'.$param[3]);
			}else{
				drupal_goto($base_url.'/admincp/provice/add');
			}
		}

		$data_post = array(
					'title'=>$title,
					'status'=>$status,
					'uid'=>$uid,
					'created'=>$created,
				);

		if(isset($param[3]) && $param[3] > 0){
			unset($data_post['uid']);
			unset($data_post['created']);
			Provice::updateId($data_post, $param[3]);
			drupal_set_message('Sửa bài viết thành công.');
			drupal_goto($base_url.'/admincp/provice');
		}else{
			$query = Provice::insert($data_post);
			if($query){
				drupal_set_message('Thêm bài viết thành công.');
				drupal_goto($base_url.'/admincp/provice');
			}
		}
	}

	$data = array(
				'arrOneItem'=>$arrOneItem,				
			);

	$view = theme('addProvice',$data);
	return $view;
}

function deleteProviceAction(){
	global $base_url;
	if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
		$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : 0;
		foreach($listId as $item){
			if($item > 0){
				Provice::deleteId($item);
			}
		}
		drupal_set_message('Xóa bài viết thành công.');
	}
	drupal_goto($base_url.'/admincp/provice');
}