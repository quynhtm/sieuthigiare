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

	$arrFields = array('id', 'category_name', 'product_code','product_name', 'product_price_sell', 'product_price_market', 'product_content', 'time_created', 'status');
	$result = ShopManagerProduct::getSearchListItems($dataSearch, $limit, $arrFields);

	$arrCategoryChildren = DataCommon::getListCategoryChildren($user_shop->shop_category);
	$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $arrCategoryChildren, $dataSearch['category_id']);

	$arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
	$optionStatus = FunctionLib::getOption(array(-1=>'Chọn trạng thái') + $arrStatus, $dataSearch['status']);
	return theme('shopManagerProduct',array(
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

	$files = array(
       'bootstrap/lib/ckeditor/ckeditor.js',
       'bootstrap/lib/ckeditor/config.js',
       'bootstrap/lib/dragsort/jquery.dragsort.js',
    );
    Loader::loadJSExt('Core', $files);
    $files = array(
	    'bootstrap/lib/upload/cssUpload.css',
	    'bootstrap/js/bootstrap.min.js',
	    'bootstrap/lib/upload/jquery.uploadfile.js',
	    'js/common_admin.js',

	);
	Loader::load('Core', $files);

	if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
		$data = array(
				'id'=>array('value'=>FunctionLib::getIntParam('id',''), 'require'=>1, 'messages'=>''),
				'category_id'=>array('value'=>FunctionLib::getIntParam('category_id',''), 'require'=>1, 'messages'=>''),
				'product_code'=>array('value'=>FunctionLib::getParam('product_code',''), 'require'=>1, 'messages'=>'Mã sản phẩm không được trống!'),
				'product_name'=>array('value'=>FunctionLib::getParam('product_name',''), 'require'=>1, 'messages'=>'Tên sản phẩm không được trống!'),
				'product_price_sell'=>array('value'=>FunctionLib::getParam('product_price_sell',''), 'require'=>0, 'messages'=>''),
				'product_price_market'=>array('value'=>FunctionLib::getParam('product_price_market',''), 'require'=>0, 'messages'=>''),
				'product_content'=>array('value'=>FunctionLib::getParam('product_content',''), 'require'=>1, 'messages'=>'Chi tiết sản phẩm không được trống!'),
				'product_image'=>array('value'=>FunctionLib::getParam('image_primary','')),
				'user_shop_id'=>array('value'=>$user_shop->shop_id, 'require'=>0, 'messages'=>''),
				'time_created'=>array('value'=>time(), 'require'=>0, 'messages'=>''),
			);
		//lay lai vi tri sap xep cua anh khac
		$arrInputImgOther = array();
		$getImgOther = FunctionLib::getParam('img_other',array());

		if(!empty($getImgOther)){
			foreach($getImgOther as $k=>$val){
				if($val !=''){
					$arrInputImgOther[] = $val;
				}
			}
		}
		if (!empty($arrInputImgOther) && count($arrInputImgOther) > 0) {
			//neu ko co anh chinh, lay anh chinh la cai anh dau tien
			if($data['product_image']['value'] == ''){
				$data['product_image']['value'] = $arrInputImgOther[0];
			}
			$data['product_image_other']['value'] = serialize($arrInputImgOther);
		}

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
			if($data['category_id']['value'] > 0){
				$data['category_name']['value'] = ShopManagerProduct::getNameCategory($data['category_id']['value']);
			}
			ShopManagerProduct::save($data, $data['id']['value']);
			drupal_goto($base_url.'/quan-ly-gian-hang.html');
		}
	}
	$arrCategoryChildren = DataCommon::getListCategoryChildren($user_shop->shop_category);
	$dataCategory['category_id'] = $user_shop->shop_category;
	$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $arrCategoryChildren, $dataCategory['category_id']);

	return theme('shopPostProduct',array('optionCategoryChildren'=>$optionCategoryChildren));
}
function shopEditProduct(){
	global $base_url, $user_shop;
	
	if($user_shop->shop_id == 0){
		drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
		drupal_goto($base_url);
	}
	
	$files = array(
       'bootstrap/lib/ckeditor/ckeditor.js',
       'bootstrap/lib/ckeditor/config.js',
    );
    Loader::loadJSExt('Core', $files);

	$param = arg();
	if(count($param) == 3){
		$id = intval($param[1]);
		$fields = 'id, category_id, product_code, product_name, product_price_sell, product_price_market, product_content, user_shop_id';
		$cond = 'id='.$id.' AND user_shop_id='.$user_shop->shop_id;
		$arrItem = ShopManagerProduct::getItembyCond($fields, $cond);
		if(empty($arrItem)){
			drupal_set_message('Bạn không có quyền truy cập. Đây không phải là tin đăng của bạn!', 'error');
			drupal_goto($base_url.'/quan-ly-gian-hang.html');
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
				drupal_goto($base_url.'/sua-san-pham/'.$id.'/'.Stdio::pregReplaceStringAlias($arrItem->product_name).'.html');
			}else{
				$name_img = Upload::check_upload_file('product_image', '', $user_shop->shop_id);
				if($name_img != ''){
					$data['product_image']['value'] = $name_img;
				}

				$name_img_hover = Upload::check_upload_file('product_image_hover', '', $user_shop->shop_id);
				if($name_img_hover != ''){
					$data['product_image_hover']['value'] = $name_img_hover;
				}
				if($data['category_id']['value'] > 0 ){
					$data['category_name']['value'] = ShopManagerProduct::getNameCategory($data['category_id']['value']);
				}
				ShopManagerProduct::save($data, $id);
				drupal_goto($base_url.'/quan-ly-gian-hang.html');
			}
		}

		$arrCategoryChildren = DataCommon::getListCategoryChildren($user_shop->shop_category);
		$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $arrCategoryChildren, $arrItem->category_id);
		return theme('shopEditProduct',array('optionCategoryChildren'=>$optionCategoryChildren, 'arrItem'=>$arrItem));
	}else{
		drupal_set_message('Không tồn tại liên kết này!', 'error');
		drupal_goto($base_url.'/quan-ly-gian-hang.html');
	}
}
function shopDeleteProduct(){
	global $base_url, $user_shop;

	if($user_shop->shop_id == 0){
		drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
		drupal_goto($base_url);
	}
	$listId =  $_POST['id'];
	bug($listId);
}