<?php
/*
* QuynhTM
*/
class CategoryController{

	private $arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
	private $arrCategoryParent = array();
	private $arrShowContent = array(0 => 'Ẩn', 1 => 'Hiển thị');

	public function __construct(){
		$this->arrCategoryParent = DataCommon::getListCategoryParent();
		
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
	function indexCategory(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['category_name'] = FunctionLib::getParam('category_name','');
		$dataSearch['category_status'] = FunctionLib::getParam('category_status', -1);
		$dataSearch['category_parent_id'] = FunctionLib::getParam('category_parent_id', -1);
		$dataSearch['category_content_front'] = FunctionLib::getParam('category_content_front', 0);

		$result = Category::getSearchListItems($dataSearch,$limit,array());

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['category_status']);
		$optionCategoryParent = FunctionLib::getOption(array(-1=>'Chọn danh mục cha')+$this->arrCategoryParent, $dataSearch['category_parent_id']);
		$optionShowContent = FunctionLib::getOption($this->arrShowContent, $dataSearch['category_content_front']);

		return $view = theme('indexCategory',array(
									'title'=>'Danh mục sản phẩm',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'optionCategoryParent' => $optionCategoryParent,
									'optionShowContent' => $optionShowContent,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));

	}

	function formCategoryAction(){
		global $base_url;
		$param = arg();
		$arrItem = array();
		$item_id = 0;
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$item_id = (int)$param[3];
			$arrItem = Category::getItemById(array(), $item_id);
			//FunctionLib::Debug($arrItem);
		}

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$dataInput = array(
				'category_name'=>array('value'=>FunctionLib::getParam('category_name',''), 'require'=>1, 'messages'=>'Tên danh mục không được trống!'),
				'category_parent_id'=>array('value'=>FunctionLib::getParam('category_parent_id',''), 'require'=>1, 'messages'=>'Chưa chọn danh mục cha!'),
				'category_content_front'=>array('value'=>FunctionLib::getIntParam('category_content_front',0)),
				'category_status'=>array('value'=>FunctionLib::getParam('category_status',0)),
				'category_order'=>array('value'=>FunctionLib::getParam('category_order',0)),
			);



			$errors = ValidForm::validInputData($dataInput);
			if($errors != ''){
				drupal_set_message($errors, 'error');
				if($item_id > 0){
					drupal_goto($base_url.'/admincp/category/edit/'.$item_id);
				}else{
					drupal_goto($base_url.'/admincp/category/add');
				}
			}else{
				Category::save($dataInput, $item_id);
				if(Cache::CACHE_ON){
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_CATEGORY_ID.$item_id;
					$cache = new Cache();
					$cache->do_remove($key_cache);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_LIST_CATEGORY_PARENT);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_CATEGORY_CHILDREN_PARENT_ID.$item_id);
				}
				drupal_goto($base_url.'/admincp/category');
			}
		}
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->category_status) ? $arrItem->category_status: -1);
		$optionCategoryParent = FunctionLib::getOption(array(0=>'Chọn danh mục cha')+$this->arrCategoryParent, isset($arrItem->category_parent_id) ? $arrItem->category_parent_id: -1);
		$optionShowContent = FunctionLib::getOption($this->arrShowContent, isset($arrItem->category_content_front) ? $arrItem->category_content_front: 0);
		
		return $view = theme('addCategory',
			array('arrItem'=>$arrItem,
				'item_id'=>$item_id,
				'title'=>'danh mục sản phẩm',
				'optionCategoryParent'=>$optionCategoryParent,
				'optionStatus'=>$optionStatus,
				'optionShowContent'=>$optionShowContent,
				));
	}

	function deleteCategoryAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : array();
			if(!empty($listId)){
				foreach($listId as $item_id){
					$cache = new Cache();
					if($item_id > 0){
						Category::deleteId($item_id);
						if(Cache::CACHE_ON){
							$key_cache = Cache::VERSION_CACHE.Cache::CACHE_CATEGORY_ID.$item_id;
							$cache->do_remove($key_cache);
							$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_LIST_CATEGORY_PARENT);
							$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_CATEGORY_CHILDREN_PARENT_ID.$item_id);
						}
					}
				}
				drupal_set_message('Xóa bài viết thành công.');
			}
		}
		drupal_goto($base_url.'/admincp/category');
	}
}