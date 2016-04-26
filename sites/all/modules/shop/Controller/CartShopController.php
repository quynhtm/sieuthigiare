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
	public function showCart(){
		global $base_url;
		
		$listCart 	= isset($_SESSION['cart']) ? $_SESSION['cart'] :  array();
		$updateCart = FunctionLib::getParam('listCart', array());
		$result = array();

		if(!empty($updateCart)){
			foreach($updateCart as $k => $v){
				if($v == 0){
					unset($_SESSION['cart'][$k]);
					if(empty($_SESSION['cart'])){
						unset($_SESSION['cart'][$k]);
					}
				}else{
					$_SESSION['cart'][$k] = $v;
				}
			}
			$listCart = $_SESSION['cart'];
			drupal_goto($base_url.'/gio-hang.html');
		}

		if(!empty($listCart)){
			$arrId  = array_keys($listCart);
			$arrFields = array('product_id', 'product_name', 'product_price_sell', 'product_type_price');
			$result = CartShop::getListCat($arrId, $arrFields);
			
			foreach($result as $key=>$item){
				if(in_array($item->product_id, $arrId)){
					$result[$key]->num = $listCart[$item->product_id];
				}	
			}
		}

		return theme('showCart', array('result'=>$result));
	}
	function delOne(){
		$id = FunctionLib::getParam('id', 0);
		if($id > 0){
			unset($_SESSION['cart'][$id]);
			echo 'oK';exit();
		}
	}
	public function delAllCart(){
		$delAll = FunctionLib::getParam('delAll', array());
		if($delAll == 'delAll'){
			unset($_SESSION['cart']);
			echo 'ok';exit();
		}
	}
	public function sendCart(){
		
		return theme('sendCart');
	}
}
