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
define("SITE_RECORD_PER_PAGE", '32');
define('SITE_SCROLL_PAGE', '3');
define('SITE_SAME_RECORD', '5');
define("SITE_RECORD_PER_PAGE_SHOP_NORMAL", '12');
define("SITE_RECORD_PER_PAGE_SHOP_VIP", '32');
define("NUMBER_PRODUCT_HOME", 15);
define("NUMBER_PRODUCT_NEW", 7);

define("PATH_UPLOAD", DRUPAL_ROOT.'/uploads');
define('base_url_lang', $base_url .'/'. ((!isset($language->language) || $language->language == 'und' || $language->language == 'vi') ? 'vi/' : $language->language.'/'));

define('AJAX_DOMAIN', '/shopcuatui.com.vn/');//check preg_match ajax
define('WEB_SITE', 'Shopcuatui.com.vn');//suffix link and alt

define('IS_DEV', 1);// 0:local, 1:web
define('PHONE_CARE', '0985.10.10.26 - 0913.922.986');
define('NOT_PRODUCT', 'Chưa có sản phẩm nào...');
define('NOT_PRODUCT_CART', 'Chưa có sản phẩm nào trong giỏ hàng...');
define('SESSION_SHOP_TIME_OUT', 3600);
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
define('TABLE_BUILD_SQL',      'web_build_sql');
define('TABLE_COMMENT',        'web_comment');
define('TABLE_ORDER',          'web_order');
define('TABLE_BANNER',         'web_banner');
define('TABLE_ADVERTISE_CLICK','web_advertise_click');
define('TABLE_VIDEO','web_video');

//dinh nghia thu muc chua anh
define('FOLDER_DEFAULT', 'img_other');
define('FOLDER_PRODUCT', 'product');
define('FOLDER_BANNER', 'banner');
define('FOLDER_VIDEO', 'video');
define('FOLDER_NEWS', 'news');
define('FOLDER_CATEGORY', 'category');

//common
define('STASTUS_HIDE', 0);
define('STASTUS_SHOW', 1);
define('STASTUS_BLOCK', -1);//khóa

define('COMMENT_OK_REPLY', 0);//comment_is_reply
define('COMMENT_NOT_REPLY', 1);

define('CONTACT_NEW', 1);
define('CONTACT_OK', 2);
define('CONTACT_SUCCESS', 3);
define('CONTACT_REASON_CUSTOMER', 1);
define('CONTACT_REASON_SHOP', 2);
define('CONTACT_TYPE_SEND', 1);//ki?u g?i
define('CONTACT_TYPE_RECEIVE', 2);//receive ki?u nh?n

define('BLOCK_FALSE', 0);
define('BLOCK_TRUE', 1);

define('TYPE_PRICE_NUMBER', 1);
define('TYPE_PRICE_CONTACT', 2);

define('PRODUCT_NOMAL', 1);
define('PRODUCT_HOT', 2);
define('PRODUCT_SELLOFF', 3);
define('PRODUCT_BLOCK', 0);
define('PRODUCT_NOT_BLOCK', 1);

define('BANNER_NOT_RUN_TIME', 0);
define('BANNER_IS_RUN_TIME', 1);
define('BANNER_NOT_TARGET_BLANK', 0);
define('BANNER_TARGET_BLANK', 1);
define('BANNER_NOT_SHOP', 0);
define('BANNER_IS_SHOP', 1);
define('BANNER_TYPE_HOME_BIG', 1);
define('BANNER_TYPE_HOME_SMALL', 2);
define('BANNER_TYPE_HOME_LEFT', 3);
define('BANNER_TYPE_HOME_RIGHT', 4);
define('BANNER_TYPE_HOME_LIST', 5);
define('BANNER_PAGE_HOME', 1);
define('BANNER_PAGE_LIST', 2);
define('BANNER_PAGE_DETAIL', 3);
define('BANNER_PAGE_CATEGORY', 4);


define('NEW_CATEGORY_CUSTOMER', 1);
define('NEW_CATEGORY_SHOP', 2);
define('NEW_CATEGORY_GIOI_THIEU', 3);
define('NEW_CATEGORY_GIAI_TRI', 4);
define('NEW_CATEGORY_THI_TRUONG', 5);
define('NEW_CATEGORY_GOC_GIA_DINH', 6);
define('NEW_CATEGORY_TIN_TUC_CHUNG', 7);
define('NEW_CATEGORY_QUANG_CAO', 8);
define('NEW_TYPE_DAC_BIET', 1);// di voi danh muc: 1,2,3
define('NEW_TYPE_NOI_BAT', 2);// di voi danh muc: 4,5,6,7
define('NEW_TYPE_TIN_TUC', 3);// di voi danh muc: 4,5,6,7
define('NEW_TYPE_QUANG_CAO', 4);// di voi danh muc: 8

//Trang thái Don hang
//0:đơn hàng bị xóa1: đơn hàng mới, 2: đơn hàng đã xác nhận, 3:đơn hàng hoàn thành,4: đơn hàng bị hủy
define('ORDER_STATUS_DELETE', 0);
define('ORDER_STATUS_NEW', 1);
define('ORDER_STATUS_CHECKED', 2);
define('ORDER_STATUS_SUCCESS', 3);
define('ORDER_STATUS_CANCEL', 4);

//loai shop
define('SHOP_FREE', 1);
define('SHOP_NOMAL', 2);
define('SHOP_VIP', 3);
define('SHOP_ONLINE', 1);
define('SHOP_OFFLINE', 0);
define('SHOP_number_limit_product', 3);
define('SHOP_NUMBER_PRODUCT_FREE', 20);//so luong san pham shop dc dang
define('SHOP_NUMBER_PRODUCT_NOMAL', 100);
define('SHOP_NUMBER_PRODUCT_VIP',1000);

/*link nofolow*/
define('LINK_NOFOLLOW', 0);
define('LINK_FOLLOW',1);

/*img*/
define('IMAGE_ERROR', 113); // dung sau quet cac item up anh nhung ko cap nhat DB
define('IMAGE_DEFAULT', $base_url.'/sites/all/modules/autoLoad/img/default.png');
define('IMAGE_DEFAULT_VIDEO', $base_url.'/sites/all/modules/autoLoad/img/default-video.png');
define('IMAGE_DEFAULT_SHOP', $base_url.'/sites/all/modules/autoLoad/img/default-shop.png');