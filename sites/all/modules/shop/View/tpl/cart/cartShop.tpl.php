<?php global $base_url;?>
<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="main-view-post shopcart">
				<div class="wrap-main-view">
					<h1 class="title-head text-left"><a title="Tất cả các sản phẩm trong giỏ hàng" href="<?php echo $base_url.'/shop-cart'?>">Tất cả các sản phẩm trong giỏ hàng</a></h1>
					<div class="view-content-post">
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
									<tr class="odd">
										<td>1</td>
										<td><a target="_blank" href="">Bộ đồ thể thao nam, áo ngắn tay, quần lửng, phong cách khỏe khoắn</a></td>
										<td><input type="text" name="listCart[192][M]" value="1" class="num-item-in-one-product"></td>
										<td>246,000<sup>đ</sup></td>
										<td>246,000<sup>đ</sup></td>
										<td>
											<a data-size="M" data="192" class="delOneItemCart" href="javascript:void(0)">Xóa</a>
										</td>
									</tr>	
										<tr>
										<td colspan="5"><b>Tổng số tiền thanh toán:</b></td>
										<td colspan="2"><b>246,000</b><sup>đ</sup></td>
									</tr>	
								</tbody>
							</table>
						</div>
						</form>
						<div class="list-btn-control">
							<a id="backBuy" class="btn btn-primary" href="javascript:void(0)">Tiếp tục mua hàng</a>
							<a id="updateCart" class="btn btn-primary" href="javascript:void(0)">Cập nhật đơn hàng</a>
							<a id="dellAllCart" class="btn btn-primary" data="del-all" href="javascript:void(0)">Xóa toàn bộ đơn hàng</a>
							<a id="sendCart" class="btn btn-primary" href="<?php echo $base_url?>/gui-don-hang.html">Gửi đơn hàng</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>