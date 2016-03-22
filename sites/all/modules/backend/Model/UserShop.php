<?php
/*
* QuynhTM add
*/
class UserShop{
	static $table_action = TABLE_USER_SHOP;

	public static function getSearch($dataSearch, $arrFields, $limit, &$totalItem, &$pager){
		$result = DB::getSearchListItemsAndPage(self::$table_action,$dataSearch, $arrFields, $limit);
		$totalItem = 0;
		$pager = $data = array();
		if(!empty($result)){
			if(isset($result['pager'])){
				$pager = $result['pager'];
			}
			if(isset($result['total'])){
				$totalItem = $result['total'];
			}
			if(isset($result['data'])){
				$data = $result['data'];
			}
		}
		return $data;
	}

	public static function getOne($arrFields, $id = 0){
		if($id > 0){
			return DB::getOneItem(self::$table_action,$arrFields, $id);
		}
		return array();
	}

	public static function updateId($dataUpdate, $id = 0){
		if($id > 0 && !empty($dataUpdate)){
			return DB::updateOneItem(self::$table_action, $dataUpdate, $id);
		}
		return false;
	}

	public static function insert($dataInsert){
		if(!empty($dataInsert)){
			return DB::insertOneItem(self::$table_action, $dataInsert);	
		}
		return false;
	}

	public static function deleteId($id){
		if($id > 0){
			return DB::deleteOneItem(self::$table_action, $id);
		}
		return false;
	}
}