<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
function shopManagerProduct(){
	global $base_url, $user_shop;

	if($user_shop->shop_id == 0){
		drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
		drupal_goto($base_url);
	}

	$limit = SITE_RECORD_PER_PAGE;
	//search
	$dataSearch['title'] = FunctionLib::getParam('title','');
	$dataSearch['status'] = FunctionLib::getParam('status', -1);

	$arrFields = array('id', 'product_name', 'product_price_sell', 'time_created', 'status');
	$result = ShopManagerProduct::getSearchListItems($dataSearch, $limit, $arrFields);

	return $view = theme('shopManagerProduct',array(
								'title'=>'Cấu hình chung',
								'result' => $result['data'],
								'dataSearch' => $dataSearch,
								'totalItem' =>$result['total'],
								'pager' =>$result['pager']));

}
function shopPostProduct(){
	global $base_url, $user_shop;

	if($user_shop->shop_id == 0){
		drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
		drupal_goto($base_url);
	}
	return $view = theme('shopPostProduct',array());
}