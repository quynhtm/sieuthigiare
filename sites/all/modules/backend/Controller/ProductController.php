<?php
/*
* QuynhTM
*/
class ProductController{
	private $arrProductStatus = array(-1 => 'Tất cả', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE => 'Ẩn');
	private $arrIsBlock = array(-1 => 'Tất cả', BLOCK_TRUE => 'Không khóa', BLOCK_FALSE => 'Đang khóa');
	private $arrIsShop = array(-1 => 'Tất cả', SHOP_FREE => 'Shop Free', SHOP_NOMAL => 'Shop thường', SHOP_VIP => 'Shop VIP');
	private $arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
	public function __construct(){
		$files = array(
			'bootstrap/lib/ckeditor/ckeditor.js',
			'bootstrap/lib/ckeditor/config.js',
			'bootstrap/lib/dragsort/jquery.dragsort.js',
		);
		Loader::loadJSExt('Core', $files);
		$files = array(
			'bootstrap/lib/upload/cssUpload.css',
			'bootstrap/css/bootstrap.css',
			'css/font-awesome.css',
			'css/core.css',

			'bootstrap/js/bootstrap.min.js',
			'bootstrap/lib/upload/jquery.uploadfile.js',
			'js/common_admin.js',

		);
		Loader::load('Core', $files);
		$files = array(
			'View/css/admin.css',
			'View/js/admin.js',
		);
		Loader::load('Admin', $files);
	}

	function indexProduct(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['product_status'] = FunctionLib::getParam('product_status', -1);
		$dataSearch['product_id'] = FunctionLib::getParam('product_id', -1);
		$arrField = array('product_id', 'product_name',
			'product_price_sell', 'product_price_market', 'product_price_input','product_type_price',
			'product_selloff', 'product_is_hot','product_image', 'product_image_hover','product_image_other',
			'category_id', 'category_name',	'product_status', 'is_block','user_shop_id', 'user_shop_name','is_shop', 'shop_province','time_created', 'time_update');
		$result = Product::getSearchListItems($dataSearch,$limit,$arrField);
		if(isset($result['data']) && !empty($result['data'])){
			foreach($result['data'] as $k => &$value){
				if( isset($value->product_image) && trim($value->product_image) != ''){
					$value->url_image = FunctionLib::getThumbImage($value->product_image,$value->product_id,FOLDER_PRODUCT,80,80);
					$value->url_image_hover = FunctionLib::getThumbImage($value->product_image,$value->product_id,FOLDER_PRODUCT,450,200);
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
		global $base_url;
	
		$param = arg();
		$arrItem = $arrImageOther = array();
		$item_id = 0;
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$item_id = (int)$param[3];
			$arrItem = Product::getItemById(array(), $item_id);

			//lấy mảng ảnh khách của item để chèn vào nội dung
			if(!empty($arrItem)){
				if(isset($arrItem->news_image_other) && trim($arrItem->news_image_other) != ''){
					$arrOther = unserialize($arrItem->news_image_other);
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
			$dataInput = array(
				'news_title'=>array('value'=>FunctionLib::getParam('news_title',''), 'require'=>1, 'messages'=>'Tiêu đề tin bài không được trống!'),
				'news_desc_sort'=>array('value'=>FunctionLib::getParam('news_desc_sort','')),
				'news_image'=>array('value'=>FunctionLib::getParam('image_primary','')),
				'news_content'=>array('value'=>FunctionLib::getParam('news_content','')),
				'news_status'=>array('value'=>FunctionLib::getParam('news_status',0)),
				'news_category'=>array('value'=>FunctionLib::getParam('news_category',0)),
				'news_create'=>array('value'=>FunctionLib::getParam('news_create',0)),
				'news_type'=>array('value'=>FunctionLib::getParam('news_type',0)),
			);

			//lấy lại vị trí sắp xếp của ảnh khác
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
				//nếu không chọn ảnh chính, lấy ảnh chính là cái đầu tiên
				if($dataInput['news_image']['value'] == ''){
					$dataInput['news_image']['value'] = $arrInputImgOther[0];
				}
				$dataInput['news_image_other']['value'] = serialize($arrInputImgOther);
			}

			$errors = ValidForm::validInputData($dataInput);
			if($errors != ''){
				drupal_set_message($errors, 'error');
				if($item_id > 0){
					drupal_goto($base_url.'/admincp/product/edit/'.$item_id);
				}else{
					drupal_goto($base_url.'/admincp/product/add');
				}
			}else{
				//FunctionLib::Debug($dataInput);
				Product::save($dataInput, $item_id);
				if(Cache::CACHE_ON){
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PRODUCT_ID.$item_id;
					$cache = new Cache();
					$cache->do_remove($key_cache);
				}
				drupal_goto($base_url.'/admincp/product');
			}
		}
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->news_status) ? $arrItem->news_status: 0);
		return $view = theme('addProduct',
			array('arrItem'=>$arrItem,
				'item_id'=>$item_id,
				'arrImageOther'=>$arrImageOther,
				'title'=>'tin tức',
				'optionStatus'=>$optionStatus));
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