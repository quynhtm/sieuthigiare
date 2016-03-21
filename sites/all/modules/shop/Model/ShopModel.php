<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ShopUser{
	static $table_action = TABLE_USER_SHOP;

	public static function insert($dataInsert){
		if(!empty($dataInsert)){
			return DB::insertOneItem(self::$table_action, $dataInsert);	
		}
		return false;
	}

	public static function getUserExists($name='', $mail=''){
		if($name != ''){
			return DB:: getItembyCond(self::$table_action, 'id', '', 'id ASC', "name='".$name."'", 1);
		}
		if($mail != ''){
			return DB:: getItembyCond(self::$table_action, 'id', '', 'id ASC', "mail='".$mail."'", 1);
		}
		return false;
	}
}