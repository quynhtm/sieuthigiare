<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 04/2016
* @Version	 : 1.0
*/
class CartShopController{
	public function __construct(){
		if (!drupal_session_started()){
			drupal_session_start();
		}
	}
	public function addCart(){
		global $base_url;
	
		$pid 	= FunctionLib::getIntParam('pid', 0);
		$pnum 	= FunctionLib::getIntParam('pnum', 0);
		
		$arrItem = CartShop::getItemById($pid, $pnum, array('product_id', 'product_status'));
		$mes = 'ok';
		if(!empty($arrItem)){
			if($arrItem[0]->product_status == STASTUS_SHOW){
				if(isset($_SESSION['cart'][$pid])){
					$num = $_SESSION['cart'][$pid] + $pnum;	
				}else{
					$num = $pnum;
				}
				$_SESSION['cart'][$pid] = $num;
				$mes = 'ok';
			}else{
				$mes = 'no';
			}
		}else{
			$mes = 'no';
		}
		echo $mes; exit();
	}

	public function cartShop(){
		
		return theme('cartShop');
	}
	public function cartSendShop(){
		
		return theme('cartSendShop');
	}
}
