<?php
/*
* QuỳnhTM
*/
class ProviderShopController{
	
	public $shop_id = 0;
	public $category_id = 0;
	public $user_shop = array();

	private $arrStatus = array(-1 => '--Chọn trạng thái--', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE => 'Ẩn');
	private $arrTypePrice = array(-1 => '--Chọn kiểu giá--', TYPE_PRICE_NUMBER => 'Hiển thị giá bán', TYPE_PRICE_CONTACT => 'Liên hệ với shop');
	private $arrTypeProduct = array(-1 => '--Chọn loại sản phẩm--', PRODUCT_NOMAL => 'Sản phẩm bình thường', PRODUCT_HOT => 'Sản phẩm nổi bật', PRODUCT_SELLOFF => 'Sản phẩm giảm giá');

	public function providerShop(){
		global $base_url, $user_shop;

		if($user_shop->shop_id == 0){
			drupal_goto($base_url.'/dang-nhap.html');
		}

		//check full infomation
		if($user_shop->shop_name == '' || $user_shop->shop_phone == '' || $user_shop->shop_email == '' || $user_shop->shop_category =='' || $user_shop->shop_province <= 0){
			drupal_set_message('Bạn vui lòng nhập đầy đủ thông tin. Các trường có dấu (*) là bắt buộc!');
			drupal_goto($base_url.'/sua-thong-tin-gian-hang.html');
		}

		$files = array(
			'bootstrap/lib/datetimepicker/datetimepicker.css',
			'bootstrap/lib/datetimepicker/jquery.datetimepicker.js',
		);
		Loader::load('Core', $files);
		$files = array(
			'bootstrap/css/bootstrap.css',
			'css/font-awesome.css',
			'css/core.css',
			'bootstrap/js/bootstrap.min.js',
		);
		Loader::load('Core', $files);
		$files = array(
			'View/css/admin.css',
			'View/js/admin.js',
		);
		Loader::load('Admin', $files);

		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['provider_name'] = trim(FunctionLib::getParam('provider_name',''));
		$dataSearch['provider_phone'] = trim(FunctionLib::getParam('provider_phone',''));
		$dataSearch['provider_email'] = trim(FunctionLib::getParam('provider_email',''));
		$dataSearch['provider_status'] = FunctionLib::getParam('provider_status', -1);
		$dataSearch['date_start'] = FunctionLib::getParam('date_start', '');
		$dataSearch['date_end'] = FunctionLib::getParam('date_end', '');
		
		$arrFields = array('provider_id', 'provider_name', 'provider_phone','provider_address',
			'provider_email', 'provider_shop_id', 'provider_shop_name', 'provider_status', 'provider_note', 'provider_time_creater');
		$result = ProviderShop::getSearchListItems($dataSearch, $limit, $arrFields);

		$optionStatus = FunctionLib::getOption(array(-1=>'Chọn trạng thái') + $this->arrStatus, $dataSearch['provider_status']);
		return theme('providerShop',array(
									'title'=>'Quản lý NCC',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager'],
									'optionStatus' =>$optionStatus));
	}
	public function providerFormShop(){
		global $base_url, $user_shop;
		if($user_shop->shop_id == 0){
			drupal_goto($base_url.'/dang-nhap.html');
		}
		//check full infomation
		if($user_shop->shop_name == '' || $user_shop->shop_phone == '' || $user_shop->shop_email == '' || $user_shop->shop_category <=0 || $user_shop->shop_province <= 0){
			drupal_set_message('Bạn vui lòng nhập đầy đủ thông tin. Các trường có dấu (*) là bắt buộc!');
			drupal_goto($base_url.'/sua-thong-tin-gian-hang.html');
		}

		$files = array(
			'bootstrap/lib/ckeditor/ckeditor.js',
			'bootstrap/lib/ckeditor/config.js',
			'bootstrap/lib/dragsort/jquery.dragsort.js',
			'js/autoNumeric.js',
		);
		Loader::loadJSExt('Core', $files);
		$files = array(
			'bootstrap/lib/upload/cssUpload.css',
			'bootstrap/js/bootstrap.min.js',
			'bootstrap/lib/upload/jquery.uploadfile.js',
			'js/common_admin.js',

			'bootstrap/lib/datetimepicker/datetimepicker.css',
			'bootstrap/lib/datetimepicker/jquery.datetimepicker.js',
		);
		Loader::load('Core', $files);
		$param = arg();
		$arrItem = array();
		$id = 0;
		$title = 'Thêm mới sản phẩm';
		$arrImageOther  = array();
		if(isset($param[0]) && isset($param[1]) && isset($param[2]) && $param[0] == 'sua-san-pham' && $param[1] > 0 && $param[2] != ''){
			$id = intval($param[1]);
			$fields = '';
			$cond = 'product_id='.$id.' AND user_shop_id='.$user_shop->shop_id;
			$arrItem = ProviderShop::getItembyCond($fields, $cond);
			
			if(empty($arrItem)){
				drupal_set_message('Bạn không có quyền truy cập. Đây không phải là tin đăng của bạn!', 'error');
				drupal_goto($base_url.'/quan-ly-gian-hang.html');
			}

			$title = 'Sửa sản phẩm';

			//lay mang anh de chen vao noi dung
			if(!empty($arrItem)){
				if(isset($arrItem->product_image_other) && trim($arrItem->product_image_other) != ''){
					$arrOther = unserialize($arrItem->product_image_other);
					foreach($arrOther as $k =>$val_other){
						$arrImageOther[] = array(
							'image_small'=> ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $arrItem->product_id, $val_other, 80, 80, '', true, true),
							'image_big'=> ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $arrItem->product_id, $val_other, 700, 700, '', true, true),
						);
					}
				}
			}
		}
		
		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$id = FunctionLib::getParam('id', 0);
			$product_type_price = FunctionLib::getIntParam('product_type_price',TYPE_PRICE_CONTACT);

			$product_price_sell = (int)str_replace('.','',FunctionLib::getParam('product_price_sell'));//giá bán
			$product_price_market = (int)str_replace('.','',FunctionLib::getParam('product_price_market'));//giá thị trường
			$product_price_input = (int)str_replace('.','',FunctionLib::getParam('product_price_input'));//giá nhập
			$data = array(
					'category_id'=>array('value'=>FunctionLib::getIntParam('category_id',''), 'require'=>0, 'messages'=>'Chưa chọn danh mục sản phẩm'),
					'product_name'=>array('value'=>FunctionLib::getParam('product_name',''), 'require'=>1, 'messages'=>'Tên sản phẩm không được trống!'),
					'product_content'=>array('value'=>FunctionLib::getParam('product_content',''), 'require'=>0, 'messages'=>'Chi tiết sản phẩm không được trống!'),
					'product_sort_desc'=>array('value'=>FunctionLib::getParam('product_sort_desc',''), 'require'=>0, 'messages'=>'Chi tiết sản phẩm không được trống!'),

					'product_price_sell'=>array('value'=>$product_price_sell),
					'product_price_market'=>array('value'=>$product_price_market),
					'product_price_input'=>array('value'=>$product_price_input),

					'product_selloff'=>array('value'=>FunctionLib::getParam('product_selloff','')),
					'product_image'=>array('value'=>FunctionLib::getParam('image_primary','')),
					'product_image_hover'=>array('value'=>FunctionLib::getParam('image_primary_hover','')),
					'product_order'=>array('value'=>FunctionLib::getIntParam('product_order','')),

					'user_shop_id'=>array('value'=>$user_shop->shop_id, 'require'=>0),
					'user_shop_name'=>array('value'=>$user_shop->shop_name, 'require'=>0),
					'shop_province'=>array('value'=>$user_shop->shop_province, 'require'=>0),
					'is_shop'=>array('value'=>$user_shop->is_shop, 'require'=>0),
					'time_update'=>array('value'=>time(), 'require'=>0),

					'product_status'=>array('value'=>FunctionLib::getIntParam('product_status',STASTUS_SHOW), 'require'=>0),
					'product_is_hot'=>array('value'=>FunctionLib::getIntParam('product_is_hot',PRODUCT_NOMAL), 'require'=>0),
					'product_type_price'=>array('value'=>$product_type_price),
				);
			//FunctionLib::Debug($data);
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
					$data['product_image_hover']['value'] = (isset($arrInputImgOther[1]))?$arrInputImgOther[1]:$arrInputImgOther[0];
				}elseif($data['product_image_hover']['value'] != ''){
					if($data['product_image']['value'] != '' && strcmp($data['product_image']['value'],$data['product_image_hover']['value']) == 0){
						$data['product_image_hover']['value'] = (isset($arrInputImgOther[1]))?$arrInputImgOther[1]:$arrInputImgOther[0];
					}
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
				$category_parent_id = 0;
				if($data['category_id']['value'] > 0 ){
					$arrCat = DataCommon::getCategoryById($data['category_id']['value']);
					if(!empty($arrCat)){
						$data['category_name']['value'] = $arrCat->category_name;
						$category_parent_id = $arrCat->category_parent_id;
					}
				}
				if(!empty($arrItem)){
					if($arrItem->product_id != $id){
						drupal_set_message('Bạn không có quyền sửa tin đăng này!', 'error');
						drupal_goto($base_url.'/quan-ly-gian-hang.html');
					}
				}
				//check nếu ko nhập giá bán thì cho về hiển thị kiểu liên hệ
				if($product_type_price == TYPE_PRICE_NUMBER){
					if((int)$data['product_price_sell']['value'] == 0){
						$data['product_type_price']['value'] = TYPE_PRICE_CONTACT;
					}
				}
				ProviderShop::save($data, $id);
				if(Cache::CACHE_ON){
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PRODUCT_ID.$id;
					$cache = new Cache();
					$cache->do_remove($key_cache);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_PRODUCTS_HOME_WITH_CATE_PARENT_ID.$category_parent_id);
				}
				drupal_goto($base_url.'/quan-ly-gian-hang.html');
			}
		}

		$arrCategoryChildren = DataCommon::buildCacheTreeCategoryWithShop($user_shop->shop_id);
		$treeCategoryShop = self::showTreeCategoryShop($arrCategoryChildren);
		$arrCateParenId = ($user_shop->shop_category != '')? explode(',',$user_shop->shop_category): array();
		$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $treeCategoryShop, isset($arrItem->category_id)? $arrItem->category_id : -1,$arrCateParenId);

		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->product_status)? $arrItem->product_status : -1);
		$optionTypeProduct = FunctionLib::getOption($this->arrTypeProduct, isset($arrItem->product_is_hot)? $arrItem->product_is_hot : -1);
		$optionTypePrice = FunctionLib::getOption($this->arrTypePrice, isset($arrItem->product_type_price)? $arrItem->product_type_price : TYPE_PRICE_NUMBER);
		return theme('providerFormShop',
			array('optionCategoryChildren'=>$optionCategoryChildren,
				'optionStatus'=>$optionStatus,
				'optionTypeProduct'=>$optionTypeProduct,
				'optionTypePrice'=>$optionTypePrice,
				'arrItem'=>$arrItem,
				'title'=>$title,
				'arrImageOther'=>$arrImageOther,));
	}
	public function providerDeleteShop(){
		global $base_url, $user_shop;

		if($user_shop->shop_id == 0){
			drupal_goto($base_url.'/dang-nhap.html');
		}
		$id =  FunctionLib::getParam('id',array());
		if($id > 0){
			ProviderShop::deleteId($id);
			drupal_set_message('Xóa bài viết thành công.');
		}
		drupal_goto($base_url.'/quan-ly-gian-hang.html');
	}

	public function cacheShop(){
		global $base_url;
		//lay param khi vao trang shop
		$param = arg();
		//shop_id
		if(isset($param[1]) && $param[1] != ''){
			$this->shop_id = intval($param[1]);
		}
		//category_id
		if(isset($param[2]) && $param[2] != ''){
			$this->category_id= FunctionLib::cutStr($param[2], 1, 0);
		}

		//kiem tra xem shop do co ton tai hay ko
		if($this->shop_id > 0){
			$this->user_shop = DataCommon::getShopById($this->shop_id);
			if(!empty($this->user_shop)){
				if(isset($this->user_shop->shop_status) && $this->user_shop->shop_status != STASTUS_SHOW){
					drupal_goto($base_url.'/page-404');
				}
			}else{
				drupal_goto($base_url.'/page-404');
			}
		}else{
			drupal_goto($base_url.'/page-404');
		}

		$files = array(
	            	'css/font-awesome.css',
	        	);
	    Loader::load('Core', $files);
	}
}
