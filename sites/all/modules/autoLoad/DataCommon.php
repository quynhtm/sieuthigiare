<?php 
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0 
*/
class DataCommon{
	public static $table_category = TABLE_CATEGORY;
	public static $table_province = TABLE_PROVINCE;
	public static $table_user_shop = TABLE_USER_SHOP;
	public static $table_product = TABLE_PRODUCT;
	public static $table_news = TABLE_NEWS;
	public static $table_banner = TABLE_BANNER;
	public static $table_video = TABLE_VIDEO;
	public static $table_advertise_click = TABLE_ADVERTISE_CLICK;
	public static $primary_key_province = 'province_id';

	/**
	 * D�ng ?? kh�a, m?, ?n to�n b? s?n ph?m c?a shop
	 * @param int $shop_id
	 * @param int $is_block
	 */
	public static function updateInforProductByShopId($shop_id = 0, $is_block = PRODUCT_NOT_BLOCK){
		if($shop_id > 0){
			$query = db_select(self::$table_product, 'p')
				->condition('p.user_shop_id', $shop_id, '=')
				->fields('p', array('product_id'));
			$data = $query->execute();
			$inforShop = self::getShopById($shop_id);
			if (!empty($data)) {
				$cache = new Cache();
				foreach ($data as $k => $pro) {
					$dataUpdate['is_block']['value'] = $is_block;
					if(!empty($inforShop)){
						$dataUpdate['user_shop_name']['value'] = $inforShop->shop_name;
						$dataUpdate['is_shop']['value'] = $inforShop->is_shop;
						$dataUpdate['shop_province']['value'] = $inforShop->shop_province;
					}
					Product::save($dataUpdate, $pro->product_id);
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PRODUCT_ID.$pro->product_id;
					$cache->do_remove($key_cache);
				}
			}
		}
	}
	public static function getListCategoryParent(){
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_LIST_CATEGORY_PARENT;
		$categoryParent = array();
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$categoryParent = $cache->do_get($key_cache);
		}
		if($categoryParent == null || empty($categoryParent)) {
			$query = db_select(self::$table_category, 'c')
				->condition('c.category_parent_id', 0, '=')
				->condition('c.category_status', STASTUS_SHOW, '=')
				->fields('c', array('category_id', 'category_name'));
			$data = $query->execute();
			if (!empty($data)) {
				foreach ($data as $k => $cate) {
					$categoryParent[$cate->category_id] = $cate->category_name;
				}
				if (Cache::CACHE_ON) {
					$cache->do_put($key_cache, $categoryParent, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $categoryParent;
	}

	/**
	 * Danh m?c cha c� hi?n th?
	 * ngo�i trang ch? list s?n ph?m
	 * @return array
	 */
	public static function getCategoryParentShowProductHome(){
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_LIST_CATEGORY_PARENT_SHOW_HOME;
		$categoryParent = array();
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$categoryParent = $cache->do_get($key_cache);
		}
		if($categoryParent == null || empty($categoryParent)) {
			$query = db_select(self::$table_category, 'c')
				->condition('c.category_parent_id', 0, '=')
				->condition('c.category_status', STASTUS_SHOW, '=')
				->condition('c.category_content_front', STASTUS_SHOW, '=')
				->orderBy('c. category_content_front_order', 'ASC')
				->fields('c', array('category_id', 'category_name'));
			$data = $query->execute();
			if (!empty($data)) {
				foreach ($data as $k => $cate) {
					$categoryParent[$cate->category_id] = $cate->category_name;
				}
				if (Cache::CACHE_ON) {
					$cache->do_put($key_cache, $categoryParent, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $categoryParent;
	}

	public static function getListCategoryChildren($category_parent_id = 0){
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_CATEGORY_CHILDREN_PARENT_ID.$category_parent_id;
		$categoryChildren = array();
		if($category_parent_id > 0){
			if(Cache::CACHE_ON){
				$cache = new Cache();
				$categoryChildren = $cache->do_get($key_cache);
			}
			if($categoryChildren == null || empty($categoryChildren)) {
				$query = db_select(self::$table_category, 'c')
					->condition('c.category_parent_id', $category_parent_id, '=')
					->condition('c.category_status', STASTUS_SHOW, '=')
					->fields('c', array('category_id', 'category_name'));
				$data = $query->execute();
				if (!empty($data)) {
					foreach ($data as $k => $cate) {
						$categoryChildren[$cate->category_id] = $cate->category_name;
					}
					if (Cache::CACHE_ON) {
						$cache->do_put($key_cache, $categoryChildren, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
					}
				}
				return $categoryChildren;
			}
		}
		return $categoryChildren;
	}

	public static function buildCacheTreeCategoryWithShop($shop_id = 0){
		if($shop_id == 0) return array();
		$user_shop = self::getShopById($shop_id);
		$arrParenId = array();
		if(!empty($user_shop)){
			$arrParenId = ($user_shop->shop_category != '')? explode(',',$user_shop->shop_category): array();
		}
		if(empty($arrParenId)) return array();
		$treeCategory = array();
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_TREE_MENU_CATEGORY_USER_SHOP_ID.$shop_id;
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$treeCategory = $cache->do_get($key_cache);
		}
		if($treeCategory == null || empty($treeCategory)){
			$query = db_select(self::$table_category, 'c')
				->condition('c.category_status', STASTUS_SHOW, '=')
				->orderBy('c. category_order', 'ASC');
			$db_or = db_or();
			$db_or->condition('c.category_id', $arrParenId,'IN');
			$db_or->condition('c.category_parent_id', $arrParenId,'IN');
			$query->condition($db_or);
			$query->fields('c');

			$data = $query->execute();
			if(!empty($data)){
				$dataCate = array();
				foreach($data as $k=> $cate){
					$dataCate[] = $cate;
				}
				//build tree cat with parent_id
				$treeCategory = self::getTreeCategory($dataCate);

				if(Cache::CACHE_ON) {
					$cache->do_put($key_cache, $treeCategory, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $treeCategory;
	}

	/**
	 * Build Tree categroy menu danh m?c
	 * @return array
	 */
	public static function buildCacheTreeCategory(){
		$treeCategory = array();
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_TREE_MENU_CATEGORY_HEADER;
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$treeCategory = $cache->do_get($key_cache);
		}
		if($treeCategory == null || empty($treeCategory)){
			$query = db_select(self::$table_category, 'c')
				->condition('c.category_status', STASTUS_SHOW, '=')
				->orderBy('c. category_order', 'ASC')
				->fields('c');
			$data = $query->execute();
			if(!empty($data)){
				$dataCate = array();
				foreach($data as $k=> $cate){
					$dataCate[] = $cate;
				}
				//build tree cat with parent_id
				$treeCategory = self::getTreeCategory($dataCate);
				if(Cache::CACHE_ON) {
					$cache->do_put($key_cache, $treeCategory, Cache::CACHE_TIME_TO_LIVE_ONE_YEAR);
				}
			}
		}
		return $treeCategory;
	}
	public static function getTreeCategory($data){
		$arrCategory = array();
		if(!empty($data)){
			foreach ($data as $k=>$value){
				if($value->category_parent_id > 0){
					$arrCategory[$value->category_parent_id]['arrSubCategory'][] = array(
						'category_id'=>$value->category_id,
						'category_order'=>$value->category_order,//hien th? th? t? s?p x?p
						'category_name'=>$value->category_name);
				}else{
					//thong tin parent
					$arrCategory[$value->category_id]['category_parent_name'] = $value->category_name;
					$arrCategory[$value->category_id]['category_id'] = $value->category_id;
					$arrCategory[$value->category_id]['category_status'] = $value->category_status;
					$arrCategory[$value->category_id]['category_image_background'] = $value->category_image_background;
					$arrCategory[$value->category_id]['category_order'] = $value->category_order;//hien th? th? t? s?p x?p
				}
			}
			if(!empty($arrCategory)){
				foreach($arrCategory as $key => $val){
					if(!isset($val['category_id'])){
						unset($arrCategory[$key]);
					}
				}
			}
			self::sortArrayASC($arrCategory,"category_order");
		}
		return $arrCategory;
	}
	public static function sortArrayASC (&$array, $key) {
		$sorter=array();
		$ret=array();
		reset($array);
		foreach ($array as $ii => $va) {
			$sorter[$ii]=$va[$key];
		}
		asort($sorter);
		foreach ($sorter as $ii => $va) {
			$ret[$ii]=$array[$ii];
		}
		$array=$ret;
	}

	/**
	 * @param int $id_shop
	 * @return array
	 */
	public static function getShopById($id_shop = 0){
		$user_shop = array();
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_USER_SHOP_ID;
		if($id_shop <= 0) return $user_shop;
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$user_shop = $cache->do_get($key_cache.$id_shop);
		}
		if($user_shop == null || empty($user_shop)){
			$query = db_select(self::$table_user_shop, 's')
				->condition('s.shop_id', $id_shop, '=')
				->fields('s');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $shop){
					$user_shop = $shop;
				}
				if(Cache::CACHE_ON) {
					$cache->do_put($key_cache. $id_shop, $user_shop, Cache::CACHE_TIME_TO_LIVE_ONE_WEEK);
				}
			}
		}
		return $user_shop;
	}

	/**
	 * get danh sach shop dang ho?t ??ng
	 * @return array
	 */
	public static function getListUserShop(){
		$user_shop = array();
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_LIST_USER_SHOP;
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$user_shop = $cache->do_get($key_cache);
		}
		if($user_shop == null || empty($user_shop)){
			$query = db_select(self::$table_user_shop, 's')
				->condition('s.shop_status', STASTUS_SHOW, '=')
				->fields('s', array('shop_id', 'shop_name'));
			$data = $query->execute();
			if (!empty($data)) {
				foreach ($data as $k => $shop) {
					$user_shop[$shop->shop_id] = $shop->shop_name;
				}
				if (Cache::CACHE_ON) {
					$cache->do_put($key_cache, $user_shop, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $user_shop;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public static function getProductById($product_id = 0){
		$product = array();
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PRODUCT_ID.$product_id;
		if($product_id <= 0) return $product;
		if(Cache::CACHE_ON) {
			$cache = new Cache();
			$product = $cache->do_get($key_cache);
		}
		if( $product == null || empty($product)){
			$query = db_select(self::$table_product, 'p')
				->condition('p.product_id', $product_id, '=')
				->fields('p');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $pro){
					$product = $pro;
				}
				if(Cache::CACHE_ON) {
					$cache->do_put($key_cache, $product, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $product;
	}
	/**
	 * @param int $news_id
	 * @return array
	 */
	
	public static function getNewsInCategory($news_category = 0){
		$news = array();
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_NEWS_CATEGORY.$news_category;
		if($news_category <= 0) return $news;
		if(Cache::CACHE_ON) {
			$cache = new Cache();
			$news = $cache->do_get($key_cache);
		}
		if( $news == null || empty($news)){
			$query = db_select(self::$table_news, 'n')
				->condition('n.news_category', $news_category, '=')
				->fields('n');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $new){
					$news[$new->news_id] = $new;
				}
				if(Cache::CACHE_ON) {
					$cache->do_put($key_cache, $news, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $news;
	}

	public static function getNewsById($news_id = 0){
		$news = array();
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_NEWS_ID.$news_id;
		if($news_id <= 0) return $news;
		if(Cache::CACHE_ON) {
			$cache = new Cache();
			$news = $cache->do_get($key_cache);
		}
		if( $news == null || empty($news)){
			$query = db_select(self::$table_news, 'n')
				->condition('n.news_id', $news_id, '=')
				->fields('n');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $new){
					$news = $new;
				}
				if(Cache::CACHE_ON) {
					$cache->do_put($key_cache, $news, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $news;
	}

	/**
	 * @param int $category_id
	 * @return array
	 */
	public static function getCategoryById($category_id = 0){
		$category = array();
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_CATEGORY_ID;
		if($category_id <= 0) return $category;
		if(Cache::CACHE_ON) {
			$cache = new Cache();
			$category = $cache->do_get($key_cache. $category_id);
		}
		if( $category == null || empty($category)){
			$query = db_select(self::$table_category, 'c')
				->condition('c.category_id', $category_id, '=')
				->fields('c');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $cate){
					$category = $cate;
				}
				if(Cache::CACHE_ON) {
					$cache->do_put($key_cache.$category_id, $category, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $category;
	}

	public static function getAllProvices(){
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PROVINCE;
		$province = array();
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$province = $cache->do_get($key_cache);
		}
		if($province == null || empty($province)) {
			$query = db_select(self::$table_province, 'p')
				->condition('p.province_status', STASTUS_SHOW, '=')
				->orderBy('p.province_position', 'ASC')
				->fields('p', array('province_id', 'province_name'));
			$data = $query->execute();
			if (!empty($data)) {
				foreach ($data as $k => $provi) {
					$province[$provi->province_id] = $provi->province_name;
				}
				if (Cache::CACHE_ON) {
					$cache->do_put($key_cache, $province, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $province;
	}

	/**
	 * @param int $banner_type: 1:banner home to, 2: banner home nh?,3: banner tr�i, 4 banner ph?i,5: banner trong list s?n ph?m
	 * @param int $banner_page: 1: trang ch?, 2: trang list,3: trang detail, 4: trang list danh m?c
	 * @param int $banner_category_id
	 * @param int $banner_shop_id
	 * @return array
	 */
	public static function getBannerAdvanced($banner_type = 0, $banner_page = 0, $banner_category_id = 0, $banner_shop_id = 0){
		$bannerAdvanced = array();
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$bannerAdvanced = $cache->do_get(Cache::VERSION_CACHE.Cache::CACHE_BANNER_ADVANCED.'_'.$banner_type.'_'.$banner_page.'_'.$banner_category_id.'_'.$banner_shop_id);
		}
		if($bannerAdvanced == null || empty($bannerAdvanced)) {
			$arrField = array('banner_id', 'banner_name', 'banner_image','banner_link', 'banner_order', 'banner_is_target','banner_type','banner_category_id',
				'banner_page', 'banner_status','banner_is_run_time', 'banner_start_time','banner_end_time', 'banner_is_shop','banner_shop_id', 'banner_is_rel');
			$query = db_select(self::$table_banner, 'c')
				->condition('c.banner_status', STASTUS_SHOW, '=')
				->condition('c.banner_type', $banner_type, '=')
				->condition('c.banner_page', $banner_page, '=')
				->condition('c.banner_category_id', $banner_category_id, '=')
				->condition('c.banner_shop_id', $banner_shop_id, '=')
				->orderBy('banner_order', 'ASC')//ORDER BY created
				->fields('c', $arrField);
			$data = $query->execute();
			if (!empty($data)) {
				foreach ($data as $k => $banner) {
					$bannerAdvanced[] = $banner;
				}
				if (Cache::CACHE_ON) {
					$cache->do_put(Cache::VERSION_CACHE.Cache::CACHE_BANNER_ADVANCED.'_'.$banner_type.'_'.$banner_page.'_'.$banner_category_id.'_'.$banner_shop_id, $bannerAdvanced, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $bannerAdvanced;
	}

	/**
	 * build c�y danh m?c
	 * Tao Option chon danh m?c hien th? theo cay
	 * @param $data
	 * @return array
	 */
	public static function getOptionTreeCategory(){
		$optionTreeCategory = array();
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_OPTION_TREE_CATEGORY;
		if(Cache::CACHE_ON){
			$cache = new Cache();
			$optionTreeCategory = $cache->do_get($key_cache);
		}
		if($optionTreeCategory == null || empty($optionTreeCategory)) {
			$query = db_select(self::$table_category, 'c')
				->condition('c.category_status', STASTUS_SHOW, '=')
				->orderBy('c. category_order', 'ASC')
				->fields('c');
			$data = $query->execute();
			$dataCate = array();
			if (!empty($data)) {
				foreach ($data as $k => $banner) {
					$dataCate[] = $banner;
				}
			}

			$max = 0;
			$arrCategory = array();
			if (!empty($dataCate)) {
				foreach ($dataCate as $k => $value) {
					$max = ($max < $value->category_parent_id) ? $value->category_parent_id : $max;
					$arrCategory[$value->category_id] = array(
						'category_id' => $value->category_id,
						'category_parent_id' => $value->category_parent_id,
						'category_name' => $value->category_name);
				}
			}
			if ($max > 0) {
				$optionTreeCategory = self::showCategory($max, $arrCategory);
			}

			if (Cache::CACHE_ON) {
				$cache->do_put($key_cache, $optionTreeCategory, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
			}
		}
		return $optionTreeCategory;
	}
	public static function showCategory($max, $aryDataInput) {
		$aryData = array();
		if(is_array($aryDataInput) && count($aryDataInput) > 0) {
			foreach ($aryDataInput as $k => $val) {
				if((int)$val['category_parent_id'] == 0) {
					$val['padding_left'] = '';
					$val['category_parent_name'] = '';
					$aryData[] = $val;
					self::showSubCategory($val['category_id'],$max, $aryDataInput, $aryData);
				}
			}
		}
		return $aryData;
	}
	public static function showSubCategory($cat_id, $max, $aryDataInput, &$aryData) {
		if($cat_id <= $max) {
			foreach ($aryDataInput as $chk => $chval) {
				if($chval['category_parent_id'] == $cat_id) {
					$chval['padding_left'] = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
					$aryData[] = $chval;
					self::showSubCategory($chval['category_id'], $max, $aryDataInput, $aryData);
				}
			}
		}
	}

	/**
	 * Lay SP theo danh muc cha o trang HOME
	 * @param int $category_parent_id
	 * @return array
	 */
	public static function getProductsHomeWithCateParentId($category_parent_id = 0){
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PRODUCTS_HOME_WITH_CATE_PARENT_ID.$category_parent_id;
		$product = array();
		if($category_parent_id > 0){
			if(Cache::CACHE_ON){
				$cache = new Cache();
				$product = $cache->do_get($key_cache);
			}
			if($product == null || empty($product)) {
				//lay danh sach id danh muc con
				$arrParentShowProduct = array(97,43);//cho danh muc nay hien thi 20 san pham home
				$arrCategoryChildren = DataCommon::getListCategoryChildren($category_parent_id);
				$arrCateId = array();
				if(!empty($arrCategoryChildren)){
					$arrCateId = array_keys($arrCategoryChildren);
					$arrFields = array('product_id', 'category_name','product_name', 'product_price_sell', 'product_price_market', 'product_image',
						'product_image_hover', 'product_type_price', 'product_selloff', 'user_shop_id', 'user_shop_name');
					$query = db_select(self::$table_product, 'p')
						->condition('p.product_status', STASTUS_SHOW, '=')
						->condition('p.is_block', PRODUCT_NOT_BLOCK, '=')
						->condition('p.category_id', $arrCateId, 'IN')
						->orderBy('p.time_update', 'DESC')
						->range(0,in_array($category_parent_id,$arrParentShowProduct)? 20: NUMBER_PRODUCT_HOME)
						->fields('p', $arrFields);
					$data = $query->execute();
					if (!empty($data)) {
						foreach ($data as $k => $pro) {
							$product[] = $pro;
						}
						if (Cache::CACHE_ON) {
							$cache->do_put($key_cache, $product, Cache::CACHE_TIME_TO_LIVE_15);
						}
					}
					return $product;
				}
			}
		}
		return $product;
	}

	/**
	 * c?p nh?t l??t click banner, tin t?c qu?ng c�o
	 * @param int $id_object
	 * @param string $ip_client
	 * @param int $type_adver: 1: banner, 2: tin tuc quang cao,3 video giai tri
	 * @throws Exception
	 */
	public static function updateNumberClickAdvertise($id_object = 0, $ip_client = '',$type_adver = 1){
		if($id_object > 0 && trim($ip_client) != ''){
			//check xem co ton tai ip cua quang cao nay ko
			$string_object = 'click_banner_id';
			switch($type_adver){
				case 1: $string_object = 'click_banner_id';
					break;
				case 2: $string_object = 'click_new_id';
					break;
				case 3: $string_object = 'click_video_id';
					break;
			}
			$query = db_select(self::$table_advertise_click, 'c')
				->condition('c.'.$string_object, $id_object, '=')
				->condition('c.click_type_object', $type_adver, '=')
				->condition('c.click_host_ip', trim($ip_client), '=')
				->orderBy('c.click_time', 'DESC')
				->fields('c', array('click_id'));
			$data = $query->execute();
			if (!empty($data)) {
				$advertise_click = array();
				foreach ($data as $k => $pro) {
					$advertise_click[] = $pro;
				}
				if(empty($advertise_click)){
					//them vao bang click
					$arrClick = array(
						$string_object => $id_object,
						'click_type_object' => $type_adver,
						'click_host_ip' => $ip_client,
						'click_total' => 1,
						'click_time' => time());
					$id_click = db_insert(self::$table_advertise_click)->fields($arrClick)->execute();
					if($id_click > 0){
						// lay tong luot click
						$query = db_select(self::$table_advertise_click, 'c')
							->condition('c.'.$string_object, $id_object, '=')
							->condition('c.click_type_object', $type_adver, '=')
							->orderBy('c.click_time', 'DESC')
							->fields('c', array('click_id','click_time'));
						$query->addExpression('COUNT(c.click_id)', 'total_click');
						$totak_click = $query->execute();

						$result_click = array();
						foreach ($totak_click as $k => $pro) {
							$result_click[] = $pro;
						}
						//update so luong vao bang doi tuong
						if(!empty($result_click)){
							if($type_adver == 1) {
								$num_updated = db_update(self::$table_banner)
									->fields(array('banner_total_click' => $result_click[0]->total_click,
													'banner_time_click' => $result_click[0]->click_time,))
									->condition(self::$table_banner . '.banner_id', $id_object, '=')
									->execute();
							}
							if($type_adver == 3) {
								$num_updated = db_update(self::$table_video)
									->fields(array('video_view' => $result_click[0]->total_click,
										'video_time_update' => $result_click[0]->click_time))
									->condition(self::$table_video . '.video_id', $id_object, '=')
									->execute();
							}
						}
					}
				}
			}
		}
	}

	public static function getProductDetailHot($category_id = 0){
		$product = array();
		if($category_id > 0){
			//lấy danh muc cha
			$infor_category = DataCommon::getCategoryById($category_id);
			if(!empty($infor_category)){
				$category_parent_id = isset($infor_category->category_parent_id)?$infor_category->category_parent_id: 0;
				//lay danh sach id danh muc con
				$arrCategoryChildren = DataCommon::getListCategoryChildren($category_parent_id);
				if(!empty($arrCategoryChildren)){
					$i = rand(1,300);
					$arrCateId = array_keys($arrCategoryChildren);
					$arrFields = array('product_id', 'category_name','product_name', 'product_price_sell', 'product_price_market', 'product_image',
						'product_image_hover', 'product_type_price', 'product_selloff', 'user_shop_id', 'user_shop_name');
					$query = db_select(self::$table_product, 'p')
						->condition('p.product_status', STASTUS_SHOW, '=')
						->condition('p.is_block', PRODUCT_NOT_BLOCK, '=')
						->condition('p.category_id', $arrCateId, 'NOT IN')
						->orderBy('p.time_update', 'DESC')
						->range($i,8)
						->fields('p', $arrFields);
					$data = $query->execute();
					if (!empty($data)) {
						foreach ($data as $k => $pro) {
							$product[] = $pro;
						}
					}
					return $product;
				}
			}
		}
		return $product;
	}

	public static function getVideoById($video_id = 0){
		$video = array();
		$key_cache = Cache::VERSION_CACHE.Cache::CACHE_VIDEO_ID.$video_id;
		if($video_id <= 0) return $video;
		if(Cache::CACHE_ON) {
			$cache = new Cache();
			$video = $cache->do_get($key_cache);
		}
		if( $video == null || empty($video)){
			$query = db_select(self::$table_video, 'n')
				->condition('n.video_id', $video_id, '=')
				->fields('n');
			$data = $query->execute();
			if(!empty($data)){
				foreach($data as $k=> $new){
					$video = $new;
				}
				if(Cache::CACHE_ON) {
					$cache->do_put($key_cache, $video, Cache::CACHE_TIME_TO_LIVE_ONE_MONTH);
				}
			}
		}
		return $video;
	}
}
