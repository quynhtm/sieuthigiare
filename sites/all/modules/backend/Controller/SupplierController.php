<?php
/*
* QuynhTM
 * Quan ly danh sach cac Shop
*/
class SupplierController{

	private $arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
	
	public function __construct(){
			
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

	function indexSupplier(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['supplier_name'] = FunctionLib::getParam('supplier_name','');
		$dataSearch['supplier_phone'] = FunctionLib::getParam('supplier_phone','');
		$dataSearch['supplier_email'] = FunctionLib::getParam('supplier_email','');
		$dataSearch['supplier_status'] = FunctionLib::getParam('supplier_status',-1);

		$result = Supplier::getSearchListItems($dataSearch,$limit,array());

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['supplier_status']);
		return $view = theme('indexSupplier',array(
			'title'=>'Danh sách NCC',
			'result' => $result['data'],
			'dataSearch' => $dataSearch,
			'optionStatus' => $optionStatus,
			'base_url' => $base_url,
			'totalItem' =>$result['total'],
			'pager' =>$result['pager']));
	}

	function deleteSupplierAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : 0;
			foreach($listId as $item){
				if($item > 0){
					Supplier::deleteId($item);
				}
			}
			drupal_set_message('Xóa Item thành công.');
		}
		drupal_goto($base_url.'/admincp/supplier');
	}
}