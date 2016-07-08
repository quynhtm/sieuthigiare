<?php global $base_url;?>
<div class="container">
	<div class="main-view-post shopcart">
		<div class="wrap-main-view">
			<div class="view-content-post">
				<div class="pay">
					<div class="col-lg-6">
						<div class="content-post-cart">
							<div class="title-pay-cart">Chi tiết đơn hàng</div>
							<table class="list-pay">
					            <?php foreach($result as $item){?>
					            <tr>
					                <td width="10%">
						                <a class="img" href="<?php echo FunctionLib::buildLinkDetail($item->product_id, $item->product_name); ?>" title="<?php echo $item->product_name?>">
						                    <?php if($item->product_image != ''){?>
											<img width="60" src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $item->product_id, $item->product_image, 300, 300, '', true, true) ?>" 
												 alt="<?php echo $item->product_name ?>"/>
											<?php }else{ ?>
											<img width="60" src="<?php echo IMAGE_DEFAULT ?>"/>
											<?php } ?>
						                </a>
					            	</td>
					                <td>
					                	<span class="title"><?php echo $item->product_name ?></span>
					                </td>
					                <td width="20%">
					                	<span class="price">
											<?php 
												$price = 'Liên hệ';
												if($item->product_type_price == 2){
													echo $price.' x '.$item->num;;
												}else{
													if($item->product_price_sell > 0){
														$price = number_format($item->product_price_sell);
														echo $price.'đ x '.$item->num;
													}else{
														echo $price.' x '.$item->num;;
													}
												}
											?>
					                	</span>
					                </td>
					            </tr>
					            <?php } ?>
					    	</table>
					    </div>
					</div>

					<div class="col-lg-6">
						<div class="content-post-cart">
							<div class="title-pay-cart">Địa chỉ giao hàng</div>
							<form method="post" action="" name="txtFormPaymentCart" id="txtFormPaymentCart" class="txtFormPaymentCart">
								<div class="form-group">
									<label>Họ và tên<span>(*)</span></label>
									<input type="text" id="txtName" class="form-control" name="txtName" maxlength="255">
								</div>
								<div class="form-group">
									<label class="control-label">Số điện thoại<span>(*)</span></label>
									<input type="text" id="txtMobile" name="txtMobile" class="form-control" maxlength="255">
								</div>
								<div class="form-group">
									<label class="control-label">Email</label>
									<input type="text" id="txtEmail" name="txtEmail" class="form-control" maxlength="255">
								</div>
								<div class="form-group">
									<label class="control-label">Địa chỉ<span>(*)</span></label>
									<input type="text" id="txtAddress" name="txtAddress" class="form-control" maxlength="255">
								</div>
								<div class="form-group">
									<label>Ghi chú</label>
									<textarea  id="txtMessage" class="form-control" rows="5" name="txtMessage" maxlength="1000"></textarea>
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