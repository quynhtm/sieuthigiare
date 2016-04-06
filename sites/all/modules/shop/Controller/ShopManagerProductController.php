<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ShopManagerProductController{
	private $arrStatus = array(-1 => '--Chọn trạng thái--', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE => 'Ẩn');
	private $arrTypePrice = array(-1 => '--Chọn kiểu giá--', TYPE_PRICE_NUMBER => 'Hiển thị giá bán', TYPE_PRICE_CONTACT => 'Liên hệ với shop');
	private $arrTypeProduct = array(-1 => '--Chọn loại sản phẩm--',
		PRODUCT_NOMAL => 'Sản phẩm bình thường',
		PRODUCT_HOT => 'Sản phẩm nổi bật',
		PRODUCT_SELLOFF => 'Sản phẩm giảm giá');
	public function __construct(){
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
	}
	public function shopManagerProduct(){
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
		$dataSearch['product_status'] = FunctionLib::getParam('product_status', -1);
		$dataSearch['date_start'] = FunctionLib::getParam('date_start', '');
		$dataSearch['date_end'] = FunctionLib::getParam('date_end', '');
		
		$arrFields = array('product_id', 'category_name', 'product_code','product_name', 'product_price_sell', 'product_price_market', 'product_content', 'product_image', 'product_image_hover', 'time_created', 'product_status');
		$result = ShopManagerProduct::getSearchListItems($dataSearch, $limit, $arrFields);
		//FunctionLib::Debug($result);
		if(isset($result['data']) && !empty($result['data'])){
			foreach($result['data'] as $k => &$value){
				if( isset($value->product_image) && trim($value->product_image) != ''){
					$value->url_image = FunctionLib::getThumbImage($value->product_image,$value->product_id,FOLDER_PRODUCT,80,80);
				}
			}
		}
		//FunctionLib::Debug($result);

		$arrCategoryChildren = DataCommon::getListCategoryChildren($user_shop->shop_category);
		$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $arrCategoryChildren, $dataSearch['category_id']);

		$arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
		$optionStatus = FunctionLib::getOption(array(-1=>'Chọn trạng thái') + $arrStatus, $dataSearch['product_status']);
		return theme('shopManagerProduct',array(
									'title'=>'Cấu hình chung',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager'],
									'optionStatus' =>$optionStatus,
									'optionCategoryChildren'=>$optionCategoryChildren));
	}

	public function shopFormProduct(){
		global $base_url, $user_shop;
		if($user_shop->shop_id == 0){
			drupal_set_message('Bạn không có quyền truy cập. Vui lòng đăng nhập tài khoản!', 'error');
			drupal_goto($base_url);
		}
		$param = arg();
		$arrItem = array();
		$id = 0;
		$title = 'Thêm mới sản phẩm';
		$arrImageOther  = array();
		if(isset($param[0]) && isset($param[1]) && isset($param[2]) && $param[0] == 'sua-san-pham' && $param[1] > 0 && $param[2] != ''){
			$id = intval($param[1]);
			$fields = '';
			$cond = 'product_id='.$id.' AND user_shop_id='.$user_shop->shop_id;
			$arrItem = ShopManagerProduct::getItembyCond($fields, $cond);
			
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
			$data = array(
					'category_id'=>array('value'=>FunctionLib::getIntParam('category_id',''), 'require'=>1, 'messages'=>'Chưa chọn danh mục sản phẩm'),
					'product_name'=>array('value'=>FunctionLib::getParam('product_name',''), 'require'=>1, 'messages'=>'Tên sản phẩm không được trống!'),
					'product_content'=>array('value'=>FunctionLib::getParam('product_content',''), 'require'=>1, 'messages'=>'Chi tiết sản phẩm không được trống!'),
					'product_sort_desc'=>array('value'=>FunctionLib::getParam('product_sort_desc',''), 'require'=>1, 'messages'=>'Chi tiết sản phẩm không được trống!'),

					'product_price_sell'=>array('value'=>FunctionLib::getIntParam('product_price_sell_hide','')),
					'product_price_market'=>array('value'=>FunctionLib::getIntParam('product_price_market_hide','')),
					'product_price_input'=>array('value'=>FunctionLib::getIntParam('product_price_input_hide','')),


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
					'product_type_price'=>array('value'=>FunctionLib::getIntParam('product_type_price',TYPE_PRICE_NUMBER)),
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
					if($arrItem->product_id != $id){
						drupal_set_message('Bạn không có quyền sửa tin đăng này!', 'error');
						drupal_goto($base_url.'/quan-ly-gian-hang.html');
					}
				}
				ShopManagerProduct::save($data, $id);
				drupal_goto($base_url.'/quan-ly-gian-hang.html');
			}
		}

		$arrCategoryChildren = DataCommon::getListCategoryChildren($user_shop->shop_category);
		$optionCategoryChildren = FunctionLib::getOption(array(-1=>'Chọn danh mục sản phẩm') + $arrCategoryChildren, isset($arrItem->category_id)? $arrItem->category_id : -1);
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->product_status)? $arrItem->product_status : -1);
		$optionTypeProduct = FunctionLib::getOption($this->arrTypeProduct, isset($arrItem->product_is_hot)? $arrItem->product_is_hot : -1);
		$optionTypePrice = FunctionLib::getOption($this->arrTypePrice, isset($arrItem->product_type_price)? $arrItem->product_type_price : -1);
		return theme('shopFormProduct',
			array('optionCategoryChildren'=>$optionCategoryChildren,
				'optionStatus'=>$optionStatus,
				'optionTypeProduct'=>$optionTypeProduct,
				'optionTypePrice'=>$optionTypePrice,
				'arrItem'=>$arrItem,
				'title'=>$title,
				'arrImageOther'=>$arrImageOther,));
	}

	public function shopDeleteProduct(){
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
}