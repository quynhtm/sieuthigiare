<?php
/*
* QuynhTM
*/
class ProvinceController{

	private $arrStatus = array(-1 => 'Tất cả', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE=> 'Ẩn');
	
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

	function indexProvince(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['province_name'] = FunctionLib::getParam('province_name','');
		$dataSearch['province_status'] = FunctionLib::getParam('province_status', -1);

		$getFields = array('province_id', 'province_name', 'province_position', 'province_status');
		$result = Province::getSearchListItems($dataSearch,$limit,$getFields);

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['province_status']);

		return $view = theme('indexProvince',array(
									'title'=>'Danh sách tỉnh/thành',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));
	}

	function formProvinceAction(){
		global $base_url;
		$param = arg();
		$arrItem = array();
		$item_id = 0;
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$item_id = (int)$param[3];
			$arrItem = Province::getItemById(array(), $item_id);
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
					drupal_goto($base_url.'/admincp/province/edit/'.$item_id);
				}else{
					drupal_goto($base_url.'/admincp/province/add');
				}
			}else{
				Province::save($dataInput, $item_id);
				if(Cache::CACHE_ON){
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PROVINCE;
					$cache = new Cache();
					$cache->do_remove($key_cache);
				}
				drupal_goto($base_url.'/admincp/province');
			}
		}
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->province_status) ? $arrItem->province_status: -1);
		return $view = theme('addProvince',
			array('arrItem'=>$arrItem,
				'item_id'=>$item_id,
				'title'=>'tỉnh/thành',
				'optionStatus'=>$optionStatus));
	}

	function deleteProvinceAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : array();
			if(!empty($listId)){
				foreach($listId as $item_id){
					if($item_id > 0){
						Province::deleteId($item_id);
					}
				}
				if(Cache::CACHE_ON){
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PROVINCE;
					$cache = new Cache();
					$cache->do_remove($key_cache);
				}
				drupal_set_message('Xóa bài viết thành công.');
			}
		}
		drupal_goto($base_url.'/admincp/province');
	}
}