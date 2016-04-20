<?php 
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0 
*/
class DataCommon{
	public static $table_category = TABLE_CATEGORY;
	public static $table_province = TABLE_PROVINCE;
	public static $table_user_shop = TABLE_USER_SHOP;
	public static $table_product = TABLE_PRODUCT;
	public static $table_banner = TABLE_BANNER;
	public static $primary_key_province = 'province_id';

	public static function getListCategoryParent(){
		$categoryParent = array();
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$categoryParent = $cache->do_get(Cache::CACHE_LIST_CATEGORY_PARENT);
		}
		if($categoryParent == null || empty($categoryParent)) {
			$query = db_select(self::$table_category, 'c')
				->condition('c.category_parent_id', 0, '=')
				->condition('c.category_status', STASTUS_SHOW, '=')
				->fields('c', array('category_id', 'category_name'));
			$data = $query->execute();
			if (!empty($data)) {
				foreach ($data as $k => $cate) {
					$categoryParent[$cate->category_id] = $cate->category_name;
				}
				if (Cache::CACHE_ON) {
					$cache->do_put(Cache::CACHE_LIST_CATEGORY_PARENT, $categoryParent, Cache::CACHE_TIME_TO_LIVE_ONE_WEEK);
				}
			}
		}
		return $categoryParent;
	}

	public static function getListCategoryChildren($category_parent_id = 0){
		$categoryChildren = array();
		if($category_parent_id > 0){
			if(Cache::CACHE_ON){
				$cache = new Cache();
				$categoryChildren = $cache->do_get(Cache::CACHE_CATEGORY_CHILDREN_PARENT_ID.$category_parent_id);
			}
			if($categoryChildren == null || empty($categoryChildren)) {
				$query = db_select(self::$table_category, 'c')
					->condition('c.category_parent_id', $category_parent_id, '=')
					->condition('c.category_status', STASTUS_SHOW, '=')
					->fields('c', array('category_id', 'category_name'));
				$data = $query->execute();
				if (!empty($data)) {
					foreach ($data as $k => $cate) {
						$categoryChildren[$cate->category_id] = $cate->category_name;
					}
					if (Cache::CACHE_ON) {
						$cache->do_put(Cache::CACHE_CATEGORY_CHILDREN_PARENT_ID.$category_parent_id, $categoryChildren, Cache::CACHE_TIME_TO_LIVE_ONE_WEEK);
					}
				}
				return $categoryChildren;
			}
		}
		return $categoryChildren;
	}

	/**
	 * @param int $id_shop
	 * @return array
	 */
	public static function getShopById($id_shop = 0){
		$user_shop = array();
		if($id_shop <= 0) return $user_shop;
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$user_shop = $cache->do_get(Cache::CACHE_USER_SHOP_ID.$id_shop);
		}
		if($user_shop == null || empty($user_shop)){
			$query = db_select(self::$table_user_shop, 's')
				->condition('s.shop_id', $id_shop, '=')
				->fields('s');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $shop){
					$user_shop = $shop;
				}
				if(Cache::CACHE_ON) {
					$cache->do_put(Cache::CACHE_USER_SHOP_ID . $id_shop, $user_shop, Cache::CACHE_TIME_TO_LIVE_ONE_WEEK);
				}
			}
		}
		return $user_shop;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public static function getProductById($product_id = 0){
		$product = array();
		if($product_id <= 0) return $product;
		if(Cache::CACHE_ON) {
			$cache = new Cache();
			$product = $cache->do_get(Cache::CACHE_PRODUCT_ID . $product_id);
		}
		if( $product == null || empty($product)){
			$query = db_select(self::$table_product, 'p')
				->condition('p.product_id', $product_id, '=')
				->fields('p');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $pro){
					$product = $pro;
				}
				if(Cache::CACHE_ON) {
					$cache->do_put(Cache::CACHE_PRODUCT_ID.$product_id, $product, Cache::CACHE_TIME_TO_LIVE_ONE_WEEK);
				}
			}
		}
		return $product;
	}

	/**
	 * @param int $category_id
	 * @return array
	 */
	public static function getCategoryById($category_id = 0){
		$category = array();
		if($category_id <= 0) return $category;
		if(Cache::CACHE_ON) {
			$cache = new Cache();
			$category = $cache->do_get(Cache::CACHE_CATEGORY_ID . $category_id);
		}
		if( $category == null || empty($category)){
			$query = db_select(self::$table_category, 'c')
				->condition('c.category_id', $category_id, '=')
				->fields('c');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $cate){
					$category = $cate;
				}
				if(Cache::CACHE_ON) {
					$cache->do_put(Cache::CACHE_CATEGORY_ID.$category_id, $category, Cache::CACHE_TIME_TO_LIVE_ONE_WEEK);
				}
			}
		}
		return $category;
	}

	public static function getAllProvices(){
		$categoryChildren = array();
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$categoryChildren = $cache->do_get(Cache::CACHE_PROVINCE);
		}
		if($categoryChildren == null || empty($categoryChildren)) {
			$query = db_select(self::$table_province, 'p')
				->condition('p.province_status', STASTUS_SHOW, '=')
				->fields('p', array('province_id', 'province_name'));
			$data = $query->execute();
			if (!empty($data)) {
				foreach ($data as $k => $province) {
					$categoryChildren[$province->province_id] = $province->province_name;
				}
				if (Cache::CACHE_ON) {
					$cache->do_put(Cache::CACHE_PROVINCE, $categoryChildren, Cache::CACHE_TIME_TO_LIVE_ONE_WEEK);
				}
			}
		}
		return $categoryChildren;
	}

	/**
	 * @param int $banner_type: 1:banner home to, 2: banner home nh?,3: banner trái, 4 banner ph?i,5: banner trong list s?n ph?m
	 * @param int $banner_page: 1: trang ch?, 2: trang list,3: trang detail, 4: trang list danh m?c
	 * @param int $banner_category_id
	 * @param int $banner_shop_id
	 * @return array
	 */
	public static function getBannerAdvanced($banner_type = 0, $banner_page = 0, $banner_category_id = 0, $banner_shop_id = 0){
		$bannerAdvanced = array();
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$bannerAdvanced = $cache->do_get(Cache::CACHE_PROVINCE.'_'.$banner_type.'_'.$banner_page.'_'.$banner_category_id.'_'.$banner_shop_id);
		}
		if($bannerAdvanced == null || empty($bannerAdvanced)) {
			$arrField = array('banner_id', 'banner_name', 'banner_image','banner_link', 'banner_order', 'banner_is_target','banner_type','banner_category_id',
				'banner_page', 'banner_status','banner_is_run_time', 'banner_start_time','banner_end_time', 'banner_is_shop','banner_shop_id');
			$query = db_select(self::$table_banner, 'c')
				->condition('c.banner_status', STASTUS_SHOW, '=')
				->condition('c.banner_type', $banner_type, '=')
				->condition('c.banner_page', $banner_page, '=')
				->condition('c.banner_category_id', $banner_category_id, '=')
				->condition('c.banner_shop_id', $banner_shop_id, '=')
				->fields('c', $arrField);
			$data = $query->execute();
			if (!empty($data)) {
				foreach ($data as $k => $banner) {
					$bannerAdvanced[] = $banner;
				}
				if (Cache::CACHE_ON) {
					$cache->do_put(Cache::CACHE_PROVINCE.'_'.$banner_type.'_'.$banner_page.'_'.$banner_category_id.'_'.$banner_shop_id, $bannerAdvanced, Cache::CACHE_TIME_TO_LIVE_ONE_WEEK);
				}
			}
		}
		return $bannerAdvanced;
	}
}