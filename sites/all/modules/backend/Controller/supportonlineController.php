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
	$limit = 1;
	$pager = '';
	$dataSearch = array();
	$dataSearch['keyword'] = clsAdminLib::getParam('keyword','');
	$dataSearch['category'] = clsAdminLib::getIntParam('category','');
	$dataSearch['status'] = clsAdminLib::getParam('status','');

	$result = Supportonline::getSearchListItems($dataSearch,$limit,$totalItem,$pager);
	
	$arrOptionsCategory[0] = t("Danh mục gốc");

	$view = theme('indexSupportOnline',array(
								'title'=>'Quản lý Nick Support',
								'result' => $result,
								'dataSearch' => $dataSearch,
								'base_url' => $base_url,
								'totalItem' =>$totalItem,
								'pager' =>$pager,));
	return $view;
}

function formSupportonlineAction(){
	global $base_url, $user;

	$clsStdio = new clsStdio();
	$SupportOnline = new SupportOnline();

	$fields = clsForm::buildItemFields($SupportOnline->listInputForm());
	$data = array('fields'=>$fields);

	//get item update
	$param = arg();
	if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
		$arrFields = array('id','title', 'yahoo', 'skyper', 'mobile', 'email', 'order_no', 'status');
		$arrOneItem = $SupportOnline::getOneItem($arrFields, $param[3]);
		
		foreach ($data['fields'] as $key => $filed) {
			$data['fields'][$key]['value']=$arrOneItem[0]->$key;
		}

	}

	//check post: insert or update
	if(!empty($_POST) && $_POST['txtFormName']=='txtFormName'){
		$require_post = array();

		$data_post = array();
		$data_post['uid ']=$user->uid;
		$data_post['created']=time();

		foreach ($data['fields'] as $key => $field) {
			$data_post[$key] = clsForm::itemPostValue($key);
			$data['fields'][$key]['value']=$data_post[$key];

			if(isset($field['require']) && $field['require']=='require' && $data_post[$key]==''){
				$require_post[$key] = t($field['label']).' '.t('không được rỗng!');
			}

			if($key=='title'){
				$data_post['title_alias']=$clsStdio->pregReplaceStringAlias(clsForm::itemPostValue('title'));
			}
		 }

		unset($_POST);
		if(count($require_post)>0){
			foreach ($require_post as $k => $v) {
				form_set_error($k, $v);
			}
			unset($data_post);
		}else{

			if($data['fields']['id']['value']>0){
				$query = $SupportOnline->updateOne($data_post, $data['fields']['id']['value']);
				unset($data_post);
				drupal_set_message('Sửa bài viết thành công.');
				drupal_goto($base_url.'/admincp/supportOnline');
			}else{
				$query = $SupportOnline->insertOne($data_post);
				unset($data_post);
				if($query){
					drupal_set_message('Thêm bài viết thành công.');
					drupal_goto($base_url.'/admincp/supportOnline');
				}
			}
		}
	}

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
				
				$arrName = $SupportOnline->getByCond("img", "id=$item", "", "", "1");
				$current_path_img='';
				foreach($arrName as $v){
					$current_path_img .= $v->img;
				}

				if($current_path_img!=''){
					$dir = DRUPAL_ROOT.'/'.$clsUpload->path_image_upload.'/supportonline/'.$current_path_img;
					if(is_file($dir)){
						unlink($dir);
					}
				}
				$query = $SupportOnline->deleteOne($item);
			}
		}
		unset($listId);
		drupal_set_message('Xóa bài viết thành công.');

	}
	drupal_goto($base_url.'/admincp/supportonline');
}