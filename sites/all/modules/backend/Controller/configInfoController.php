<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
function indexConfiginfo(){
	global $base_url;
	
	$totalItem = 0;
	$limit = SITE_RECORD_PER_PAGE;
	$pager = '';
	$dataSearch = array();
	$dataSearch['keyword'] = FunctionLib::getParam('keyword','');
	$dataSearch['status'] = FunctionLib::getParam('status','');
	$arrFields=array('id', 'title', 'keyword', 'intro', 'content', 'img', 'created', 'status', 'meta_title', 'meta_keywords', 'meta_description');

	$result = ConfigInfo::getSearch($dataSearch, $arrFields, $limit, $totalItem, $pager);
	$view = theme('indexConfigInfo',array(
								'title'=>'Quản lý bài viết',
								'result' => $result,
								'dataSearch' => $dataSearch,
								'base_url' => $base_url,
								'totalItem' =>$totalItem,
								'pager' =>$pager,));
	return $view;
}

function formConfiginfoAction(){
	global $base_url, $user;

	$Stdio = new Stdio();

	$param = arg();
	$arrOneItem = array();

	if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
		$arrFields=array('id', 'title', 'keyword', 'intro', 'content', 'img', 'created', 'status', 'meta_title', 'meta_keywords', 'meta_description');
		$arrOneItem = ConfigInfo::getOne($arrFields, $param[3]);
	}

	if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){

		$title 	= isset($_POST['title']) ? trim($_POST['title']) : '';
		$keyword 	= isset($_POST['keyword']) ? trim($_POST['keyword']) : '';
		$intro = isset($_POST['intro']) ? trim($_POST['intro']) : '';
		$content = isset($_POST['content']) ? trim($_POST['content']) : '';
		$status		= isset($_POST['status']) ? intval($_POST['status']) : 0;

		$meta_title			= isset($_POST['meta_title']) ? trim($_POST['meta_title']) : '';
		$meta_keywords		= isset($_POST['meta_keywords']) ? trim($_POST['meta_keywords']) : '';
		$meta_description	= isset($_POST['meta_description']) ? trim($_POST['meta_description']) : '';

		$uid		= $user->uid;
		$created	= time();

		$errors = '';
		if($title==''){
			$errors .= 'Tiêu đề ko được trống!<br/>';
		}
		if($keyword==''){
			$errors .= 'Từ khóa ko được trống!<br/>';
		}
		if($errors != ''){
			drupal_set_message($errors, 'error');
			if(isset($param[3]) && $param[3] > 0){
				drupal_goto($base_url.'/admincp/configinfo/edit/'.$param[3]);
			}else{
				drupal_goto($base_url.'/admincp/configinfo/add');
			}
		}

		$data_post = array(
					'title'=>$title,
					'keyword'=>$keyword,
					'intro'=>$intro,
					'content'=>$content,
					'status'=>$status,
					'meta_title'=>$meta_title,
					'meta_keywords'=>$meta_keywords,
					'meta_description'=>$meta_description,
					'uid'=>$uid,
					'created'=>$created,
				);

		if(isset($param[3]) && $param[3] > 0){
			unset($data_post['uid']);
			unset($data_post['created']);
			ConfigInfo::updateId($data_post, $param[3]);
			drupal_set_message('Sửa bài viết thành công.');
			drupal_goto($base_url.'/admincp/configinfo');
		}else{
			$query = ConfigInfo::insert($data_post);
			if($query){
				drupal_set_message('Thêm bài viết thành công.');
				drupal_goto($base_url.'/admincp/configinfo');
			}
		}
	}

	$data = array(
				'arrOneItem'=>$arrOneItem,				
			);

	$view = theme('addConfigInfo',$data);
	return $view;
}

function deleteConfiginfoAction(){
	global $base_url;
	if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
		$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : 0;
		foreach($listId as $item){
			if($item > 0){
				ConfigInfo::deleteId($item);
			}
		}
		drupal_set_message('Xóa bài viết thành công.');
	}
	drupal_goto($base_url.'/admincp/configinfo');
}