<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class OrdersShop{
	static $table_action = TABLE_ORDER;
    static $primary_key = 'order_id';
    static $foreign_key_shop_id = 'order_user_shop_id';

    //admin
	public static function getSearchListItems($dataSearch = array(),$limit = 30, $arrFields = array()){
        global $user_shop;
        $arrCond = array();
        if(!empty($arrFields)){
             $sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.'.self::$foreign_key_shop_id, $user_shop->shop_id, '=');
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
                array_push($arrCond, self::$foreign_key_shop_id.' = '.$user_shop->shop_id);
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
    public static function getItembyCond($fields = '', $cond=''){
        $result = array();
        if($cond != ''){
           $result = DB::getItembyCond(self::$table_action, $fields, '', self::$primary_key.' ASC', $cond, 1);
        }
        return !empty($result)? $result[0]: array();
    }
    public static function updateId($dataUpdate, $id = 0){
        if($id > 0 && !empty($dataUpdate)){
            return DB::updateId(self::$table_action, self::$primary_key, $dataUpdate, $id);
        }
        return false;
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
            drupal_set_message('Cập nhật thành công.');
            return true;
        }
        return false;
    }
}