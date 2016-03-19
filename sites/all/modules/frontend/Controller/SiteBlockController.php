<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
function block_header(){
	$view= theme('block-header');
	return $view;
}
function block_slide(){
	$view= theme('block-slide');
	return $view;
}
function block_content(){
	$view= theme('block-content');
	return $view;
}
function block_footer(){
	$view= theme('block-footer');
	return $view;
}