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

	 public static function getSearchListItems($dataSearch = array(), $limit = 30, $arrFields = array()){
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
	
}