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

	public static function getListProductContent($limit=0){
		$result = Site::getListProductContent($limit);
		return $result;
	}

	public static function getListProductInCategory(){
		
		return theme('pageCategoryProduct');
	}
}