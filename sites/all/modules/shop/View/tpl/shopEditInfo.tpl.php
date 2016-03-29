<?php 
	global $base_url, $user_shop;
?>
<div class="main-manager-shop">
	<div class="header">
		<?php require_once(DRUPAL_ROOT.'/'.path_to_theme().'/View/tpl/shopHeader.tpl.php') ?>
	</div>
	<div class="content">
		<div class="wrapp-shop">
			<div class="box-shop-search">
				<div class="title-box-shop-search">Sửa thông tin gian hàng</div>
				<div class="content-box-shop-search">
					<form action="" method="post" id="frmChangeInfo" class="frmChangeInfo" name="frmChangeInfo">
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Tên gian hàng<span>(*)</span></label>
								<div><input type="text" class="form-control input-sm" placeholder ="Tên gian hàng" name="shop_name"  value="<?php echo $user_shop->shop_name?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Số điện thoại<span>(*)</span></label>
								<div><input type="text" class="form-control input-sm" placeholder ="Số điện thoại" name="shop_phone"  value="<?php echo $user_shop->shop_phone?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Địa chỉ</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Địa chỉ" name="shop_address"  value="<?php echo $user_shop->shop_address?>"/></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Email<span>(*)</span></label>
								<div><input type="text" class="form-control input-sm" placeholder ="Email" name="shop_email"  value="<?php echo $user_shop->shop_email?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Tỉnh/thành<span>(*)</span></label>
								<div>
									<select class="form-control input-sm" name="shop_province">
										<?php foreach($listProvince as $province){?>
										<option value="<?php echo $province->province_id ?>" <?php if($province->province_id == $user_shop->shop_province){ ?>selected="selected"<?php } ?>><?php echo $province->province_name ?></option>
										<?php } ?>
									</select>
								</div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Giới thiệu chung</label>
								<div><textarea class="form-control textarea-sm" name="shop_about"/><?php echo $user_shop->shop_about?></textarea></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">&nbsp;</label>
								<div>
									<input type="hidden" name="frmChangeInfo" id="frmChangeInfo" value="frmChangeInfo"/>
									<button class="btn btn-primary" name="submit" value="1">Sửa</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>