<?php
/*
* QuynhTM
*/
class ProductController{
	private $arrProductStatus = array(-1 => 'Tất cả', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE => 'Ẩn');
	private $arrIsBlock = array(-1 => 'Tất cả', BLOCK_TRUE => 'Không khóa', BLOCK_FALSE => 'Đang khóa');
	private $arrIsShop = array(-1 => 'Tất cả', SHOP_FREE => 'Shop Free', SHOP_NOMAL => 'Shop thường', SHOP_VIP => 'Shop VIP');

	private $arrTypePrice = array(-1 => '--Chọn kiểu giá--', TYPE_PRICE_NUMBER => 'Hiển thị giá bán', TYPE_PRICE_CONTACT => 'Liên hệ với shop');
	private $arrTypeProduct = array(-1 => '--Chọn loại sản phẩm--', PRODUCT_NOMAL => 'Sản phẩm bình thường', PRODUCT_HOT => 'Sản phẩm nổi bật', PRODUCT_SELLOFF => 'Sản phẩm giảm giá');
	private $arrCategory = array();
	private $arrUserShop = array();
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

		$this->arrCategory = DataCommon::getOptionTreeCategory();
		$this->arrUserShop = DataCommon::getListUserShop();
	}

	function indexProduct(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['product_status'] = FunctionLib::getParam('product_status', -1);
		$dataSearch['product_id'] = FunctionLib::getParam('product_id', -1);
		$result = Product::getSearchListItems($dataSearch,$limit,array());
		if(isset($result['data']) && !empty($result['data'])){
			foreach($result['data'] as $k => &$value){
				if( isset($value->product_image) && trim($value->product_image) != ''){
					$value->url_image = FunctionLib::getThumbImage($value->product_image,$value->product_id,FOLDER_PRODUCT,80,80);
					$value->url_image_hover = FunctionLib::getThumbImage($value->product_image,$value->product_id,FOLDER_PRODUCT,300,300);
				}
			}
		}

		//build option
		$optionStatus = FunctionLib::getOption($this->arrProductStatus, $dataSearch['product_status']);
		return $view = theme('indexProduct',array(
									'title'=>'San pham',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'arrProductStatus' => $this->arrProductStatus,
									'arrIsShop' => $this->arrIsShop,
									'arrIsBlock' => $this->arrIsBlock,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));
	}

	function formProductAction(){
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
		global $base_url;
	
		$param = arg();
		$arrItem = $arrImageOther = array();
		$item_id = 0;
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$item_id = (int)$param[3];
			$arrItem = Product::getItemById(array(), $item_id);

			//lấy mảng ảnh khách của item để chèn vào nội dung
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
			//FunctionLib::Debug($arrImageOther);
		}

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$item_id = FunctionLib::getParam('id', 0);
			$product_type_price = FunctionLib::getIntParam('product_type_price',TYPE_PRICE_NUMBER);
			$user_shop_id = FunctionLib::getParam('user_shop_id',0);
			$user_shop = ($user_shop_id > 0)? DataCommon::getShopById($user_shop_id): array();
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
				'product_order'=>array('value'=>FunctionLib::getIntParam('product_order',100)),

				'user_shop_id'=>array('value'=>$user_shop_id, 'require'=>0),
				'user_shop_name'=>array('value'=>isset($user_shop->shop_name)?$user_shop->shop_name:'', 'require'=>0),
				'shop_province'=>array('value'=>isset($user_shop->shop_province)?$user_shop->shop_province: 22, 'require'=>0),
				'is_shop'=>array('value'=>isset($user_shop->is_shop)?$user_shop->is_shop: SHOP_NOMAL, 'require'=>0),

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
				drupal_set_message($errors, 'error');
				if($item_id > 0){
					drupal_goto($base_url.'/admincp/product/edit/'.$item_id);
				}else{
					drupal_goto($base_url.'/admincp/product/add');
				}
			}else{
				//FunctionLib::Debug($dataInput);
				if($data['category_id']['value'] > 0 ){
					$arrCat = DataCommon::getCategoryById($data['category_id']['value']);
					if(!empty($arrCat)){
						$data['category_name']['value'] = $arrCat->category_name;
					}
				}
				//check nếu ko nhập giá bán thì cho về hiển thị kiểu liên hệ
				if($product_type_price == TYPE_PRICE_NUMBER){
					if((int)$data['product_price_sell']['value'] == 0){
						$data['product_type_price']['value'] = TYPE_PRICE_CONTACT;
					}
				}
				Product::save($data, $item_id);
				if(Cache::CACHE_ON){
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PRODUCT_ID.$item_id;
					$cache = new Cache();
					$cache->do_remove($key_cache);
				}
				drupal_goto($base_url.'/admincp/product');
			}
		}

		$optionCategory = FunctionLib::getOptionTreeCategory($this->arrCategory,isset($arrItem->category_id)? $arrItem->category_id : 0, array());
		$optionStatus = FunctionLib::getOption($this->arrProductStatus, isset($arrItem->product_status)? $arrItem->product_status : -1);
		$optionTypeProduct = FunctionLib::getOption($this->arrTypeProduct, isset($arrItem->product_is_hot)? $arrItem->product_is_hot : -1);
		$optionTypePrice = FunctionLib::getOption($this->arrTypePrice, isset($arrItem->product_type_price)? $arrItem->product_type_price : TYPE_PRICE_NUMBER);
		$optionUserShop = FunctionLib::getOption($this->arrUserShop, isset($arrItem->user_shop_id)? $arrItem->user_shop_id : 0);
		return theme('addProduct',
			array('optionCategory'=>$optionCategory,
				'optionStatus'=>$optionStatus,
				'optionTypeProduct'=>$optionTypeProduct,
				'optionTypePrice'=>$optionTypePrice,
				'optionUserShop'=>$optionUserShop,
				'arrItem'=>$arrItem,
				'title'=>'Sửa sản phẩm',
				'arrImageOther'=>$arrImageOther,));
	}

	function deleteProductAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = FunctionLib::getParam('checkItem',array());
			if(!empty($listId)){
				foreach($listId as $id){
					if($id > 0){
						Product::deleteOne($id);
					}
				}
				drupal_set_message('Xóa bài viết thành công.');
			}
		}
		drupal_goto($base_url.'/admincp/product');
	}

	function deleteCacheImageProductAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = FunctionLib::getParam('checkItem',array());
			if(!empty($listId)){
				foreach($listId as $id){
					if($id > 0){
						FunctionLib::delteImageCacheItem(FOLDER_PRODUCT, $id);
					}
				}
				drupal_set_message('Xóa cache ảnh thành công.');
			}
		}
		drupal_goto($base_url.'/admincp/product');
	}
}