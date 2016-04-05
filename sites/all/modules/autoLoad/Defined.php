<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
global $base_url, $language;
/*redirect link*/
$q = $_GET['q'];
if($q == 'user/login' || $q =='user/register' || $q =='search' || $q =='comment' || $q =='comment/reply' || $q =='admin' || $q =='filter/tips'){
	drupal_goto($base_url);
	exit();
}

/*define*/
define('SITE_VERSION',   '1.0');
define("SITE_RECORD_PER_PAGE", '30');
define('SITE_SCROLL_PAGE', '3');
define('SITE_SAME_RECORD', '5');
define("PATH_UPLOAD", DRUPAL_ROOT.'/uploads/images');
define("PATH_IMAGE_UPLOAD", 'uploads/images');

define("SITE_RECORD_PER_PAGE_NEWS", '15');
define('SITE_SAME_RECORD_NEWS', '10');
define('base_url_lang', $base_url .'/'. ((!isset($language->language) || $language->language == 'und' || $language->language == 'vi') ? 'vi/' : $language->language.'/'));
define('AJAX_DOMAIN', '/sieuthigiare.vn/');
/**
 * QuynhTM add
 * Dinh nghia cac Table cho website
 */
define('TABLE_SUPPORT_ONLINE', 'web_support_online');
define('TABLE_CONFIG_INFO', 'web_config_info');
define('TABLE_PRODUCT', 'web_product');
define('TABLE_USER_SHOP', 'web_user_shop');
define('TABLE_SUPPLIER', 'web_supplier');
define('TABLE_PROVINCE', 'web_province');
define('TABLE_CATEGORY', 'web_category');
define('TABLE_NEWS', 'web_news');

//dinh nghia thu muc chua anh
define('FOLDER_DEFAULT', 'img_other');
define('FOLDER_PRODUCT', 'product');
define('FOLDER_NEWS', 'news');

//common
define('STASTUS_HIDE', 0);
define('STASTUS_SHOW', 1);

define('TYPE_PRICE_NUMBER', 1);
define('TYPE_PRICE_CONTACT', 2);

define('PRODUCT_NOMAL', 1);
define('PRODUCT_HOT', 2);
define('PRODUCT_SELLOFF', 3);

define('IMAGE_ERROR', 113); // dung sau quet cac item up ?nh nhung ko cap nhat DB
define('IMAGE_DEFAULT', $base_url.'/sites/all/modules/autoLoad/img/default.png');






