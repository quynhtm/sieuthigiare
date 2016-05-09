<?php
/*
* QuynhTM
*/
class CategoryController{

	private $arrStatus = array(-1 => 'Tất cả', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE => 'Ẩn');
	private $arrCategoryParent = array();
	private $arrShowContent = array(STASTUS_HIDE => 'Ẩn', STASTUS_SHOW => 'Hiển thị');

	public function __construct(){
		$this->arrCategoryParent = DataCommon::getListCategoryParent();
		
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
	function indexCategory(){
		global $base_url;
		$limit = 1000;
		$treeCategroy = array();
		//search
		$dataSearch['category_name'] = FunctionLib::getParam('category_name','');
		$dataSearch['category_status'] = FunctionLib::getParam('category_status', -1);
		$dataSearch['category_parent_id'] = FunctionLib::getParam('category_parent_id', -1);
		$dataSearch['category_content_front'] = FunctionLib::getParam('category_content_front', 0);

		$result = Category::getSearchListItems(array(),$limit,array());
		$dataCate = $result['data'];
		if(!empty($dataCate)){
			$treeCategroy = self::getTreeCategory($dataCate);
		}
		//FunctionLib::Debug($treeCategroy);

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['category_status']);
		$optionCategoryParent = FunctionLib::getOption(array(-1=>'Chọn danh mục cha')+$this->arrCategoryParent, $dataSearch['category_parent_id']);
		$optionShowContent = FunctionLib::getOption($this->arrShowContent, $dataSearch['category_content_front']);

		return $view = theme('indexCategory',array(
									'title'=>'Danh mục sản phẩm',
									'result' => $treeCategroy,
									'dataSearch' => $dataSearch,
									'arrShowContent' => $this->arrShowContent,
									'optionStatus' => $optionStatus,
									'optionCategoryParent' => $optionCategoryParent,
									'optionShowContent' => $optionShowContent,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));

	}

	/**
	 * build cây danh mục
	 * @param $data
	 * @return array
	 */
	public function getTreeCategory($data){
		$max = 0;
		$aryCategoryProduct = $arrCategory = array();
		if(!empty($data)){
			foreach ($data as $k=>$value){
				$max = ($max < $value->category_parent_id)? $value->category_parent_id : $max;
				$arrCategory[$value->category_id] = array(
					'category_id'=>$value->category_id,
					'category_parent_id'=>$value->category_parent_id,
					'category_content_front'=>$value->category_content_front,
					'category_content_front_order'=>$value->category_content_front_order,
					'category_order'=>$value->category_order,
					'category_status'=>$value->category_status,
					'category_name'=>$value->category_name);
			}
		}

		if($max > 0){
			$aryCategoryProduct = self::showCategory($max, $arrCategory);
		}
		return $aryCategoryProduct;
	}
	public function showCategory($max, $aryDataInput) {
		$aryData = array();
		if(is_array($aryDataInput) && count($aryDataInput) > 0) {
			foreach ($aryDataInput as $k => $val) {
				if((int)$val['category_parent_id'] == 0) {
					$val['padding_left'] = '';
					$val['category_parent_name'] = '';
					$aryData[] = $val;
					self::showSubCategory($val['category_id'],$val['category_name'], $max, $aryDataInput, $aryData);
				}
			}
		}
		return $aryData;
	}
	public static function showSubCategory($cat_id,$cat_name, $max, $aryDataInput, &$aryData) {
		if($cat_id <= $max) {
			foreach ($aryDataInput as $chk => $chval) {
				if($chval['category_parent_id'] == $cat_id) {
					$chval['padding_left'] = '---------- ';
					$chval['category_parent_name'] = $cat_name;
					$aryData[] = $chval;
					self::showSubCategory($chval['category_id'],$chval['category_name'], $max, $aryDataInput, $aryData);
				}
			}
		}
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
				'category_content_front_order'=>array('value'=>FunctionLib::getIntParam('category_content_front_order',0)),
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
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_LIST_CATEGORY_PARENT_SHOW_HOME);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_TREE_MENU_CATEGORY_HEADER);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_OPTION_TREE_CATEGORY);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_CATEGORY_CHILDREN_PARENT_ID.$dataInput['category_parent_id']['value']);
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
							$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_TREE_MENU_CATEGORY_HEADER);
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