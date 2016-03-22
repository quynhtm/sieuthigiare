<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
function AdminDefault(){
    global $base_url;
    drupal_set_title(t('CMS'));   
    return '';
}
function blockAdminHeader(){
    $view= theme('admin-header');
    return $view;
}
function blockAdminLeft(){
	$view= theme('admin-left');
    return $view;
}
function blockAdminContent(){
	$view= theme('admin-content');
    return $view;
}
function blockAdminFooter(){
	$view= theme('admin-footer');
    return $view;
}
function admin_redirect(){
    global $base_url;
    drupal_goto($base_url.'/admincp');
}