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
					<div class="wrapp-box-info">
						<form action="" method="post" id="frmChangeInfo" class="frmChangeInfo" name="frmChangeInfo">
							<div class="col-lg-4">
								<div class="form-group">
									<label class="control-label">Tên gian hàng<span>(*)</span></label>
									<div><input type="text" class="form-control input-sm" placeholder ="Tên gian hàng" name="shop_name"  maxlength="255" value="<?php echo $user_shop->shop_name?>"/></div>
								</div>
								<div class="form-group">
									<label class="control-label">Số điện thoại<span>(*)</span></label>
									<div><input type="text" class="form-control input-sm" placeholder ="Số điện thoại" name="shop_phone"  maxlength="255" value="<?php echo $user_shop->shop_phone?>"/></div>
								</div>
								<div class="form-group">
									<label class="control-label">Địa chỉ<span>(*)</span></label>
									<div><input type="text" class="form-control input-sm" placeholder ="Địa chỉ" name="shop_address"  maxlength="255" value="<?php echo $user_shop->shop_address?>"/></div>
								</div>
								<div class="form-group">
									<label class="control-label">Email<span>(*)</span></label>
									<div><input type="text" class="form-control input-sm" placeholder ="Email" name="shop_email"  maxlength="255" value="<?php echo $user_shop->shop_email?>"/></div>
								</div>
								<div class="form-group">
									<label class="control-label">Chọn 1 hay 2 danh mục sản phẩm đăng bán<span>(*)</span></label>
									<div>
										<select class="form-control input-sm" name="shop_category[]" multiple="multiple" style="height: 200px;">
											<option value="-1">--Chọn danh mục đăng bán sản phẩm -- </option>
											<?php
												if(count($arrCategoryParent) >0){
													foreach ($arrCategoryParent as $key => $text) {
														$input = '<option value="' . $key . '"';
														if (in_array($key, $arrShopCate)) {
															$input .= ' selected';
														}
														$input .= '>' . $text . '</option>';
														echo $input;
													}
												}
											?>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label">Tỉnh/thành<span>(*)</span></label>
									<div>
										<select class="form-control input-sm" name="shop_province">
											<?php foreach ($listProvinces as $k => $v) { ?>
											<option value="<?php echo $k ?>" <?php if($k == $user_shop->shop_province){ ?>selected="selected"<?php } ?>><?php echo $v ?></option>
											<?php } ?>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label">&nbsp;</label>
									<div>
										<input type="hidden" name="frmChangeInfo" id="frmChangeInfo" value="frmChangeInfo"/>
										<button id="btnChangeInfo" class="btn btn-primary" name="submit" value="1">Cập nhật</button>
									</div>
								</div>
							</div>

							<div class="col-lg-8">
								<div class="form-group">
									<label class="control-label">Chính sách giao nhận</label>
									<div><textarea class="form-control textarea-sm" name="shop_transfer"/><?php echo $user_shop->shop_transfer?></textarea></div>
								</div>
								<div class="form-group">
									<label class="control-label">Giới thiệu chung</label>
									<div><textarea class="form-control textarea-sm" name="shop_about"/><?php echo $user_shop->shop_about?></textarea></div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	CKEDITOR.replace(
		'shop_about',
		{
			toolbar: [
				{ name: 'document',    items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
				{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
				{ name: 'colors',      items : [ 'TextColor','BGColor' ] },
			],
		},
		{height:400}
	);
	CKEDITOR.replace(
		'shop_transfer',
		{
			toolbar: [
				{ name: 'document',    items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
				{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
				{ name: 'colors',      items : [ 'TextColor','BGColor' ] },
			],
		},
		{height:400}
	);
</script>