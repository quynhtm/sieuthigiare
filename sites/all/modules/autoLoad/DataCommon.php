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
	public static $primary_key_province = 'province_id';

	const CACHE_ON = 0;

	public static function getListCategoryParent(){
		$query = db_select(self::$table_category, 'c')
			->condition('c.category_parent_id', 0, '=')
			->condition('c.category_status', 1, '=')
			->fields('c', array('category_id','category_name'));
		$data = $query->execute();
		$result = array();
		if(!empty($data)){
			foreach($data as $k=> $cate){
				$result[$cate->category_id] = $cate->category_name;
			}
		}
		return $result;
	}

	public static function getListCategoryChildren($catid=0){
		if($catid > 0){
			$query = db_select(self::$table_category, 'c')
					->condition('c.category_parent_id', $catid, '=')
					->condition('c.category_status', 1, '=')
					->fields('c', array('category_id','category_name'));
			$data = $query->execute();
			$result = array();
			if(!empty($data)){
				foreach($data as $k=> $cate){
					$result[$cate->category_id] = $cate->category_name;
				}
			}
			return $result;
		}
		return array();
	}

	/**
	 * @param int $id_shop
	 * @return array
	 */
	public static function getShopById($id_shop = 0){
		if($id_shop <= 0) return array();
		$user_shop = array();
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
				foreach($data as $k=> $cate){
					$user_shop = $cate;
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
		if($product_id <= 0) return array();
		$Cache = new Cache();
		$product = $Cache->do_get(Cache::CACHE_PRODUCT_ID.$product_id);
		if( $product == null){
			$query = db_select(self::$table_product, 'p')
				->condition('p.product_id', $product_id, '=')
				->fields('p');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $pro){
					$product[$pro->product_id] = $pro;
				}
				$Cache->do_put(Cache::CACHE_PRODUCT_ID.$product_id, $product, Cache::CACHE_TIME_TO_LIVE_ONE_WEEK);
			}
		}
		return $product;
	}

	public static function getAllProvices(){
		return DB::getItembyCond(self::$table_province, 'province_id, province_name', '', self::$primary_key_province.' ASC', 'province_status=1', '');
	}
}