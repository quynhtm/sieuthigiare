<?php
/*
* QuynhTM
*/
class News{
	static $table_action = TABLE_NEWS;
	static $primary_key = 'news_id';
	static $arrFields = array('news_id', 'news_title', 'news_desc_sort', 'news_content', 'news_image', 'news_image_other',
		'news_type', 'news_create', 'news_category', 'news_status');

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
					if($field === 'news_type' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'news_category' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'news_status' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'news_title' && $value != ''){
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
			$arrItem = DB::getItemById(self::$table_action, self::$primary_key, array('news_image_other'), $id);
			if(!empty($arrItem)){
				if($arrItem[0]->news_image_other != ''){
					$news_image_other  = unserialize($arrItem[0]->news_image_other);
					if(!empty($news_image_other)){
						$path = PATH_UPLOAD.'/'.FOLDER_NEWS.'/'.$id;
						foreach($news_image_other as $v){
		                	if(is_file($path.'/'.$v)){
		                    	@unlink($path.'/'.$v);
		                	}
		            	}
		            	FunctionLib::delteImageCacheItem(FOLDER_NEWS, $id);
			            if(is_dir($path)) {
		                    @rmdir($path);
		                }
					}
				}
				self::deleteId($id);
			}
		}
	}
}