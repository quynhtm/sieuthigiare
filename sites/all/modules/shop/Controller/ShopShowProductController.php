<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ShopShowProductController{
	
	public function __construct(){
		$files = array(
	            'css/font-awesome.css',
	        );
	    Loader::load('Core', $files);
	}

	public function shopshowProduct(){
		
		$limit = SITE_RECORD_PER_PAGE_SHOP_NORMAL;
		
		$dataSearch['product_status'] = trim(FunctionLib::getParam('product_status','1'));
		$dataSearch['category_id'] = FunctionLib::getParam('category_id','');

		$arrFields = array('product_id', 'category_name','product_name', 'product_price_sell', 'product_price_market', 'product_image', 'product_image_hover', 'product_type_price', 'product_selloff', 'user_shop_id');
		$result = ShopShowProductModel::getSearchListItems($dataSearch, $limit, $arrFields);
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
			
			if($result['data'][0]->user_shop_id > 0){
				$user_shop = DataCommon::getShopById($result['data'][0]->user_shop_id);
				$phone = $user_shop[$result['data'][0]->user_shop_id]->shop_phone;

				//get list cagegory left shop
				$shop_category = $user_shop[$result['data'][0]->user_shop_id]->shop_category;
				$arrCategoryChildren = DataCommon::getListCategoryChildren($shop_category);
			}
		}
		
		return theme('shopShowProduct', array(
											'arrCategoryChildren'=>$arrCategoryChildren,
											'result'=>$result['data'],
											'phone'=>$phone,
											'pager' =>$result['pager'],
											));
	}
	public function shopDetailProduct(){
		$files = array(
	            'bootstrap/lib/jcarousel/jquery.jcarousel.min.js',
	            'bootstrap/lib/jcarousel/jcarousel.responsive.js',
	            'bootstrap/lib/jcarousel/jcarousel.responsive.css',
	        );
	    Loader::load('Core', $files);

		return theme('shopDetailProduct');
	}
}
