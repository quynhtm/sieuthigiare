<?php
/*
* QuynhTM add
*/
class UserShop{
	static $table_action = TABLE_USER_SHOP;

	public static function getSearchListItems($dataSearch=array(), $arrFields=array(), $limit=30){
        $arrItem=array();
        
        if(!empty($arrFields)){
            $sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }

            /*Begin search*/
            
            $cond = '';
            $arrCond = array();
            foreach($dataSearch as $k=>$v){
            	if($k == 'status' && $v != ''){
            		$sql->condition('i.status', $dataSearch['status'], '=');
            		array_push($arrCond, 'status ='.$dataSearch["status"]);
            	}elseif($k == 'title' && $v != ''){
            		$db_or = db_or();
	                $db_or->condition('i.name_shop', '%'.$dataSearch['title'].'%', 'LIKE');
	                $db_or->condition('i.user_name', '%'.$dataSearch['title'].'%', 'LIKE');
	                $sql->condition($db_or);
	                array_push($arrCond, "(name_shop LIKE '%". $dataSearch['title'] ."%' OR user_name LIKE '%". $dataSearch['title'] ."%')");
            	}
            }
            if(!empty($arrCond)){
            	$cond = implode(' AND ', $arrCond);
            }
           
            /*End search*/
            $totalItem = DB::countItem(self::$table_action, 'id', $cond, '', 'id ASC');

            $result = $sql->limit($limit)->orderBy('i.id', 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();

            $pager = array('#theme' => 'pager','#quantity' => 3);

            $data['data'] = $arrItem;
            $data['pager'] = $pager;
            $data['total'] = $totalItem;
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