<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ConfiginfoController{
	private $arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');

	public function indexConfiginfo(){
		
	global $base_url;
	$limit = SITE_RECORD_PER_PAGE;
	//search
	$dataSearch['title'] = FunctionLib::getParam('title','');
	$dataSearch['status'] = FunctionLib::getParam('status', -1);

	$arrFields = array('id', 'title', 'keyword', 'intro', 'content', 'img', 'created', 'status', 'meta_title', 'meta_keywords', 'meta_description');
	$result = ConfigInfo::getSearchListItems($dataSearch,$limit,$arrFields);

	//build option
	$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['status']);

	$view = theme('indexConfigInfo',array(
								'title'=>'Cấu hình chung',
								'result' => $result['data'],
								'dataSearch' => $dataSearch,
								'optionStatus' => $optionStatus,
								'base_url' => $base_url,
								'totalItem' =>$result['total'],
								'pager' =>$result['pager']));
	return $view;
	}

	public function formConfiginfoAction(){
		global $base_url, $user;

		$Stdio = new Stdio();

		$param = arg();
		$arrOneItem = array();

		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$arrFields=array('id', 'title', 'keyword', 'intro', 'content', 'img', 'created', 'status', 'meta_title', 'meta_keywords', 'meta_description');
			$arrOneItem = ConfigInfo::getOne($arrFields, $param[3]);
		}

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){

			$data = array(
							'title'=>array('value'=>FunctionLib::getParam('title',0), 'require'=>1, 'messages'=>'Tiêu đề không được trống!'),
							'keyword'=>array('value'=>FunctionLib::getParam('keyword',''), 'require'=>1, 'messages'=>'Từ khóa không được trống!'),
							'intro'=>array('value'=>FunctionLib::getParam('intro',''), 'require'=>0, 'messages'=>''),
							'content'=>array('value'=>FunctionLib::getParam('content',''), 'require'=>0, 'messages'=>''),
							'status'=>array('value'=>FunctionLib::getParam('status',''), 'require'=>0, 'messages'=>''),
							'meta_title'=>array('value'=>FunctionLib::getParam('meta_title',''), 'require'=>0, 'messages'=>''),
							'meta_keywords'=>array('value'=>FunctionLib::getParam('meta_keywords',''), 'require'=>0, 'messages'=>''),
							'meta_description'=>array('value'=>FunctionLib::getParam('meta_description',''), 'require'=>0, 'messages'=>''),
							'uid'=>array('value'=>$user->uid, 'require'=>0, 'messages'=>''),
							'created'=>array('value'=>time(), 'require'=>0, 'messages'=>''),
						);

			$errors = ValidForm::validInputData($data);

			if($errors != ''){
				drupal_set_message($errors, 'error');
				if(isset($param[3]) && $param[3] > 0){
					drupal_goto($base_url.'/admincp/configinfo/edit/'.$param[3]);
				}else{
					drupal_goto($base_url.'/admincp/configinfo/add');
				}
			}
			$data_post = array();
			if(!empty($data)){
				foreach($data as $key=>$val){
					$data_post[$key] = $val['value'];
				}
			}

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

	public function deleteConfiginfoAction(){
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
}