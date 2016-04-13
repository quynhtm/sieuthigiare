<?php
/**
 * QuynhTM add
 */
require_once(DRUPAL_ROOT ."/phpfastcache-final/phpfastcache.php");
class Cache {
    const CACHE_ON = 0 ;// 0: không dùng qua cache, 1: dùng qua cache
    const CACHE_TIME_TO_LIVE_15 = 900; //Time cache 15 phut
    const CACHE_TIME_TO_LIVE_ONE_DAY = 86400; //Time cache 1 ngay
    const CACHE_TIME_TO_LIVE_ONE_WEEK = 604800; //Time cache 1 tuan
    const CACHE_TIME_TO_LIVE_30 = 1800; //Time cache 30 phut
    const CACHE_TIME_TO_LIVE_60 = 3600; //Time cache 60 phut

    //cacheProduct
    const CACHE_PRODUCT_ID = 'cache_product_id_';

    //cache Shop
    const CACHE_USER_SHOP_ID = 'cache_shop_id_';

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