<?php
/*
* QuynhTM add
*/
class TechLoginAs{
	static $table_action = TABLE_USER_SHOP;
	
	public static function getShopName($name = ''){
		$result = array();
		if($name != ''){
			$result = DB::getItembyCond(self::$table_action, '', '', 'shop_id ASC', "user_shop='".$name."'", 1);
		}
		return !empty($result)? $result[0]: array();
	}
}