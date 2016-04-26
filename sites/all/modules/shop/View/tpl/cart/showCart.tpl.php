<?php global $base_url;?>
<div class="container">
	<div class="main-view-post shopcart">
		<div class="wrap-main-view">
			<div class="view-content-post">
				<?php if(!empty($result)){?>
				<h1 class="title-head text-left"><a title="Tất cả các sản phẩm trong giỏ hàng" href="<?php echo $base_url.'/gio-hang.html'?>">Tất cả các sản phẩm trong giỏ hàng</a></h1>
				<form method="post" action="" name="txtFormShopCart" id="txtFormShopCart">
				<div class="grid-shop-cart">
					<table width="100%" class="list-shop-cart-item">
						<tbody>
							<tr class="first">
								<th>STT</th>
								<th>Tên sản phẩm</th>
								<th>Số lượng</th>
								<th>Giá / 1 sản phẩm</th>
								<th>Thành tiền</th>
								<th>Thao tác</th>
							</tr>
							<?php foreach($result as $k=>$v){?>
							<tr>
								<td><?php echo $k+1 ?></td>
								<td><a target="_blank" href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>"><?php echo $v->product_name ?></a></td>
								<td>
									<select name="listCart[<?php echo $v->product_id ?>]">
										<?php for($i=1; $i<=10; $i++){ ?>
		                                <option value="<?php echo $i ?>" class="num-item-in-one-product" <?php if($v->num == $i){ ?>selected="selected"<?php } ?>><?php echo $i ?></option>
										<?php } ?>
									</select>
								</td>
								<td>
									<?php 
										$price = 'Liên hệ';
										if($v->product_type_price == 2){
											echo $price;
										}else{
											if($v->product_price_sell > 0){
												$price = number_format($v->product_price_sell);
												echo $price.'<sup>đ</sup>';
											}else{
												echo $price;
											}
										}
									?>
								</td>
								<td>
									<?php 
										if($price != 'Liên hệ'){
											$price = number_format($v->num*$v->product_price_sell);
											echo $price.'<sup>đ</sup>';
										}else{
											echo $price;
										}
									?>
								</td>
								<td>
									<a data-id="<?php echo $v->product_id ?>" class="delOneItemCart" href="javascript:void(0)">Xóa</a>
								</td>
							</tr>
							<?php } ?>
						</tbody>
					</table>
				</div>
				</form>
				<?php }else{ ?>
					<div class="not-product"><?php echo NOT_PRODUCT_CART ?></div>
				<?php } ?>
				<div class="list-btn-control <?php if(empty($result)){?>text-center<?php } ?>">
					<a id="backBuy" class="btn btn-primary" href="<?php echo $base_url.'/trang-chu' ?>">Tiếp tục mua hàng</a>
					<?php if(!empty($result)){?>
					<a id="updateCart" class="btn btn-primary" href="javascript:void(0)">Cập nhật đơn hàng</a>
					<a id="delAllCart" class="btn btn-primary" data="delAll" href="javascript:void(0)">Xóa toàn bộ đơn hàng</a>
					<a id="sendCart" class="btn btn-primary" href="<?php echo $base_url?>/gui-don-hang.html">Gửi đơn hàng</a>
					<?php } ?>
				</div>
			</div>
		</div>
	</div>	
</div>