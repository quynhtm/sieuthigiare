<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ShopShowProductController{
	
	public function __construct(){
		$files = array(
	            'css/font-awesome.css',
	        );
	    Loader::load('Core', $files);
	}

	public function shopshowProduct(){
		
		return theme('shopShowProduct');
	}
	public function shopDetailProduct(){
		$files = array(
	            'bootstrap/lib/jcarousel/jquery.jcarousel.min.js',
	            'bootstrap/lib/jcarousel/jcarousel.responsive.js',
	            'bootstrap/lib/jcarousel/jcarousel.responsive.css',
	        );
	    Loader::load('Core', $files);

		return theme('shopDetailProduct');
	}
}
