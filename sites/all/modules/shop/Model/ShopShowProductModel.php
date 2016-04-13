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
    
	public static function getProductShop($shop_id = 0,$category_id = 0, $limit = 30, $arrFields = array()){
        if(empty($arrFields))
            $arrFields = self::$arrFields;
        
        if(!empty($arrFields)){
            $sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.product_status', STASTUS_SHOW, '=');
            $sql->condition('i.is_block', PRODUCT_NOT_BLOCK, '=');
            $sql->condition('i.'.self::$foreign_key_user_shop, $shop_id, '=');

            if(isset($category_id) && $category_id > 0){
                $sql->condition('i.category_id', $category_id, '=');
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