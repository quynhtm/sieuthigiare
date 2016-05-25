<?php
/*
* QuynhTM
*/
class Video{
	static $table_action = TABLE_VIDEO;
	static $primary_key = 'video_id';
	static $arrFields = array('video_id', 'video_name', 'video_link','video_status',
		'video_view', 'video_time_creater', 'video_time_update','video_sort_desc','video_content','video_img');

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
			if(!empty($dataSearch)){
				foreach($dataSearch as $field =>$value){
					if($field === 'video_id' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'video_status' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}


					if($field === 'video_name' && $value != ''){
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
				}

				if($created_start != '' && $created_end != ''){
					if($created_end >= $created_start){
						$sql->condition('i.video_time_creater', array($created_start, $created_end), 'BETWEEN');
						array_push($arrCond, ' (video_time_creater BETWEEN '.$created_start.' AND '.$created_end.')');

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
			$arrItem = DB::getItemById(self::$table_action, self::$primary_key, array('video_img'), $id);
			if(!empty($arrItem)){
				if(trim($arrItem[0]->video_img) != ''){
					$path = PATH_UPLOAD.'/'.FOLDER_VIDEO.'/'.$id;
					if(is_file($path.'/'.$arrItem[0]->video_img)){
						@unlink($path.'/'.$arrItem[0]->video_img);
					}
					FunctionLib::delteImageCacheItem(FOLDER_VIDEO, $id);
					if(is_dir($path)) {
						@rmdir($path);
					}
				}
				self::deleteId($id);
			}
		}
	}
}