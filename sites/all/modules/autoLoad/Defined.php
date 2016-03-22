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


/**
 * QuynhTM add
 * Dinh nghia cac Table cho website
 */
define('TABLE_SUPPORT_ONLINE', 'web_support_online');
define('TABLE_CONFIG_INFO', 'web_config_info');
define('TABLE_PRODUCT', 'web_product');
define('TABLE_USER_SHOP', 'web_user_shop');
define('TABLE_PROVICES', 'web_provices');





