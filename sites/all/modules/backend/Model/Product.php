<?php
/*
* QuynhTM
*/
class Product{
	static $table_action = TABLE_PRODUCT;
	static $primary_key = 'product_id';
	static $arrFields = array('product_id', 'product_code', 'product_name',
		'product_price_sell', 'product_price_market', 'product_price_input','product_type_price',
		'product_selloff', 'product_is_hot','product_image', 'product_image_hover','product_image_other', 'product_order',
		'product_sort_desc', 'product_content','category_id', 'category_name','quality_input', 'quality_out',
		'product_status', 'is_block','user_shop_id', 'user_shop_name','is_shop', 'shop_province',
		'time_created', 'time_update');

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
					if($field === 'product_type_price' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'category_id' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'product_is_hot' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'product_id' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'is_block' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'shop_province' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'is_shop' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'user_shop_id' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'product_status' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}
					if($field === 'product_name' && $value != ''){
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
						$sql->condition('i.time_created', array($created_start, $created_end), 'BETWEEN');
						array_push($arrCond, ' (time_created BETWEEN '.$created_start.' AND '.$created_end.')');

					}
				}

				if($update_start != '' && $update_end != ''){
					if($update_end >= $update_start){
						$sql->condition('i.time_update', array($update_start, $update_end), 'BETWEEN');
						array_push($arrCond, ' (time_update BETWEEN '.$update_start.' AND '.$update_end.')');

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
			return true;
		}
		//insert
		else{
			$query = self::insert($data_post);
			if($query){
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
			$arrItem = DB::getItemById(self::$table_action, self::$primary_key, array('product_image_other'), $id);
			if(!empty($arrItem)){
				if(trim($arrItem[0]->product_image_other) != ''){
					$product_image_other  = unserialize($arrItem[0]->product_image_other);
					if(!empty($product_image_other)){
						$path = PATH_UPLOAD.'/'.FOLDER_PRODUCT.'/'.$id;
						foreach($product_image_other as $v){
		                	if(is_file($path.'/'.$v)){
		                    	@unlink($path.'/'.$v);
		                	}
		            	}
		            	FunctionLib::delteImageCacheItem(FOLDER_PRODUCT, $id);
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