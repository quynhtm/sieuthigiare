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
}