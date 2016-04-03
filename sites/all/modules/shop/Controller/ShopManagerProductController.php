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

	$arrFields = array('id', 'category_name', 'product_code','product_name', 'product_price_sell', 'product_price_market', 'product_content', 'product_image', 'product_image_hover', 'time_created', 'status');
	$result = ShopManagerProduct::getSearchListItems($dataSearch, $limit, $arrFields);

	if(isset($result['data']) && !empty($result['data'])){
			foreach($result['data'] as $k => &$value){
				if( isset($value->product_image) && trim($value->product_image) != ''){
					$value->url_image = FunctionLib::getThumbImage($value->product_image,$value->id,FOLDER_PRODUCT,60,60);
					$value->url_image_hover = FunctionLib::getThumbImage($value->product_image_hover,$value->id,FOLDER_PRODUCT,300,150);
				}
			}
		}

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

function shopFormProduct(){
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

	$param = arg();
	$arrItem = array();
	$id = 0;
	$category_id = 0;
	
	if(isset($param[0]) && isset($param[1]) && isset($param[2]) && $param[0] == 'sua-san-pham' && $param[1] > 0 && $param[2] != ''){
		$id = intval($param[1]);
		$fields = 'id, category_id, product_code, product_name, product_price_sell, product_price_market, product_content, product_image, product_image_hover, product_image_other, user_shop_id, status';
		$cond = 'id='.$id.' AND user_shop_id='.$user_shop->shop_id;
		$arrItem = ShopManagerProduct::getItembyCond($fields, $cond);
		
		if(empty($arrItem)){
			drupal_set_message('Bạn không có quyền truy cập. Đây không phải là tin đăng của bạn!', 'error');
			drupal_goto($base_url.'/quan-ly-gian-hang.html');
		}

		$category_id = $arrItem->category_id;
	}
	
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
				'product_image_hover'=>array('value'=>FunctionLib::getParam('image_primary_hover','')),
				'user_shop_id'=>array('value'=>$user_shop->shop_id, 'require'=>0, 'messages'=>''),
				'user_shop_name'=>array('value'=>$user_shop->shop_name, 'require'=>0, 'messages'=>''),
				'shop_province'=>array('value'=>$user_shop->shop_province, 'require'=>0, 'messages'=>''),
				'status'=>array('value'=>1, 'require'=>0, 'messages'=>''),
			);
		
		if(!empty($arrItem)){
			$data['time_update']['value'] = time();
		}else{
			$data['time_created']['value'] = time();
		}
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
			//neu ko co anh hove, lay anh hove la cai anh dau tien
			if($data['product_image_hover']['value'] == ''){
				$data['product_image_hover']['value'] = $arrInputImgOther[0];
			}
			$data['product_image_other']['value'] = serialize($arrInputImgOther);
		}

		$errors = ValidForm::validInputData($data);
		if($errors != ''){
			if(!empty($arrItem)){
				drupal_set_message($errors, 'error');
				drupal_goto($base_url.'/sua-san-pham/'.$id.'/'.Stdio::pregReplaceStringAlias($arrItem->product_name).'.html');
			}else{
				drupal_set_message($errors, 'error');
				drupal_goto($base_url.'/dang-san-pham.html');
			}
		}else{
			if($data['category_id']['value'] > 0 ){
				$data['category_name']['value'] = ShopManagerProduct::getNameCategory($data['category_id']['value']);
			}

			if(!empty($arrItem)){
				if($data['id']['value'] != $id){
					drupal_set_message('Bạn không có quyền sửa tin đăng này!', 'error');
					drupal_goto($base_url.'/quan-ly-gian-hang.html');
				}
			}else{
				$id = $data['id']['value'];
			}
			ShopManagerProduct::save($data, $id);
			drupal_goto($base_url.'/quan-ly-gian-hang.html');
		}
	}

	$arrCategoryChildren = DataCommon::getListCategoryChildren($user_shop->shop_category);
	$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $arrCategoryChildren, $category_id);
	return theme('shopFormProduct',array('optionCategoryChildren'=>$optionCategoryChildren, 'arrItem'=>$arrItem));
}

function shopDeleteProduct(){
	global $base_url, $user_shop;

	if($user_shop->shop_id == 0){
		drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
		drupal_goto($base_url);
	}
	$listId =  FunctionLib::getParam('id',array());
	if(!empty($listId)){
		foreach($listId as $id){
			if($id > 0){
				ShopManagerProduct::deleteOne($id);
			}
		}
		drupal_set_message('Xóa bài viết thành công.');
	}
	drupal_set_message('Xóa sản phẩm thành công!');
	drupal_goto($base_url.'/quan-ly-gian-hang.html');
}