<?php
/**
 * QuynhTM add
 */
require_once(DRUPAL_ROOT ."/phpfastcache-final/phpfastcache.php");
class Cache {
    const CACHE_ON = 1 ;// 0: khong dung qua cache, 1: dung qua cache
    const CACHE_TIME_TO_LIVE_15 = 900; //Time cache 15 phut
    const CACHE_TIME_TO_LIVE_30 = 1800; //Time cache 30 phut
    const CACHE_TIME_TO_LIVE_60 = 3600; //Time cache 60 phut
    const CACHE_TIME_TO_LIVE_ONE_DAY = 86400; //Time cache 1 ngay
    const CACHE_TIME_TO_LIVE_ONE_WEEK = 604800; //Time cache 1 tuan
    const CACHE_TIME_TO_LIVE_ONE_MONTH = 2419200; //Time cache 1 thang
    const CACHE_TIME_TO_LIVE_ONE_YEAR =  29030400; //Time cache 1 nam

    const VERSION_CACHE = 'ver_6_';//dung de thay doi cache tat ca,khong phai remove tung cache

    //cache Province
    const CACHE_PROVINCE = 'cache_province';

    //cache banner
    const CACHE_BANNER_ADVANCED = 'cache_banner_advanced_';

    //cacheNew
    const CACHE_NEWS_CATEGORY = 'cache_news_category_';
    const CACHE_NEWS_ID = 'cache_news_id_';

    //cache video
    const CACHE_VIDEO_ID = 'cache_video_id_';

    //cacheProduct
    const CACHE_PRODUCT_ID = 'cache_product_id_';
    const CACHE_PRODUCTS_HOME_WITH_CATE_PARENT_ID = 'cache_products_home_with_cate_parent_id_';//cache 15 phut ko phai xoa khi sua SP

    //cache Shop
    const CACHE_USER_SHOP_ID = 'cache_shop_id_';
    const CACHE_LIST_USER_SHOP = 'cache_list_user_shop';
    const CACHE_TREE_MENU_CATEGORY_USER_SHOP_ID = 'cache_tree_menu_category_user_shop_id_';

    //cache Category
    const CACHE_LIST_CATEGORY_PARENT = 'cache_list_category_parent';
    const CACHE_LIST_CATEGORY_PARENT_SHOW_HOME = 'cache_list_category_parent_show_home';
    const CACHE_CATEGORY_CHILDREN_PARENT_ID = 'cache_category_children_parent_id_';
    const CACHE_CATEGORY_ID = 'cache_category_id_';
    const CACHE_TREE_MENU_CATEGORY_HEADER = 'cache_tree_menu_category_header';
    const CACHE_OPTION_TREE_CATEGORY = 'cache_option_tree_category';

	public function do_put( $key, $value, $time = 0 ){
        //if $time = 0: mac dinh la 5nam (^_^)
        $cache = phpFastCache();
        return $cache->set($key,$value,$time);
    }
    public function do_get( $key ){
        $cache = phpFastCache();
        return $cache->get($key);
    }
    public function do_remove( $key ){
        $cache = phpFastCache();
        return $cache->delete($key);
    }

    //static function Cache(){}
    static function connect(){ }
    static function disconnect(){}
    static function stats(){}
	static function clear(){}
    static function encode($data){}
    static function decode($data){}
}