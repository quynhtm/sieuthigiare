<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/

class AdmincpController{
    function AdminDefault(){
        global $base_url;
        drupal_set_title(t('CMS'));   
        return '';
    }
}
function admin_redirect(){
    global $base_url;
    drupal_goto($base_url.'/admincp');
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
   
    $files = array(
        'bootstrap/css/bootstrap.css',
        'css/font-awesome.css',
        'css/core.css',
    );
    Loader::load('Core', $files);

    $files = array(
        'View/css/admin.css',
        'View/js/admin.js',
    );
    Loader::load('Admin', $files);
    
	$view= theme('admin-content');
    return $view;
}
function blockAdminFooter(){
	$view= theme('admin-footer');
    return $view;
}