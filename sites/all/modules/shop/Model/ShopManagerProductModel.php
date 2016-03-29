<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ShopManagerProduct{
	static $table_action = TABLE_PRODUCT;
    static $primary_key = 'id';
    
	static $table_action_provice = TABLE_PROVINCE;
	static $primary_key_province = 'province_id';
    static $primary_key_user_shop = 'user_shop_id';

	public static function getSearchListItems($dataSearch = array(), $limit = 30, $arrFields = array()){
        global $user_shop;

        if(empty($arrFields))
            $arrFields = self::$arrFields;
        
        if(!empty($arrFields)){
             $sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.'.self::$primary_key_user_shop, $user_shop->shop_id, '=');
            /*Begin search*/
            $cond = '';
            $arrCond = array();
            if(!empty($dataSearch)){
                foreach($dataSearch as $field =>$value){
                    if($field === 'status' && $value != -1){
                        $sql->condition('i.'.$field, $value, '=');
                        array_push($arrCond, $field.' = '.$value);
                    }
                    if($field === 'product_name' && $value != ''){
                        $db_or = db_or();
                        $db_or->condition('i.'.$field, '%'.$value.'%', 'LIKE');
                        $sql->condition($db_or);
                        array_push($arrCond, "(".$field." LIKE '%". $value ."%')");
                    }
                }
                array_push($arrCond, self::$primary_key_user_shop.' = '.$user_shop->shop_id);
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
    public static function updateId($dataUpdate, $id = 0){
        if($id > 0 && !empty($dataUpdate)){
            return DB::updateId(self::$table_action, self::$primary_key, $dataUpdate, $id);
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
            return DB::deleteId(self::$table_action, self::$primary_key, $id);
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
            unset($data_post['user_shop_id']);
            unset($data_post['time_created']);
            self::updateId($data_post, $id);
            drupal_set_message('Cập nhật thành công.');
            return true;
        }
        //insert
        else{
            $query = self::insert($data_post);
            if($query){
                drupal_set_message('Thêm mới thành công.');
                return true;
            }
        }
        return false;
    }
}