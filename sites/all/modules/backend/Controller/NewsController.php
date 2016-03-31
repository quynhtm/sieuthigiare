<?php
/*
* QuynhTM
*/
class NewsController{
	private $arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');

	function indexNews(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['news_title'] = FunctionLib::getParam('news_title','');
		$dataSearch['news_status'] = FunctionLib::getParam('news_status', -1);
		$dataSearch['news_category'] = FunctionLib::getParam('news_category', -1);

		$result = News::getSearchListItems($dataSearch,$limit,array());

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['news_status']);

		return $view = theme('indexNews',array(
									'title'=>'Tin tức',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));

	}

	function formNewsAction(){
		global $base_url;
		$param = arg();
		$arrItem = array();
		$item_id = 0;
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$item_id = (int)$param[3];
			$arrItem = News::getItemById(array(), $item_id);
			//FunctionLib::Debug($arrItem);
		}

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$dataInput = array(
				'category_name'=>array('value'=>FunctionLib::getParam('category_name',''), 'require'=>1, 'messages'=>'Tên danh mục không được trống!'),
				'category_parent_id'=>array('value'=>FunctionLib::getParam('category_parent_id',''), 'require'=>1, 'messages'=>'Chưa chọn danh mục cha!'),
				'category_status'=>array('value'=>FunctionLib::getParam('category_status',0)),
				'category_order'=>array('value'=>FunctionLib::getParam('category_order',0)),
			);

			$errors = ValidForm::validInputData($dataInput);
			if($errors != ''){
				drupal_set_message($errors, 'error');
				if($item_id > 0){
					drupal_goto($base_url.'/admincp/news/edit/'.$item_id);
				}else{
					drupal_goto($base_url.'/admincp/news/add');
				}
			}else{
				News::save($dataInput, $item_id);
				drupal_goto($base_url.'/admincp/news');
			}
		}
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->category_status) ? $arrItem->category_status: -1);
		return $view = theme('addNews',
			array('arrItem'=>$arrItem,
				'item_id'=>$item_id,
				'title'=>'danh mục sản phẩm',
				'optionStatus'=>$optionStatus));
	}

	function deleteNewsAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : array();
			if(!empty($listId)){
				foreach($listId as $item_id){
					if($item_id > 0){
						News::deleteId($item_id);
					}
				}
				drupal_set_message('Xóa bài viết thành công.');
			}
		}
		drupal_goto($base_url.'/admincp/news');
	}
}