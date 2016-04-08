<?php global $base_url;?>
<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="main-view-post shopcart">
				<div class="wrap-main-view">
					<div class="view-content-post">
						<div class="pay">
							<div class="col-lg-6">
								<div class="content-post-cart">
									<div class="title-pay-cart">Chi tiết đơn hàng</div>
									<table class="list-pay">
							            
							            <tr>
							                <td width="10%">
								                <a class="img" href="">
								                    <img height="60" width="60" alt="Áo Sơ Mi Nam Công Sở Fonto Menswear : SR045" src="<?php echo $base_url.'/'.path_to_theme() ?>/View/img/s1.jpg">
								                </a>
							            	</td>
							                <td>
							                	<span class="title">Áo Sơ Mi Nam Công Sở Fonto Menswear : SR048</span>
							                </td>
							                <td width="20%">
							                	<span class="price">350.000đ x 1</span>
							                </td>
							            </tr>
							             <tr>
							               	<td width="10%">
								                <a class="img" href="">
								                    <img height="60" width="60" alt="Áo Sơ Mi Nam Công Sở Fonto Menswear : SR045" src="<?php echo $base_url.'/'.path_to_theme() ?>/View/img/s2.jpg">
								                </a>
							            	</td>
							                <td>
							                	<span class="title">Áo Sơ Mi Nam Công Sở Fonto Menswear : SR048</span>
							                </td>
							                <td width="20%">
							                	<span class="price">350.000đ x 1</span>
							                </td>
							            </tr>
							            <tr class="last">
							                <td colspan="2"><div class="total-price-cart">Tổng</div></td>
							                <td width="20%"><span class="price">700.000đ</span></td>
							            </tr>
							    	</table>
							    </div>
							</div>

							<div class="col-lg-6">
								<div class="content-post-cart">
									<div class="title-pay-cart">Địa chỉ giao hàng</div>
									<form method="post" action="" name="txtFormPaymentCart" id="txtFormPaymentCart" class="txtFormPaymentCart">
										<div class="form-group">
											<label>Họ và tên<span>(*)</span></label>
											<input type="text" id="txtName" class="form-control" name="txtName" value="">
										</div>
										<div class="form-group">
											<label class="control-label">Số điện thoại<span>(*)</span></label>
											<input type="text" id="txtMobile" name="txtMobile" class="form-control" value="">
										</div>
										<div class="form-group">
											<label class="control-label">Email</label>
											<input type="text" id="txtEmail" name="txtEmail" class="form-control" value="">
										</div>
										<div class="form-group">
											<label class="control-label">Địa chỉ<span>(*)</span></label>
											<input type="text" id="txtAddress" name="txtAddress" class="form-control" value="">
										</div>
										<div class="form-group">
											<label>Ghi chú<span>(*)</span></label>
											<textarea  id="txtMessage" class="form-control" rows="5" name="txtMessage"></textarea>
											<span class="des">VD: thời gian nhận hàng...</span>
										</div>
										 <input type="hidden" name="txtFormName" id="txtFormName" value="txtFormName"/>
										<button type="submit" id="submitPaymentOrder" class="btn btn-primary">Gửi đơn hàng</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>