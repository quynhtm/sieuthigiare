<?php
/*
* QuynhTM
*/
class Province{
	static $table_action = TABLE_PROVINCE;
	static $primary_key = 'province_id';
	static $arrFields = array('province_id', 'province_name', 'province_position', 'province_status', 'province_area');

	public static function getSearchListItems($dataSearch = array(), $limit = 30, $arrFields = array()){
		//n?u get field rong thi lay all
		if(empty($arrFields))
			$arrFields = self::$arrFields;

        if(!empty($arrFields)){
            $sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }

            /*Begin search*/
            $cond = '';
            $arrCond = array();
			if(!empty($dataSearch)){
				foreach($dataSearch as $field =>$value){
					if($field === 'province_status' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'province_name' && $value != ''){
						$db_or = db_or();
						$db_or->condition('i.'.$field, '%'.$value.'%', 'LIKE');
						$sql->condition($db_or);
						array_push($arrCond, "(".$field." LIKE '%". $value ."%')");
					}
				}
				if(!empty($arrCond)){
					$cond = implode(' AND ', $arrCond);
				}
			}
            /*End search*/

            $totalItem = DB::countItem(self::$table_action, self::$primary_key , $cond, '', self::$primary_key.' ASC');
            $result = $sql->limit($limit)->orderBy('i.'.self::$primary_key, 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();

            $pager = array('#theme' => 'pager','#quantity' => 3);
            $data['data'] = $arrItem;
            $data['pager'] = $pager;
            $data['total'] = $totalItem;
			return $data;
        }
        return array('data' => array(),'total' => 0,'pager' => array(),);
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