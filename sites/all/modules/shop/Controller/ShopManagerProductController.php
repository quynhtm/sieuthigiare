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

	$arrFields = array('id', 'product_name', 'product_price_sell', 'product_price_market', 'product_content', 'time_created', 'status');
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
	if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
		$data = array(
				//'category_id'=>array('value'=>FunctionLib::getParam('category_id',''), 'require'=>1, 'messages'=>''),
				'product_name'=>array('value'=>FunctionLib::getParam('product_name',''), 'require'=>1, 'messages'=>'Tên sản phẩm không được trống!'),
				'product_price_sell'=>array('value'=>FunctionLib::getParam('product_price_sell',''), 'require'=>0, 'messages'=>''),
				'product_price_market'=>array('value'=>FunctionLib::getParam('product_price_market',''), 'require'=>0, 'messages'=>''),
				'product_content'=>array('value'=>FunctionLib::getParam('product_content',''), 'require'=>1, 'messages'=>'Chi tiết sản phẩm không được trống!'),
				'user_shop_id'=>array('value'=>$user_shop->shop_id, 'require'=>0, 'messages'=>''),
				'time_created'=>array('value'=>time(), 'require'=>0, 'messages'=>''),
			);

		$errors = ValidForm::validInputData($data);
		if($errors != ''){
			drupal_set_message($errors, 'error');
			drupal_goto($base_url.'/dang-san-pham.html');
		}else{
			$name_img = Upload::check_upload_file('product_image', '', $user_shop->shop_id);
			if($name_img != ''){
				$data['product_image']['value'] = $name_img;
			}

			$name_img_hover = Upload::check_upload_file('product_image_hover', '', $user_shop->shop_id);
			
			if($name_img_hover != ''){
				$data['product_image_hover']['value'] = $name_img;
			}

			ShopManagerProduct::save($data, 0);
			drupal_goto($base_url.'/quan-ly-gian-hang.html');
		}
	}
	return $view = theme('shopPostProduct',array());
}
function shopEditProduct(){
	
}