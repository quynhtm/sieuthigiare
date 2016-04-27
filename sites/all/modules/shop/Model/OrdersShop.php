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
	public static function getSearchListItems($limit = 30, $arrFields = array()){
        global $user_shop;

        if(!empty($arrFields)){
             $sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.'.self::$foreign_key_shop_id, $user_shop->shop_id, '=');

            /*End search*/
            $totalItem = DB::countItem(self::$table_action, self::$primary_key , '', '', self::$primary_key.' ASC');
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