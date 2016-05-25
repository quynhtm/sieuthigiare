<?php
/*
* QuynhTM
*/
class Banner{
	static $table_action = TABLE_BANNER;
	static $primary_key = 'banner_id';
	static $arrFields = array('banner_id', 'banner_name', 'banner_image',
		'banner_link', 'banner_order', 'banner_is_target','banner_type','banner_category_id',
		'banner_page', 'banner_status','banner_is_run_time', 'banner_start_time','banner_end_time', 'banner_is_shop',
		'banner_shop_id', 'banner_create_time', 'banner_update_time', 'banner_is_rel', 'banner_time_click', 'banner_total_click');

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
			$created_start = $created_end = '';
			$update_start = $update_end = '';
			if(!empty($dataSearch)){
				foreach($dataSearch as $field =>$value){
					if($field === 'banner_id' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'banner_page' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'banner_type' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'banner_is_shop' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}

					if($field === 'banner_name' && $value != ''){
						$db_or = db_or();
						$db_or->condition('i.'.$field, '%'.$value.'%', 'LIKE');
						$sql->condition($db_or);
						array_push($arrCond, "(".$field." LIKE '%". $value ."%')");
					}

					//tim t?o
					if($field == 'created_start' && $value != ''){
						$created_start = CDate::convertDate($value.' 00:00:00');
					}
					if($field == 'created_end' && $value != ''){
						$created_end = CDate::convertDate($value.' 23:59:59');
					}

					//time update
					if($field == 'update_start' && $value != ''){
						$update_start = CDate::convertDate($value.' 00:00:00');
					}
					if($field == 'update_end' && $value != ''){
						$update_end = CDate::convertDate($value.' 23:59:59');
					}
				}

				if($created_start != '' && $created_end != ''){
					if($created_end >= $created_start){
						$sql->condition('i.banner_create_time', array($created_start, $created_end), 'BETWEEN');
						array_push($arrCond, ' (banner_create_time BETWEEN '.$created_start.' AND '.$created_end.')');

					}
				}

				if($update_start != '' && $update_end != ''){
					if($update_end >= $update_start){
						$sql->condition('i.banner_update_time', array($update_start, $update_end), 'BETWEEN');
						array_push($arrCond, ' (time_update banner_update_time '.$update_start.' AND '.$update_end.')');

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

	public static function getItemById($arrFields = array(), $id = 0){
		$result = array();
		if($id > 0){
			$arrFields = !empty($arrFields)? $arrFields : self::$arrFields;
			$result = DB::getItemById(self::$table_action,self::$primary_key, $arrFields, $id);
		}
		return !empty($result)? $result[0]: array();
	}

	public static function save($data=array(), $id = 0){
		$data_post = array();
		if(!empty($data)){
			foreach($data as $key=>$val){
				$data_post[$key] = $val['value'];
			}
		}
		//update
		if($id > 0){
			self::updateId($data_post, $id);
			drupal_set_message('Upadate success.');
			return true;
		}
		//insert
		else{
			$query = self::insert($data_post);
			if($query){
				drupal_set_message('Insert success.');
				return true;
			}
		}
		return false;
	}

	public static function insert($dataInsert){
		if(!empty($dataInsert)){
			return DB::insertOneItem(self::$table_action, $dataInsert);
		}
		return false;
	}

	public static function updateId($dataUpdate, $id = 0){
		if($id > 0 && !empty($dataUpdate)){
			return DB::updateId(self::$table_action, self::$primary_key, $dataUpdate, $id);
		}
		return false;
	}

	public static function deleteId($id){
		if($id > 0){
			return DB::deleteId(self::$table_action, self::$primary_key, $id);
		}
		return false;
	}
	public static function deleteOne($id=0){
		if($id > 0){
			$arrItem = DB::getItemById(self::$table_action, self::$primary_key, array('banner_image'), $id);
			if(!empty($arrItem)){
				if(trim($arrItem[0]->banner_image) != ''){
					$path = PATH_UPLOAD.'/'.FOLDER_BANNER.'/'.$id;
					if(is_file($path.'/'.$arrItem[0]->banner_image)){
						@unlink($path.'/'.$arrItem[0]->banner_image);
					}
					FunctionLib::delteImageCacheItem(FOLDER_BANNER, $id);
					if(is_dir($path)) {
						@rmdir($path);
					}
				}
				self::deleteId($id);
			}
		}
	}
}