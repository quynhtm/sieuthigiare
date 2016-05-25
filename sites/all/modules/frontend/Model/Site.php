<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class Site{
	static $table_action_category = TABLE_CATEGORY;
	static $table_action_product = TABLE_PRODUCT;
	static $table_action_news = TABLE_NEWS;
	static $table_action_video = TABLE_VIDEO;
	static $primary_key_product = 'product_id';
	static $primary_key_news = 'news_id';
	static $primary_key_video = 'video_id';


	public static function makeListCatid($limit=0){
		global $base_url;

		$arrCatId = array();
		if($limit > 0){
			$arrListCat = DB::getItembyCond(self::$table_action_category, 'category_name, category_id', '', 'category_id ASC', 'category_status=1 AND category_content_front=1', $limit);
			if(!empty($arrListCat)){
				foreach ($arrListCat as $v){
				 	$arrListSubCat = DB::getItembyCond(self::$table_action_category, 'category_id', '', 'category_id ASC', 'category_status=1 AND category_parent_id='.$v->category_id, '');
					if(!empty($arrListSubCat)){
						foreach($arrListSubCat as $subid){
							$arrCatId[$v->category_name][] = $subid->category_id;
						}
					}
				}
			}
		}else{
			drupal_goto($base_url);
		}
		return $arrCatId;
	}

	public static function getListProductContentHome($cat_limit=0, $product_limit=0){
		if($cat_limit > 0 && $product_limit > 0){
			$listCat = Site::makeListCatid($cat_limit);
			if(!empty($listCat)){
				foreach($listCat as $k => $v){
					
					$sql = db_select(self::$table_action_product, 'i');
					$sql->addField('i', 'product_id', 'product_id');
					$sql->addField('i', 'product_name', 'product_name');
					$sql->addField('i', 'product_price_sell', 'product_price_sell');
					$sql->addField('i', 'product_price_market', 'product_price_market');
					$sql->addField('i', 'product_type_price', 'product_type_price');
					$sql->addField('i', 'product_selloff', 'product_selloff');
					$sql->addField('i', 'product_image', 'product_image');
					$sql->addField('i', 'product_image_hover', 'product_image_hover');
					$sql->addField('i', 'user_shop_id', 'user_shop_id');
					$sql->addField('i', 'user_shop_name', 'user_shop_name');

					$sql->condition('i.product_status', STASTUS_SHOW,'=');
					$sql->condition('i.is_block', PRODUCT_NOT_BLOCK,'=');
					$sql->condition('i.category_id', $v, 'IN');
					$sql->orderBy('i.product_id', 'DESC');
					$sql->range(0, $product_limit);
					
					$result[$k] = $sql->execute()->fetchAll();
				}
				return $result;
			}
		}
		return array();
	}

	public static function getListProductContent($product_limit=0, $random=true){

		if($product_limit > 0){
			$sql = db_select(self::$table_action_product, 'i');
			$sql->addField('i', 'product_id', 'product_id');
			$sql->addField('i', 'product_name', 'product_name');
			$sql->addField('i', 'product_price_sell', 'product_price_sell');
			$sql->addField('i', 'product_price_market', 'product_price_market');
			$sql->addField('i', 'product_type_price', 'product_type_price');
			$sql->addField('i', 'product_selloff', 'product_selloff');
			$sql->addField('i', 'product_image', 'product_image');
			$sql->addField('i', 'product_image_hover', 'product_image_hover');
			$sql->addField('i', 'user_shop_id', 'user_shop_id');
			$sql->addField('i', 'user_shop_name', 'user_shop_name');

			$sql->condition('i.product_status', STASTUS_SHOW,'=');
			$sql->condition('i.is_block', PRODUCT_NOT_BLOCK,'=');
			$sql->range(0, $product_limit);

			if($random == true){
				$sql->orderRandom();
			}else{
				$sql->orderBy('i.product_id', 'DESC');
			}
			
			$result = $sql->execute()->fetchAll();
				
			return $result;
		}
		return array();
	}

	public static function getProductInCategory($category_id=0, $arrFields, $limit=0){
		if($category_id > 0){
            if(!empty($arrFields)){
                $arrCatid[0] = $category_id;
                $listCat = DataCommon::getListCategoryChildren($category_id);
                if(!empty($listCat)){
                	foreach($listCat as $key=>$val){
                		array_push($arrCatid, $key);
                	}
                }
               
                $sql = db_select(self::$table_action_product, 'i')->extend('PagerDefault');
                foreach($arrFields as $field){
                    $sql->addField('i', $field, $field);
                }
                $sql->condition('i.product_status', STASTUS_SHOW, '=');
                $sql->condition('i.is_block', PRODUCT_NOT_BLOCK, '=');
                
                if(!empty($arrCatid)){
                    $sql->condition('i.category_id', $arrCatid, 'IN');
                }

                $result = $sql->limit($limit)->orderBy('i.'.self::$primary_key_product, 'DESC')->execute();
                $arrItem = (array)$result->fetchAll();

                $pager = array('#theme' => 'pager','#quantity' => 3);
                $data['data'] = $arrItem;
                $data['pager'] = $pager;
                return $data;
            }
        }
        return array('data' => array(),'total' => 0,'pager' => array(),);
	}

	public static function getListProductNew($recordStart=0, $recordPerPage=0){

		if($recordPerPage > 0){
			$sql = db_select(self::$table_action_product, 'i');
			$sql->addField('i', 'product_id', 'product_id');
			$sql->addField('i', 'product_name', 'product_name');
			$sql->addField('i', 'product_price_sell', 'product_price_sell');
			$sql->addField('i', 'product_price_market', 'product_price_market');
			$sql->addField('i', 'product_type_price', 'product_type_price');
			$sql->addField('i', 'product_selloff', 'product_selloff');
			$sql->addField('i', 'product_image', 'product_image');
			$sql->addField('i', 'product_image_hover', 'product_image_hover');
			$sql->addField('i', 'user_shop_id', 'user_shop_id');
			$sql->addField('i', 'user_shop_name', 'user_shop_name');

			$sql->condition('i.product_status', STASTUS_SHOW,'=');
			$sql->condition('i.is_block', PRODUCT_NOT_BLOCK,'=');
			
			$sql->range($recordStart,$recordPerPage);
			$sql->orderBy('i.time_update', 'DESC');
			$result = $sql->execute()->fetchAll();
				
			return $result;
		}
		return array();
	}

	public static function getListProductSearch($provices_id=0, $category_id=0, $limit=0){
		if($limit>0){
			$sql = db_select(self::$table_action_product, 'i')->extend('PagerDefault');
			$sql->addField('i', 'product_id', 'product_id');
			$sql->addField('i', 'product_name', 'product_name');
			$sql->addField('i', 'product_price_sell', 'product_price_sell');
			$sql->addField('i', 'product_price_market', 'product_price_market');
			$sql->addField('i', 'product_type_price', 'product_type_price');
			$sql->addField('i', 'product_selloff', 'product_selloff');
			$sql->addField('i', 'product_image', 'product_image');
			$sql->addField('i', 'product_image_hover', 'product_image_hover');
			$sql->addField('i', 'user_shop_id', 'user_shop_id');
			$sql->addField('i', 'user_shop_name', 'user_shop_name');

			$sql->condition('i.product_status', STASTUS_SHOW,'=');
			$sql->condition('i.is_block', PRODUCT_NOT_BLOCK,'=');
			
			if($provices_id>0){
				$sql->condition('i.shop_province', $provices_id,'=');
			}

			if($category_id>0){
				$listCategoryChildren  = DataCommon::getListCategoryChildren($category_id);
				$listCategoryChildren = array_keys($listCategoryChildren);
				$sql->condition('i.category_id', $listCategoryChildren,'IN');
			}

			$result = $sql->limit($limit)->orderBy('i.'.self::$primary_key_product, 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();

            $pager = array('#theme' => 'pager','#quantity' => 3);
            $data['data'] = $arrItem;
            $data['pager'] = $pager;
            return $data;
		}
		return array();
	}

	public static function getNewsInCat($news_category = 0, $limit = 30, $arrFields = array()){
        global $base_url;
        
        if(!empty($arrFields) && $news_category > 0){
       
            $sql = db_select(self::$table_action_news, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.news_status', STASTUS_SHOW, '=');
            $sql->condition('i.news_category', $news_category, '=');
            
            $result = $sql->limit($limit)->orderBy('i.news_create', 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();

            $pager = array('#theme' => 'pager','#quantity' => 3);
            $data['data'] = $arrItem;
            $data['pager'] = $pager;
            
			return $data;

        }else{
            drupal_goto($base_url.'/page-404');
        }
        
        return array();
    }

	public static function getNewsSameCat($news_id=0, $news_category = 0, $limit = 30, $arrFields = array(), $specal=true){
        global $base_url;
        if($specal == true){
	        if(!empty($arrFields) && $news_id > 0 && $news_category > 0){
	       
	            $sql = db_select(self::$table_action_news, 'i');
	            foreach($arrFields as $field){
	                $sql->addField('i', $field, $field);
	            }
	            $sql->condition('i.news_status', STASTUS_SHOW, '=');
	            $sql->condition('i.news_category', $news_category, '=');
	            $sql->condition('i.news_id', $news_id, '<>');
	            $sql->condition('i.news_id', $news_id, '<');//l?y tin c? h?n tin ?ang xem

	            $result = $sql->range(0, $limit)->orderBy('i.'.self::$primary_key_news, 'DESC')->execute();
	            $arrItem = (array)$result->fetchAll();

	            return $arrItem;
	        }else{
	            drupal_goto($base_url.'/page-404');
	        }
        }
        return array();
    }

    public static function searchNews($keyword = "", $limit = 30, $arrFields = array()){
        global $base_url;
        
        if(!empty($arrFields)){
       
            $sql = db_select(self::$table_action_news, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.news_status', STASTUS_SHOW, '=');
            
            $db_or = db_or();
			$db_or->condition('i.news_title', '%'.$keyword.'%', 'LIKE');
			$sql->condition($db_or);

            $result = $sql->limit($limit)->orderBy('i.news_create', 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();

            $pager = array('#theme' => 'pager','#quantity' => 3);
            $data['data'] = $arrItem;
            $data['pager'] = $pager;
            
			return $data;

        }else{
            drupal_goto($base_url.'/page-404');
        }
 
        return array();
    }

    public static function getVideo($limit = 30, $arrFields = array()){
        global $base_url;
        
        if(!empty($arrFields)){
       
            $sql = db_select(self::$table_action_video, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.video_status', STASTUS_SHOW, '=');
            
            $result = $sql->limit($limit)->orderBy('i.video_time_update', 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();

            $pager = array('#theme' => 'pager','#quantity' => 3);
            $data['data'] = $arrItem;
            $data['pager'] = $pager;
            
			return $data;

        }else{
            drupal_goto($base_url.'/page-404');
        }
        
        return array();
    }
    public static function getVideoSame($video_id=0, $limit = 30, $arrFields = array()){
        global $base_url;
        
        if(!empty($arrFields) && $video_id > 0){
       
            $sql = db_select(self::$table_action_video, 'i');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.video_status', STASTUS_SHOW, '=');
            $sql->condition('i.video_id', $video_id, '<>');
            $sql->condition('i.video_id', $video_id, '<');

            $result = $sql->range(0, $limit)->orderBy('i.'.self::$primary_key_video, 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();

            return $arrItem;
        }
  
        return array();
    }

    public static function searchVideo($keyword = "", $limit = 30, $arrFields = array()){
        global $base_url;
        
        if(!empty($arrFields)){
       
            $sql = db_select(self::$table_action_video, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.video_status', STASTUS_SHOW, '=');
            
            $db_or = db_or();
			$db_or->condition('i.video_name', '%'.$keyword.'%', 'LIKE');
			$sql->condition($db_or);

            $result = $sql->limit($limit)->orderBy('i.video_time_update', 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();

            $pager = array('#theme' => 'pager','#quantity' => 3);
            $data['data'] = $arrItem;
            $data['pager'] = $pager;
            
			return $data;

        }else{
            drupal_goto($base_url.'/page-404');
        }
 
        return array();
    }
}