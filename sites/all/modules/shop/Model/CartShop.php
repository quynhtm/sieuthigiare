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

  static $table_action_order = TABLE_ORDER;


    public static function getItemById($pid=0, $pnum=0, $arrFields = array()){
       if($pid>0 && $pnum>0){
       		$result = DB::getItemById(self::$table_action, self::$primary_key, $arrFields, $pid);
       		return $result;
       }
       return array();
    }
    public static function getListItem($arrPid = array(), $arrFields = array()){
    	if(!empty($arrPid) && !empty($arrFields)){
    		$sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
			foreach($arrFields as $field){
				$sql->addField('i', $field, $field);
			}
			$sql->condition('i.'.self::$primary_key, $arrPid, 'IN');
			$sql->limit(SITE_RECORD_PER_PAGE);
			$arrItem = $sql->execute()->fetchAll();
    		return $arrItem;
    	}
    	return array();
    }

    public static function insert($dataInsert){
        if(!empty($dataInsert)){
          return DB::insertOneItem(self::$table_action_order, $dataInsert); 
        }
        return false;
    }
}