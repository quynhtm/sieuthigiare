<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ShopShowProductModel{
	static $table_action = TABLE_PRODUCT;
    static $primary_key = 'product_id';
    static $foreign_key_user_shop = 'user_shop_id';
    
	public static function getSearchListItems($dataSearch = array(), $limit = 30, $arrFields = array()){
        $param = arg();
        $shop_id = 0;
        if(isset($param[1]) && $param[1] >0){
            $shop_id = intval($param[1]);
        }
        if(empty($arrFields))
            $arrFields = self::$arrFields;
        
        if(!empty($arrFields)){
             $sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.'.self::$foreign_key_user_shop, $shop_id, '=');
            /*Begin search*/
            if(!empty($dataSearch)){
                foreach($dataSearch as $field =>$value){
                    
                    if($field === 'category_id' && $value != ''){
                        $sql->condition('i.'.$field, $value, '=');
                    }

                    if($field === 'status' && $value != -1){
                        $sql->condition('i.'.$field, $value, '=');
                    }
                    
                }
            }
            
            /*End search*/
            $result = $sql->limit($limit)->orderBy('i.'.self::$primary_key, 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();

            $pager = array('#theme' => 'pager','#quantity' => 3);
            $data['data'] = $arrItem;
            $data['pager'] = $pager;
            return $data;
        }
        return array('data' => array(),'total' => 0,'pager' => array(),);
    }

}