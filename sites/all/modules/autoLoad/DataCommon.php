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

	/**
	 * @param int $id_shop
	 * @return array
	 */
	public static function getShopById($id_shop = 0){
		if($id_shop <= 0) return array();
		$result = array();
		if(!empty($result)){
			//sau vi?t get cache ? ?ây
		}else{
			$query = db_select(self::$table_user_shop, 's')
				->condition('s.shop_id', $id_shop, '=')
				->condition('s.shop_status', 1, '=')
				->fields('s');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $cate){
					$result[$cate->shop_id] = $cate;
				}
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
}