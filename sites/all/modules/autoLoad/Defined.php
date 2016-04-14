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
define("SITE_RECORD_PER_PAGE_SHOP_NORMAL", '12');
define("SITE_RECORD_PER_PAGE_SHOP_VIP", '20');

define("PATH_UPLOAD", DRUPAL_ROOT.'/uploads');
define('base_url_lang', $base_url .'/'. ((!isset($language->language) || $language->language == 'und' || $language->language == 'vi') ? 'vi/' : $language->language.'/'));

define('AJAX_DOMAIN', '/sieuthigiare.vn/');
define('IS_WEB', 0);// 0:local, 1:web

/**
 * QuynhTM add
 * Dinh nghia cac Table cho website
 */
define('TABLE_SUPPORT_ONLINE', 'web_support_online');
define('TABLE_CONFIG_INFO',    'web_config_info');
define('TABLE_PRODUCT',        'web_product');
define('TABLE_USER_SHOP',      'web_user_shop');
define('TABLE_SUPPLIER',       'web_supplier');
define('TABLE_PROVINCE',       'web_province');
define('TABLE_CATEGORY',       'web_category');
define('TABLE_NEWS',           'web_news');
define('TABLE_CONTACT',        'web_contact');
define('TABLE_COMMENT',        'web_comment');
define('TABLE_ORDER',          'web_order');

//dinh nghia thu muc chua anh
define('FOLDER_DEFAULT', 'img_other');
define('FOLDER_PRODUCT', 'product');
define('FOLDER_NEWS', 'news');

//common
define('STASTUS_HIDE', 0);
define('STASTUS_SHOW', 1);

define('COMMENT_OK_REPLY', 0);//comment_is_reply
define('COMMENT_NOT_REPLY', 1);

define('CONTACT_NEW', 1);
define('CONTACT_OK', 2);
define('CONTACT_SUCCESS', 3);
define('CONTACT_REASON_CUSTOMER', 1);
define('CONTACT_REASON_SHOP', 2);

define('BLOCK_FALSE', 0);
define('BLOCK_TRUE', 1);

define('TYPE_PRICE_NUMBER', 1);
define('TYPE_PRICE_CONTACT', 2);

define('PRODUCT_NOMAL', 1);
define('PRODUCT_HOT', 2);
define('PRODUCT_SELLOFF', 3);
define('PRODUCT_BLOCK', 0);
define('PRODUCT_NOT_BLOCK', 1);

//loai shop
define('SHOP_FREE', 1);
define('SHOP_NOMAL', 2);
define('SHOP_VIP', 3);

define('IMAGE_ERROR', 113); // dung sau quet cac item up anh nhung ko cap nhat DB
define('IMAGE_DEFAULT', $base_url.'/sites/all/modules/autoLoad/img/default.png');






