<?php
/*
* QuynhTM
*/
class CommentController{
	private $arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
	function indexComment(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['province_name'] = FunctionLib::getParam('province_name','');
		$dataSearch['province_status'] = FunctionLib::getParam('province_status', -1);

		$getFields = array();
		$result = Comment::getSearchListItems($dataSearch,$limit,$getFields);

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['province_status']);

		return $view = theme('indexComment',array(
									'title'=>'Danh sách liên hệ',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));

	}

	function formCommentAction(){
		global $base_url;
		$param = arg();
		$arrItem = array();
		$item_id = 0;
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$item_id = (int)$param[3];
			$arrItem = Comment::getItemById(array(), $item_id);
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
					drupal_goto($base_url.'/admincp/comment/edit/'.$item_id);
				}else{
					drupal_goto($base_url.'/admincp/comment/add');
				}
			}else{
				Province::save($dataInput, $item_id);
				drupal_goto($base_url.'/admincp/comment');
			}
		}
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->province_status) ? $arrItem->province_status: -1);
		return $view = theme('addComment',
			array('arrItem'=>$arrItem,
				'item_id'=>$item_id,
				'title'=>'Liên hệ',
				'optionStatus'=>$optionStatus));
	}

	function deleteCommentAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : array();
			if(!empty($listId)){
				foreach($listId as $item_id){
					if($item_id > 0){
						Comment::deleteId($item_id);
					}
				}
				drupal_set_message('Xóa bài viết thành công.');
			}
		}
		drupal_goto($base_url.'/admincp/comment');
	}
}