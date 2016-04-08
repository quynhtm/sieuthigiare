<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class ShopCartController{
	
	public function shopCart(){
		
		return theme('shopCart');
	}
	public function shopSendCart(){
		
		return theme('shopSendCart');
	}
}
