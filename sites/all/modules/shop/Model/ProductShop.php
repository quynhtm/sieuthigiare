<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ProductShop{
	static $table_action = TABLE_PRODUCT;
    static $primary_key = 'product_id';
    static $foreign_key_user_shop = 'user_shop_id';
    static $table_action_category = TABLE_CATEGORY;
    static $primary_key_cagegory = 'category_id';
    //admin
	public static function getSearchListItems($dataSearch = array(), $limit = 30, $arrFields = array()){
        global $base_url, $user_shop;

        if(empty($arrFields))
            $arrFields = self::$arrFields;
        
        if(!empty($arrFields)){
             $sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.'.self::$foreign_key_user_shop, $user_shop->shop_id, '=');
            /*Begin search*/
            $cond = '';
            $arrCond = array();
            $date_start = '';
            $date_end = '';

            if(!empty($dataSearch)){
                foreach($dataSearch as $field =>$value){
                    
                    if($field === 'category_id' && $value != -1){
                        $sql->condition('i.'.$field, $value, '=');
                        array_push($arrCond, $field.' = '.$value);
                    }

                    if($field === 'product_status' && $value != -1){
                        $sql->condition('i.'.$field, $value, '=');
                        array_push($arrCond, $field.' = '.$value);
                    }

                    if($field === 'product_id' && $value != 0){
                        $sql->condition('i.'.$field, $value, '=');
                        array_push($arrCond, $field.' = '.$value);
                    }

                    if($field === 'product_name' && $value != ''){
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
                        $sql->condition('i.time_created', array($date_start, $date_end), 'BETWEEN');
                        array_push($arrCond, ' (time_created BETWEEN '.$date_start.' AND '.$date_end.')');

                    }else{
                        drupal_set_message("Thời gian chọn chưa hợp lý!");
                        drupal_goto($base_url.'/quan-ly-gian-hang.html');
                    }
                }

                array_push($arrCond, self::$foreign_key_user_shop.' = '.$user_shop->shop_id);
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

    public static function insert($dataInsert){
        if(!empty($dataInsert)){
            return DB::insertOneItem(self::$table_action, $dataInsert); 
        }
        return false;
    }

    public static function getNameCategory($catid=0){
        if($catid > 0){
            $arrItem =  DB::getItemById(self::$table_action_category, self::$primary_key_cagegory, array('category_name'), $catid);
            if(!empty($arrItem)){
                return $arrItem[0]->category_name;
            }
        }
        return '';
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

    public static function deleteId($id=0){
        global $user_shop;

        if($id > 0){
            $fields = 'product_image_other';
            $cond = 'product_id='.$id.' AND user_shop_id='.$user_shop->shop_id;
            $arrItem = self::getItembyCond($fields, $cond);
         
            if(!empty($arrItem)){
                if($arrItem->product_image_other != ''){
                    $product_image_other  = unserialize($arrItem->product_image_other);
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
                DB::deleteId(self::$table_action, self::$primary_key, $id); 
            }
        }
    }
    //index
    public static function getIndexShop($shop_id = 0, $category_id = 0, $limit = 30, $arrFields = array()){
        if($shop_id > 0){
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

                $result = $sql->limit($limit)->orderBy('i.'.self::$primary_key, 'DESC')->execute();
                $arrItem = (array)$result->fetchAll();

                $pager = array('#theme' => 'pager','#quantity' => 3);
                $data['data'] = $arrItem;
                $data['pager'] = $pager;
                return $data;
            }
        }
        return array('data' => array(),'total' => 0,'pager' => array(),);
    }

     public static function getDetailShop($product_id = 0, $limit = 1, $arrFields = array()){

        if($product_id > 0){
         
            if(!empty($arrFields)){
                $sql = db_select(self::$table_action, 'i');
                foreach($arrFields as $field){
                    $sql->addField('i', $field, $field);
                }
                $sql->condition('i.product_status', STASTUS_SHOW, '=');
                $sql->condition('i.is_block', PRODUCT_NOT_BLOCK, '=');

                if(isset($product_id) && $product_id > 0){
                    $sql->condition('i.product_id', $product_id, '=');
                }

                $result = $sql->range(0, 1)->orderBy('i.'.self::$primary_key, 'DESC')->execute();
                $arrItem = (array)$result->fetchAll();

                return $arrItem;
            }
        }
        return array('arrItem' => array());
    }
}