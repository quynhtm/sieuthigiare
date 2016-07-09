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
				if($num > 10){
					$num = 10;
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
			$result = CartShop::getListItem($arrId, $arrFields);
			
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
		global $base_url;

		$result= array();
		if(isset($_SESSION['cart'])){
			if(!empty($_SESSION['cart'])){
				$listCart = $_SESSION['cart'];
				$arrId  = array_keys($listCart);
				$arrFields = array('product_id', 'product_name', 'product_price_sell', 'product_type_price', 
									'product_image', 'product_image_hover', 'category_id', 'category_name',
									'user_shop_id', 'user_shop_name','shop_province'
									);
				$result = CartShop::getListItem($arrId, $arrFields);
				if(!empty($result)){
					foreach($result as $key=>$item){
						if(in_array($item->product_id, $arrId)){
							$result[$key]->num = $listCart[$item->product_id];
						}	
					}
				}else{
					drupal_goto($base_url);
				}
			}else{
				drupal_goto($base_url);
			}
		}else{
			drupal_goto($base_url);
		}

		if(isset($_POST) && !empty($_POST)){
			$name = FunctionLib::getParam('txtName', '');
			$phone = FunctionLib::getParam('txtMobile', '');
			$email = FunctionLib::getParam('txtEmail', '');
			$address = FunctionLib::getParam('txtAddress', '');
			$message = FunctionLib::getParam('txtMessage', '');

			if($name != '' && $phone != '' && $address != ''){
				$data = array(
						'order_customer_name'=>$name,
						'order_customer_phone'=>$phone,
						'order_customer_email'=>$email,
						'order_customer_address'=>$address,
						'order_customer_note'=>$message,
						'order_time'=>time(),
						'order_status'=>ORDER_STATUS_NEW
						);
				$arrMailShop = array();

				foreach($result as $v){
					$data['order_product_id'] = $v->product_id;
					$data['order_product_name'] = $v->product_name;
					$data['order_product_price_sell'] = $v->product_price_sell;
					$data['order_product_image'] = $v->product_image;
					$data['order_product_type_price'] = $v->product_type_price;
					$data['order_quality_buy'] = $v->num;

					$data['order_category_id'] = $v->category_id;
					$data['order_category_name'] = $v->category_name;

					$data['order_user_shop_id'] = $v->user_shop_id;
					$data['order_user_shop_name'] = $v->user_shop_name;
					$data['order_product_province'] = $v->shop_province;

					CartShop::insert($data);
					$arrMailShop[$v->user_shop_id][] = $v;

				}
				//Send Mail Cart To Shop
				foreach($arrMailShop as $key=>$val){
					$get_user_shop = DataCommon::getShopById($key);
					$email_shop = $get_user_shop->shop_email;
					
					$arrMail = array();
					if($email_shop != ''){
						$arrMail = @unserialize($email_shop);
						if(!is_array($arrMail)){
							$arrMail[] = $email_shop;
						}
					}
					
					if(is_array($arrMail) && !empty($arrMail)){
						foreach($arrMail as $mail){
							$subject = 'Shopcuatui.com.vn - Khách đã đặt mua sản phẩm của shop';
							$str = '';
							$total = 0;
							$contentEmail = '';

							$contentEmail .= '<b style="color:#ff6600">Xác nhận đặt hàng thành công!</b><br/><br/>';
							$contentEmail .= 'Chào: '.$get_user_shop->user_shop.'<br/>';
							$contentEmail .= 'Bạn nhận được email này do khách hàng đã đặt mua sản phẩm từ shop của bạn trên website ShopCuaTui.com.vn<br/><br/>';
							$contentEmail .= '<a href="'.$base_url.'/danh-sach-don-hang.html">Bấm vào đây để xem tình trạng đơn hàng.</a><br/><br/>';
							$contentEmail .= '<b>Thông tin sản phẩm</b><br/><br/>';					

							$contentEmail .= '<table width="100%" style="border-collapse:collapse">';
							$contentEmail.= '<tr class="first">
												<th style="border:1px solid #c8c8c8; padding:5px; text-align:center">STT</th>
												<th style="border:1px solid #c8c8c8; padding:5px; text-align:left">Tên sản phẩm</th>
												<th style="border:1px solid #c8c8c8; padding:5px; text-align:center">Số lượng</th>
												<th style="border:1px solid #c8c8c8; padding:5px; text-align:right">Thành tiền</th>
											</tr>';
							$stt = 0;
							foreach($val as $item){
								$stt++;
								if($item->product_price_sell > 0){
									$total = number_format($item->num * floatval($item->product_price_sell)).'đ';
								}else{
									$total = 'Liên hệ';
								}
								$contentEmail .= '<tr>
													<td style="border:1px solid #c8c8c8; padding:5px; text-align:center">'.$stt.'</td>
													<td style="border:1px solid #c8c8c8; padding:5px; text-align:left"><a href="'.FunctionLib:: buildLinkDetail($item->product_id, $item->product_name).'">'.$item->product_name.'</a></td>
													<td style="border:1px solid #c8c8c8; padding:5px; text-align:center">'.$item->num.'</td>
													<td style="border:1px solid #c8c8c8; padding:5px; text-align:right">'.$total.'</td>
												</tr>';
							}
							$contentEmail .= '</table><br/><br/>';

							$contentEmail .= '<b>Thông tin khách hàng</b><br/><br/>';
							$contentEmail .= 'Họ và tên: '.$name.'<br/>';
							$contentEmail .= 'Di động: '.$phone.'<br/>';
							$contentEmail .= 'Email: '.$email.'<br/>';
							$contentEmail .= 'Địa chỉ: '.$address.'<br/>';

							auto_send_mail('Shop', $contentEmail, $mail, $subject);
						}
					}
				}
				//Send Mail Cart To Shop
				unset($_SESSION['cart']);
				drupal_goto($base_url.'/cam-on-da-mua-hang.html');
			}

		}

		return theme('sendCart', array('result'=>$result));
	}
	public function thanksOrder(){
		return theme('thanksOrder');
	}
}
