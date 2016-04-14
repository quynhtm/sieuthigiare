<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ContactShop{
	static $table_action = TABLE_CONTACT;
    static $primary_key = 'contact_id';
    static $foreign_key_user_shop = 'contact_user_id_send';

    //admin
	public static function getSearchListItems($limit = 30, $arrFields = array()){
        global $user_shop;

        if(!empty($arrFields)){
             $sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.'.self::$foreign_key_user_shop, $user_shop->shop_id, '=');

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

    public static function insert($dataInsert){
        if(!empty($dataInsert)){
            return DB::insertOneItem(self::$table_action, $dataInsert); 
        }
        return false;
    }

	public static function save($data=array()){
        $data_post = array();
        if(!empty($data)){
            foreach($data as $key=>$val){
                $data_post[$key] = $val['value'];
            }

            $query = self::insert($data_post);
            if($query){
                drupal_set_message('Thêm mới thành công.');
                return true;
            }
        }
        return false;
    }
}