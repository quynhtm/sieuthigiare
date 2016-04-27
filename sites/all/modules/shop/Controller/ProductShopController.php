<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ProductShopController{
	
	public $shop_id = 0;
	public $category_id = 0;
	public $user_shop = array();

	private $arrStatus = array(-1 => '--Chọn trạng thái--', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE => 'Ẩn');
	private $arrTypePrice = array(-1 => '--Chọn kiểu giá--', TYPE_PRICE_NUMBER => 'Hiển thị giá bán', TYPE_PRICE_CONTACT => 'Liên hệ với shop');
	private $arrTypeProduct = array(-1 => '--Chọn loại sản phẩm--', PRODUCT_NOMAL => 'Sản phẩm bình thường', PRODUCT_HOT => 'Sản phẩm nổi bật', PRODUCT_SELLOFF => 'Sản phẩm giảm giá');

	public function productShop(){
		global $base_url, $user_shop;

		if($user_shop->shop_id == 0){
			//drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
			drupal_goto($base_url.'/dang-nhap.html');
		}

		//check full infomation
		if($user_shop->shop_name == '' || $user_shop->shop_phone == '' || $user_shop->shop_email == '' || $user_shop->shop_category <=0 || $user_shop->shop_province <= 0){
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
		$dataSearch['product_id'] = FunctionLib::getParam('product_id',0);
		$dataSearch['product_name'] = trim(FunctionLib::getParam('product_name',''));
		$dataSearch['category_id'] = FunctionLib::getParam('category_id', -1);
		$dataSearch['product_status'] = FunctionLib::getParam('product_status', -1);
		$dataSearch['date_start'] = FunctionLib::getParam('date_start', '');
		$dataSearch['date_end'] = FunctionLib::getParam('date_end', '');
		
		$arrFields = array('product_id', 'category_name', 'product_code','product_name', 'product_price_sell', 'product_price_market', 'product_price_input', 'product_content', 'product_image', 'product_image_hover', 'time_created', 'product_status');
		$result = ProductShop::getSearchListItems($dataSearch, $limit, $arrFields);
		//FunctionLib::Debug($result);
		if(isset($result['data']) && !empty($result['data'])){
			foreach($result['data'] as $k => &$value){
				if( isset($value->product_image) && trim($value->product_image) != ''){
					$value->url_image = FunctionLib::getThumbImage($value->product_image,$value->product_id,FOLDER_PRODUCT,80,80);
					$value->image_big = FunctionLib::getThumbImage($value->product_image,$value->product_id,FOLDER_PRODUCT,300,400);
				}
			}
		}
		//FunctionLib::Debug($result);

		$arrCategoryChildren = DataCommon::getListCategoryChildren($user_shop->shop_category);
		$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $arrCategoryChildren, $dataSearch['category_id']);

		$arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
		$optionStatus = FunctionLib::getOption(array(-1=>'Chọn trạng thái') + $arrStatus, $dataSearch['product_status']);
		return theme('productShop',array(
									'title'=>'Cấu hình chung',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager'],
									'optionStatus' =>$optionStatus,
									'optionCategoryChildren'=>$optionCategoryChildren));
	}

	public function productFormShop(){
		global $base_url, $user_shop;
		if($user_shop->shop_id == 0){
			//drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
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
			$arrItem = ProductShop::getItembyCond($fields, $cond);
			
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
							'image_small'=> FunctionLib::getThumbImage($val_other,$arrItem->product_id,FOLDER_PRODUCT,80,80),
							'image_big'=> FunctionLib::getThumbImage($val_other,$arrItem->product_id,FOLDER_PRODUCT,700,700),
						);
					}
				}
			}
		}
		
		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$id = FunctionLib::getParam('id', 0);
			$product_type_price = FunctionLib::getIntParam('product_type_price',TYPE_PRICE_NUMBER);
			$data = array(
					'category_id'=>array('value'=>FunctionLib::getIntParam('category_id',''), 'require'=>1, 'messages'=>'Chưa chọn danh mục sản phẩm'),
					'product_name'=>array('value'=>FunctionLib::getParam('product_name',''), 'require'=>1, 'messages'=>'Tên sản phẩm không được trống!'),
					'product_content'=>array('value'=>FunctionLib::getParam('product_content',''), 'require'=>1, 'messages'=>'Chi tiết sản phẩm không được trống!'),
					'product_sort_desc'=>array('value'=>FunctionLib::getParam('product_sort_desc',''), 'require'=>1, 'messages'=>'Chi tiết sản phẩm không được trống!'),

					'product_price_sell'=>array('value'=>FunctionLib::getIntParam('product_price_sell_hide',0)),
					'product_price_market'=>array('value'=>FunctionLib::getIntParam('product_price_market_hide',0)),
					'product_price_input'=>array('value'=>FunctionLib::getIntParam('product_price_input_hide',0)),

					'product_selloff'=>array('value'=>FunctionLib::getParam('product_selloff','')),
					'product_image'=>array('value'=>FunctionLib::getParam('image_primary','')),
					'product_image_hover'=>array('value'=>FunctionLib::getParam('image_primary_hover','')),
					'product_order'=>array('value'=>FunctionLib::getIntParam('product_order','')),

					'user_shop_id'=>array('value'=>$user_shop->shop_id, 'require'=>0),
					'user_shop_name'=>array('value'=>$user_shop->shop_name, 'require'=>0),
					'shop_province'=>array('value'=>$user_shop->shop_province, 'require'=>0),
					'is_shop'=>array('value'=>$user_shop->is_shop, 'require'=>0),

					'product_status'=>array('value'=>FunctionLib::getIntParam('product_status',STASTUS_HIDE), 'require'=>0),
					'product_is_hot'=>array('value'=>FunctionLib::getIntParam('product_is_hot',PRODUCT_NOMAL), 'require'=>0),
					'product_type_price'=>array('value'=>$product_type_price),
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
				if($data['category_id']['value'] > 0 ){
					$arrCat = DataCommon::getCategoryById($data['category_id']['value']);
					if(!empty($arrCat)){
						$data['category_name']['value'] = $arrCat->category_name;
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
				ProductShop::save($data, $id);
				if(Cache::CACHE_ON){
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PRODUCT_ID.$id;
					$cache = new Cache();
					$cache->do_remove($key_cache);
				}
				drupal_goto($base_url.'/quan-ly-gian-hang.html');
			}
		}

		$arrCategoryChildren = DataCommon::getListCategoryChildren($user_shop->shop_category);
		$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $arrCategoryChildren, isset($arrItem->category_id)? $arrItem->category_id : -1);
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->product_status)? $arrItem->product_status : -1);
		$optionTypeProduct = FunctionLib::getOption($this->arrTypeProduct, isset($arrItem->product_is_hot)? $arrItem->product_is_hot : -1);
		$optionTypePrice = FunctionLib::getOption($this->arrTypePrice, isset($arrItem->product_type_price)? $arrItem->product_type_price : TYPE_PRICE_NUMBER);
		return theme('productFormShop',
			array('optionCategoryChildren'=>$optionCategoryChildren,
				'optionStatus'=>$optionStatus,
				'optionTypeProduct'=>$optionTypeProduct,
				'optionTypePrice'=>$optionTypePrice,
				'arrItem'=>$arrItem,
				'title'=>$title,
				'arrImageOther'=>$arrImageOther,));
	}

	public function productDeleteShop(){
		global $base_url, $user_shop;

		if($user_shop->shop_id == 0){
			//drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
			drupal_goto($base_url.'/dang-nhap.html');
		}
		$listId =  FunctionLib::getParam('id',array());
		if(!empty($listId)){
			foreach($listId as $id){
				if($id > 0){
					ProductShop::deleteId($id);
				}
			}
			drupal_set_message('Xóa bài viết thành công.');
		}
		drupal_set_message('Xóa sản phẩm thành công!');
		drupal_goto($base_url.'/quan-ly-gian-hang.html');
	}

	public function indexShop(){
		
		$this->cacheShop();

		$limit = (isset($this->user_shop->is_shop) && $this->user_shop->is_shop = SHOP_VIP) ? SITE_RECORD_PER_PAGE_SHOP_VIP: SITE_RECORD_PER_PAGE_SHOP_NORMAL;
		$arrFields = array('product_id', 'category_name','product_name', 'product_price_sell', 'product_price_market', 'product_image', 'product_image_hover', 'product_type_price', 'product_selloff', 'user_shop_id', 'user_shop_name');
		$result = ProductShop::getIndexShop($this->shop_id,$this->category_id, $limit, $arrFields);

		$phone = '';
		$arrCategoryChildren = array();

		if(isset($result['data']) && !empty($result['data'])){
			foreach($result['data'] as $k => &$value){
				if( isset($value->product_image) && trim($value->product_image) != ''){
					$value->url_image = $value->url_image_hover = FunctionLib::getThumbImage($value->product_image,$value->product_id,FOLDER_PRODUCT,300,300);
					if($value->product_image_hover != ''){
						$value->url_image_hover = FunctionLib::getThumbImage($value->product_image_hover,$value->product_id,FOLDER_PRODUCT,300,300);
					}
				}
			}	
		}
		
		if(!empty($this->user_shop)){
			$phone = $this->user_shop->shop_phone;
			//get list cagegory left shop
			$shop_category = $this->user_shop->shop_category;
			$arrCategoryChildren = DataCommon::getListCategoryChildren($shop_category);
		}
		
		$bannerList = DataCommon::getBannerAdvanced(BANNER_TYPE_HOME_BIG, BANNER_PAGE_HOME, $shop_category, 0);

		return theme('indexShop', array(
										'arrCategoryChildren'=>$arrCategoryChildren,
										'result'=>$result['data'],
										'phone'=>$phone,
										'user_shop'=>$this->user_shop,
										'pager' =>$result['pager'],
										'category_id' =>$this->category_id,
										'category_parent' =>$this->category_id,
										'bannerList' =>$bannerList,
										));
	}

	public function detailShop(){
		global $base_url;

		$param = arg();

		$files = array(
	            'bootstrap/lib/jcarousel/jquery.jcarousel.min.js',
	            'bootstrap/lib/jcarousel/jcarousel.responsive.js',
	            'bootstrap/lib/jcarousel/jcarousel.responsive.css',
	        );
	    Loader::load('Core', $files);

	    $files = array(
	            'View/js/shop.js',
	        );
	    Loader::load('Shop', $files);
	   
	    $product_id = 0;
	    $category_id = 0;
	    if(isset($param[1]) && $param[1] != ''){
			$product_id = FunctionLib::cutStr($param[1], 1, 0);
		}
		
		$result = DataCommon::getProductById($product_id);
		
	    if(!empty($result)){
	   	 	
	   	 	if(isset($result->product_status) && $result->product_status != STASTUS_SHOW){
	   	 		drupal_goto($base_url.'/page-404');
	   	 	}

	   	 	if(isset($result->is_block) && $result->is_block != PRODUCT_NOT_BLOCK){
	   	 		drupal_goto($base_url.'/page-404');
	   	 	}

	   	 	$this->user_shop = DataCommon::getShopById($result->user_shop_id);
	   	 	$category_id = $result->category_id;
	   	 	//check shop bi khoa
	   	 	if(!empty($this->user_shop)){
	   	 		$shop_status = $this->user_shop->shop_status;
	   	 		if($shop_status != STASTUS_SHOW){
					drupal_goto($base_url.'/page-404');
				}
	   	 	}

	    }else{
	    	drupal_goto($base_url.'/page-404');
	    }
	    //san pham ban co the quan tam
	     $arrFields = array('product_id', 'product_name', 'product_price_sell', 
	     					'product_price_market', 'product_image', 
	    					'product_image_hover','product_type_price', 'product_selloff'
	    					);

	    $arrSame = ProductShop::getProductSameCatShop($product_id, $category_id, 15, $arrFields, false);
	   	if(count($arrSame) < 15){
	   		$arrSame1 = ProductShop::getProductSameCatShop($product_id, $category_id, 15 - count($arrSame), $arrFields, true);
	   		$arrSame = array_merge($arrSame, $arrSame1);
	   	}

		return theme('detailShop', array(
										'result'=>$result,
										'user_shop'=>$this->user_shop,
										'arrSame'=>$arrSame,
									)
								);
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
