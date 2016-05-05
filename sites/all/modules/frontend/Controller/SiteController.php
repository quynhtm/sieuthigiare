<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class SiteController{

	public static function getListBannerLagerSite(){
		$result = DataCommon::getBannerAdvanced(BANNER_TYPE_HOME_BIG, BANNER_PAGE_HOME, 0, 0);
		return $result;
	}
	
	public static function getListBannerSmallSite(){
		$result = DataCommon::getBannerAdvanced(BANNER_TYPE_HOME_SMALL, BANNER_PAGE_HOME, 0, 0);
		return $result;
	}

	public static function getListProductContent($limit=0, $random=false){
		$result = Site::getListProductContent($limit, $random);
		return $result;
	}

	public static function getListProductInCategory(){
		global $base_url;
		$param = arg();
		$category_id = 0;
		if(isset($param[1]) && $param[1] != ''){
			$category_id = FunctionLib::cutStr($param[1], 1, 0);
		}

		if($category_id == 0){
			drupal_goto($base_url.'/page-404');
		}
		$arrCatCurrent = DataCommon::getCategoryById($category_id);
		
		if(empty($arrCatCurrent)){
			drupal_goto($base_url.'/page-404');
		}

		$category_parent_id = 0;
		$arrCategoryChildren = array();
		if(isset($arrCatCurrent->category_parent_id)){
			$category_parent_id = $arrCatCurrent->category_parent_id;
			if($category_parent_id == 0){
				$category_parent_id = $arrCatCurrent->category_id;
			}
			$catParent = DataCommon::getCategoryById($category_parent_id);
			$arrCategoryChildren = DataCommon::getListCategoryChildren($category_parent_id);
		}
		
		$limit = SITE_RECORD_PER_PAGE;
		$arrFields = array('product_id', 'category_name','product_name', 'product_price_sell', 'product_price_market', 'product_image', 'product_image_hover', 'product_type_price', 'product_selloff', 'user_shop_id', 'user_shop_name');
		$result = Site::getProductInCategory($category_id, $arrFields, $limit);
		
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

		$bannerList = DataCommon::getBannerAdvanced(BANNER_TYPE_HOME_BIG, BANNER_PAGE_HOME,$category_parent_id, 0);
		return theme('pageCategoryProduct', array(
											'catParent'=>$catParent,
											'bannerList'=>$bannerList,
											'arrCatCurrent' =>$arrCatCurrent,
											'result'=>$result['data'],
											'pager' =>$result['pager'],
											'arrCategoryChildren'=>$arrCategoryChildren
											));
	}

	public static function getListProductNew(){
		
		$recordPerPage = 40;
		$currentPage = 1;
		$totalRecord = 80;
		$totalPage = $totalRecord/40;

		if(isset($_POST) && !empty($_POST)){
			$currentPage 	= FunctionLib::getIntParam('currentPage', 1);
			if($currentPage <= $totalPage){
				$recordStart = ($recordPerPage * $currentPage) + 1;
				$result = Site::getListProductNew($recordStart, $recordPerPage);
				$view = theme('ajaxPageProductNew', array('result'=>$result));
				echo render($view);die;
			}
		}

		$result = Site::getListProductNew(0, $recordPerPage);
		$bannerList = DataCommon::getBannerAdvanced(BANNER_TYPE_HOME_SMALL, BANNER_PAGE_HOME, 0, 0);

		return theme('pageProductNew', array('result'=>$result, 'totalPage'=>$totalPage, 'currentPage'=>$currentPage, 'bannerList'=>$bannerList));
	}
	public static function getSearchProduct(){
		
		$bannerList = DataCommon::getBannerAdvanced(BANNER_TYPE_HOME_SMALL, BANNER_PAGE_HOME, 0, 0);
		
		$limit = SITE_RECORD_PER_PAGE;
		$provices_id 	= FunctionLib::getIntParam('provices_id', 0);
		$category_id 	= FunctionLib::getIntParam('category_id', 0);
		$result = Site::getListProductSearch($provices_id, $category_id, $limit);

		return theme('pageProductSearch', array('result'=>$result['data'],
												'pager' =>$result['pager'], 
												'bannerList'=>$bannerList));;
	}
	public static function countCartItem(){
		$numItem = 0;
		if(isset($_SESSION['cart']) && !empty($_SESSION['cart'])){
		  foreach ($_SESSION['cart'] as $v){
		    if($v > 0){
		    	$numItem += $v;
		    }
		  }
		}
		return $numItem;
	}
}