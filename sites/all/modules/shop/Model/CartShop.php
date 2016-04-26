<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class CartShop{
	static $table_action = TABLE_PRODUCT;
    static $primary_key = 'product_id';

    public static function getItemById($pid=0, $pnum=0, $arrFields = array()){
       if($pid>0 && $pnum>0){
       		$result = DB::getItemById(self::$table_action, self::$primary_key, $arrFields, $pid);
       		return $result;
       }
       return array();
    }
}