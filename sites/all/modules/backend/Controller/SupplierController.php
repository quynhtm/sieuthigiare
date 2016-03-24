<?php
/*
* QuynhTM
 * Quan ly danh sach cac Shop
*/
class SupplierController{
	function indexSupplier(){
		global $base_url;

		$limit = SITE_RECORD_PER_PAGE;
		
		$dataSearch['supplier_full_name'] = FunctionLib::getParam('supplier_full_name','');
		$dataSearch['supplier_status'] = FunctionLib::getParam('supplier_status','');
		
		$arrFields = array('id', 'supplier_full_name', 'supplier_phone', 'supplier_hot_line', 'supplier_email', 'supplier_website', 'supplier_status', 'supplier_created');
		$result = Supplier::getSearchListItems($dataSearch, $arrFields, $limit);
		
		$view = theme('indexSupplier',array(
									'title'=>'Danh sách các User Shop',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));
		return $view;
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
			drupal_set_message('Xóa bài viết thành công.');
		}
		drupal_goto($base_url.'/admincp/usershop');
	}
}