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

		$bannerLeft = DataCommon::getBannerAdvanced(BANNER_TYPE_HOME_LEFT, BANNER_PAGE_LIST,0, 0);

		//lấy banner theo danh mục cha
		$bannerCategoryParent = DataCommon::getBannerAdvanced(BANNER_TYPE_HOME_BIG, BANNER_PAGE_HOME,$category_parent_id, 0);
		return theme('pageCategoryProduct', array(
											'catParent'=>$catParent,
											'bannerCategoryParent'=>$bannerCategoryParent,
											'bannerLeft'=>$bannerLeft,
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
		
		SeoMeta::SEO('Sản phẩm mới - '.WEB_SITE, '', 'Sản phẩm mới - '.WEB_SITE, 'Sản phẩm mới - '.WEB_SITE, 'Sản phẩm mới - '.WEB_SITE);

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
		$bannerList = DataCommon::getBannerAdvanced(BANNER_TYPE_HOME_LEFT, BANNER_PAGE_LIST, 0, 0);

		return theme('pageProductNew', array('result'=>$result, 'totalPage'=>$totalPage, 'currentPage'=>$currentPage, 'bannerList'=>$bannerList));
	}

	public static function getSearchProduct(){
		
		$bannerList = DataCommon::getBannerAdvanced(BANNER_TYPE_HOME_LEFT, BANNER_PAGE_LIST, 0, 0);
		
		$limit = SITE_RECORD_PER_PAGE;
		$provices_id 	= FunctionLib::getIntParam('provices_id', 0);
		$category_id 	= FunctionLib::getIntParam('category_id', 0);
		$result = Site::getListProductSearch($provices_id, $category_id, $limit);

		SeoMeta::SEO('Tìm kiếm sản phẩm - '.WEB_SITE, '', 'Tìm kiếm sản phẩm - '.WEB_SITE, 'Tìm kiếm sản phẩm - '.WEB_SITE, 'Tìm kiếm sản phẩm - '.WEB_SITE);

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
	//News
	public static function getSearchNews(){
		global $base_url;
		$param = arg();
	
		if(count($param) == 1){
			$param[0] = substr($param[0], 0, -5);
			if(in_array($param[0], array_keys(CGlobal::$aryCatergoryNews))){
				return self::newsList($param[0]);
			}else{
				drupal_goto($base_url.'/page-404');
			}
			
		}elseif(count($param) == 3){
			
			return self::newsDetail();
		}else{
			drupal_goto($base_url.'/page-404');
		}
	}
	public static function newsList($str=''){
		global $base_url;

		$param = arg();
		$catName = '';
	    $catNameAlias = '';

		$news_category = 0;
		
		switch($str){
		    case 'tin-tuc-chung':
		        $news_category = NEW_CATEGORY_TIN_TUC_CHUNG;break;
		    case 'goc-gia-dinh':
		        $news_category = NEW_CATEGORY_GOC_GIA_DINH;break;
		    case 'thi-truong':
		        $news_category = NEW_CATEGORY_THI_TRUONG;break;
		    case 'giai-tri':
		        $news_category = NEW_CATEGORY_GIAI_TRI;break;
		    case 'gioi-thieu':
		        $news_category = NEW_CATEGORY_GIOI_THIEU;break;
		    case 'tin-cua-shop':
		        $news_category = NEW_CATEGORY_SHOP;break;
		    case 'tin-cua-khach':
		        $news_category = NEW_CATEGORY_CUSTOMER;break;
		    case 'tin-quang-cao':
		        $news_category = NEW_CATEGORY_QUANG_CAO;break;
		    default:
       			drupal_goto($base_url.'/page-404');
		}

	    $catName = CGlobal::$aryCatergoryNews[$str];
	    $catNameAlias  = $str;

	    SeoMeta::SEO($catName.' - '.WEB_SITE, '', $catName.' - '.WEB_SITE, $catName.' - '.WEB_SITE, $catName.' - '.WEB_SITE);


	    $arrFields = array('news_id', 'news_title', 'news_image', 'news_desc_sort');
	    $result = Site::getNewsInCat($news_category, 12, $arrFields);

	    $productNew = Site::getListProductNew(0, NUMBER_PRODUCT_NEW);

		return theme('pageNews', array('catName'=>$catName, 'catNameAlias'=>$catNameAlias, 'result'=>$result['data'], 'pager' =>$result['pager'], 'productNew' =>$productNew));
	}
	public static function newsDetail(){
		global $base_url;

		$param = arg();
		$news_id = 0;
	    $news_category = 0;
	    $catName = '';
	    $catNameAlias = '';
	    
	    if(!in_array($param[0], array_keys(CGlobal::$aryCatergoryNews))){
	    	drupal_goto($base_url.'/page-404');
	    }else{
	    	$catName = CGlobal::$aryCatergoryNews[$param[0]];
	    	$catNameAlias  = $param[0];
	    }

	    if(isset($param[1]) && $param[1] != ''){
			$news_id = FunctionLib::cutStr($param[1], 1, 0);
		}
		$result = DataCommon::getNewsById($news_id);
		if(empty($result)){
	 		drupal_goto($base_url.'/page-404');
	    }
	    $arrFields = array('news_id', 'news_title');
	   
	    if($result->news_category == NEW_CATEGORY_GIOI_THIEU || $result->news_category == NEW_CATEGORY_SHOP || $result->news_category == NEW_CATEGORY_CUSTOMER){
	    	$arrSameNews = Site::getNewsSameCat($news_id, $result->news_category, 10, $arrFields, false);
	    }else{
	    	$arrSameNews = Site::getNewsSameCat($news_id, $result->news_category, 10, $arrFields, true);
	    }
	    $productNew = Site::getListProductNew(0, NUMBER_PRODUCT_NEW);

		return theme('pageNewsDetail', array('result'=>$result,'arrSameNews'=>$arrSameNews, 'catName'=>$catName, 'catNameAlias'=>$catNameAlias, 'productNew' =>$productNew));
	}
	public static function searchNews(){
		
		$keyword = FunctionLib::getParam('keyword', '');
		$catNameAlias = FunctionLib::getParam('catalias', '');

		SeoMeta::SEO('Tìm kiếm tin tức - '.WEB_SITE, '', 'Tìm kiếm tin tức - '.WEB_SITE, 'Tìm kiếm tin tức - '.WEB_SITE, 'Tìm kiếm tin tức - '.WEB_SITE);

		$arrFields = array('news_id', 'news_title', 'news_image', 'news_desc_sort');
		$result = Site::searchNews($keyword, 12, $arrFields);
		$productNew = Site::getListProductNew(0, NUMBER_PRODUCT_NEW);

		return theme('pageNewsSearch', array('keyword'=>$keyword, 'result'=>$result['data'], 'pager' =>$result['pager'], 'productNew' =>$productNew, 'catNameAlias'=>$catNameAlias));
	}
	//Video
	public static function getVideo(){
		$param = arg();
		$video_img = IMAGE_DEFAULT_VIDEO;
		SeoMeta::SEO('Video giải trí - '.WEB_SITE, $video_img, 'Video giải trí - '.WEB_SITE, 'Video giải trí - '.WEB_SITE, 'Video giải trí - '.WEB_SITE);

		$arrFields = array('video_id', 'video_name', 'video_img', 'video_sort_desc', 'video_link');
	    $result = Site::getVideo(SITE_RECORD_PER_PAGE, $arrFields);

		$productNew = Site::getListProductNew(0, NUMBER_PRODUCT_NEW);
		return theme('pageVideo', array('result'=>$result['data'], 'pager' =>$result['pager'], 'productNew' =>$productNew));
	}
	public static function videoDetail(){
		$param = arg();
		$video_id = 0;
	    
	    if(isset($param[1]) && $param[1] != ''){
			$video_id = FunctionLib::cutStr($param[1], 1, 0);
		}
		$result = DataCommon::getVideoById($video_id);
		if(empty($result)){
	 		drupal_goto($base_url.'/page-404');
	    }
	    $arrFields = array('video_id', 'video_name', 'video_img', 'video_sort_desc', 'video_link');
	    $arrSameVideo = Site::getVideoSame($video_id, 12, $arrFields);
		$productNew = Site::getListProductNew(0, NUMBER_PRODUCT_NEW);
		return theme('pageVideoDetail', array('result' =>$result, 'productNew' =>$productNew, 'arrSameVideo' =>$arrSameVideo));
	}

	public static function searchVideo(){

		$param = arg();
		$keyword = FunctionLib::getParam('keyword', '');

		$video_img = IMAGE_DEFAULT_VIDEO;
		SeoMeta::SEO('Tìm kiếm video giải trí - '.WEB_SITE, $video_img, 'Tìm kiếm video giải trí - '.WEB_SITE, 'Tìm kiếm video giải trí - '.WEB_SITE, 'Tìm kiếm video giải trí - '.WEB_SITE);

		$arrFields = array('video_id', 'video_name', 'video_img', 'video_sort_desc', 'video_link');
		$result = Site::searchVideo($keyword, SITE_RECORD_PER_PAGE, $arrFields);

		$productNew = Site::getListProductNew(0, NUMBER_PRODUCT_NEW);
		return theme('pageVideoSearch', array('result'=>$result['data'], 'pager' =>$result['pager'], 'productNew' =>$productNew, 'keyword'=>$keyword));
	}
}