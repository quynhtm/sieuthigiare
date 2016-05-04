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
	static $primary_key_product = 'product_id';

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
			$sql->orderBy('i.product_id', 'DESC');
			$result = $sql->execute()->fetchAll();
				
			return $result;
		}
		return array();
	}
}