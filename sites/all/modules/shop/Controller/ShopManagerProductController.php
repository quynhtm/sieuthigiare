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
	$dataSearch['product_code'] = FunctionLib::getParam('product_code','');
	$dataSearch['product_name'] = FunctionLib::getParam('product_name','');
	$dataSearch['category_id'] = FunctionLib::getParam('category_id','');
	$dataSearch['status'] = FunctionLib::getParam('status', -1);

	$arrFields = array('id', 'product_code','product_name', 'product_price_sell', 'product_price_market', 'product_content', 'time_created', 'status');
	$result = ShopManagerProduct::getSearchListItems($dataSearch, $limit, $arrFields);

	$arrCategoryChildren = DataCommon::getListCategoryChildren($user_shop->shop_category);
	$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $arrCategoryChildren, $dataSearch['category_id']);

	$arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
	$optionStatus = FunctionLib::getOption(array(-1=>'Chọn trạng thái') + $arrStatus, $dataSearch['status']);
	return $view = theme('shopManagerProduct',array(
								'title'=>'Cấu hình chung',
								'result' => $result['data'],
								'dataSearch' => $dataSearch,
								'totalItem' =>$result['total'],
								'pager' =>$result['pager'],
								'optionStatus' =>$optionStatus,
								'optionCategoryChildren'=>$optionCategoryChildren));
}
function shopPostProduct(){
	global $base_url, $user_shop;

	if($user_shop->shop_id == 0){
		drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
		drupal_goto($base_url);
	}
	if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
		$data = array(
				'category_id'=>array('value'=>FunctionLib::getIntParam('category_id',''), 'require'=>1, 'messages'=>''),
				'product_code'=>array('value'=>FunctionLib::getParam('product_code',''), 'require'=>1, 'messages'=>'Mã sản phẩm không được trống!'),
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
	$arrCategoryChildren = DataCommon::getListCategoryChildren($user_shop->shop_category);
	$dataCategory['category_id'] = $user_shop->shop_category;
	$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $arrCategoryChildren, $dataCategory['category_id']);

	return $view = theme('shopPostProduct',array('optionCategoryChildren'=>$optionCategoryChildren));
}
function shopEditProduct(){
	global $base_url, $user_shop;

	if($user_shop->shop_id == 0){
		drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
		drupal_goto($base_url);
	}
	$param = arg();
	bug($param);
}