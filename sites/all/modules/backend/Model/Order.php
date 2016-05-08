<?php
/*
* QuynhTM
*/
class Order{
	static $table_action = TABLE_ORDER;
	static $primary_key = 'order_id';
	static $arrFields = array('order_id',
		'order_product_id', 'order_product_name', 'order_product_price_sell', 'order_product_image', 'order_category_id', 'order_category_name','order_product_type_price','order_product_province',
		'order_customer_name', 'order_customer_phone', 'order_customer_email', 'order_customer_address','order_customer_note','order_quality_buy',
		'order_user_shop_id', 'order_user_shop_name', 'order_status', 'order_time');

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
			if(!empty($dataSearch)){
				$date_start = $date_end = '';
				foreach($dataSearch as $field =>$value){

					if($field === 'order_status' && $value != -1){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}

					if($field === 'order_product_id' && $value != 0){
						$sql->condition('i.'.$field, $value, '=');
						array_push($arrCond, $field.' = '.$value);
					}

					if($field === 'order_product_name' && $value != ''){
						$db_or = db_or();
						$db_or->condition('i.'.$field, '%'.$value.'%', 'LIKE');
						$sql->condition($db_or);
						array_push($arrCond, "(".$field." LIKE '%". $value ."%')");
					}
					if($field === 'order_customer_name' && $value != ''){
						$db_or = db_or();
						$db_or->condition('i.'.$field, '%'.$value.'%', 'LIKE');
						$sql->condition($db_or);
						array_push($arrCond, "(".$field." LIKE '%". $value ."%')");
					}
					if($field === 'order_customer_phone' && $value != ''){
						$db_or = db_or();
						$db_or->condition('i.'.$field, '%'.$value.'%', 'LIKE');
						$sql->condition($db_or);
						array_push($arrCond, "(".$field." LIKE '%". $value ."%')");
					}
					if($field === 'order_customer_email' && $value != ''){
						$db_or = db_or();
						$db_or->condition('i.'.$field, '%'.$value.'%', 'LIKE');
						$sql->condition($db_or);
						array_push($arrCond, "(".$field." LIKE '%". $value ."%')");
					}

					if($field == 'date_start' && $value != ''){
						$date_start = CDate::convertDate($value.' 00:00:00');
					}
					if($field == 'date_end' && $value != ''){
						$date_end = CDate::convertDate($value.' 23:59:59');
					}
				}

				if($date_start != '' && $date_end != ''){
					if($date_end >= $date_start){
						$sql->condition('i.order_time', array($date_start, $date_end), 'BETWEEN');
						array_push($arrCond, ' (order_time BETWEEN '.$date_start.' AND '.$date_end.')');
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

	public static function deleteId($id){
		if($id > 0){
			return DB::deleteId(self::$table_action, self::$primary_key, $id);
		}
		return false;
	}
}