<?php 
	global $base_url, $user_shop;
?>
<div class="main-manager-shop">
	<div class="header">
		<?php require_once(DRUPAL_ROOT.'/'.path_to_theme().'/View/tpl/shopHeader.tpl.php') ?>
	</div>
	<form action="" method="post" id="frmformShop" class="frmformShop" name="frmformShop" enctype="multipart/form-data">
	<div class="content">
		<div class="wrapp-shop">
			<div class="box-shop-search">
				<div class="title-box-shop-search"><?php echo $title ?>
						<span style="float: right; margin-right:50px ">
							<button type="submit" name="submit" class="buttonFormShopSubmit btn btn-primary" value="1">Lưu</button>
   							<a href="javascript:void(0);" onclick="window.history.back();" title="Bỏ qua" class="btn btn-warning" style="background-color:#bbb;border-color:#bbb;">Bỏ qua</a>
						</span>
				</div>
				<div class="content-box-shop-search">
					<div class="wrapp-box-info">
						<div class="row">
							<!--Block 1-->
							<div class="col-sm-5">
								<div class="control-group">
									<label class="control-label">Tên nhà cung cấp<span>(*)</span></label>
									<div class="controls">
										<input type="text" class="form-control input-sm" placeholder="Tên nhà cung cấp" name="provider_name"value="<?php if(isset($arrItem->provider_name)) { echo $arrItem->provider_name; } ?>">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Số điện thoại</label>
									<div class="controls">
										<input type="text" class="form-control input-sm" placeholder="Số điện thoại" name="provider_phone" value="<?php if(isset($arrItem->provider_phone)) { echo $arrItem->provider_phone; } ?>">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Email nhà cung cấp</label>
									<div class="controls">
										<input type="text" class="form-control input-sm" placeholder="Email" name="provider_email" value="<?php if(isset($arrItem->provider_email)) { echo $arrItem->provider_email; } ?>">
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">Địa chỉ</label>
									<div class="controls">
										<input type="text" class="form-control input-sm" placeholder="Địa chỉ" name="provider_address" value="<?php if(isset($arrItem->provider_address)) { echo $arrItem->provider_address; } ?>">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">Ghi chú</label>
									<div class="controls">
										<input type="text" class="form-control input-sm" placeholder="Ghi chú" name="provider_note" value="<?php if(isset($arrItem->provider_note)) { echo $arrItem->provider_note; } ?>">
									</div>
								</div>

								<div class="control-group">
									<label class="control-label">Trạng thái ẩn/hiện</label>
									<div class="controls">
										<select class="form-control input-sm" name="provider_status">
											<?php echo $optionStatus ?>
										</select>
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-10">
								<div class="form-actions">
									<input type="hidden" id="id_hiden" name="id" value="<?php if(isset($arrItem->provider_id)) { echo $arrItem->provider_id; } ?>"/>
									<input type="hidden" value="txt-form-post" name="txt-form-post">
									<button type="submit" name="submit" class="buttonFormShopSubmit_2 btn btn-primary" value="1" >Lưu</button>
									<a href="javascript:void(0);" onclick="window.history.back();" title="Bỏ qua" class="btn btn-warning" style="background-color:#bbb;border-color:#bbb;">Bỏ qua</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">

</script>
