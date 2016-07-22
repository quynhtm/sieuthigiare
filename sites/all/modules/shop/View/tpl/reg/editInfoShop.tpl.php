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
								<div class="form-group shop-phone">
									<label class="control-label">Số điện thoại <?php if($user_shop->is_shop == SHOP_VIP){?><i class="cursor add-phone">(Click để thêm)</i><?php } ?></label>
									<?php 
										if($user_shop->shop_phone != ''){
										$arrPhone = @unserialize($user_shop->shop_phone);
										if(!is_array($arrPhone)){
											$arrPhone[] = $user_shop->shop_phone;
										}
									?>
										<?php if(is_array($arrPhone) && !empty($arrPhone)){ ?>
											<?php foreach($arrPhone as $key=>$phone){?>
											<div>
												<input type="text" class="form-control input-sm" placeholder ="Số điện thoại" name="shop_phone[]"  maxlength="255" value="<?php echo $phone ?>"/>
												<?php if($user_shop->is_shop == SHOP_VIP){?>
													<?php if($key > 0){?><i class="icon-remove"></i><?php } ?>
												<?php } ?>
											</div>
											<?php } ?>
										<?php }elseif(is_array($arrPhone) && empty($arrPhone)){ ?>
											<div><input type="text" class="form-control input-sm" placeholder ="Số điện thoại" name="shop_phone[]"  maxlength="255"/></div>
										<?php }else{ ?>
											<div><input type="text" class="form-control input-sm" placeholder ="Số điện thoại" name="shop_phone[]"  maxlength="255" value="<?php echo $user_shop->shop_phone ?>"/></div>
										<?php } ?>
					
									<?php }else{ ?>
									<div><input type="text" class="form-control input-sm" placeholder ="Số điện thoại" name="shop_phone[]"  maxlength="255"/></div>
									<?php } ?>
								</div>
								<div class="form-group">
									<label class="control-label">Địa chỉ<span>(*)</span></label>
									<div><input type="text" class="form-control input-sm" placeholder ="Địa chỉ" name="shop_address"  maxlength="255" value="<?php echo $user_shop->shop_address?>"/></div>
								</div>
								<div class="form-group shop-mail">
									<label class="control-label">Email</label>
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

								<?php if($user_shop->is_shop == SHOP_VIP){?>
								<div class="form-group">
			                         <a href="javascript:;"class="btn btn-primary" onclick="Common_admin.uploadBannerAdvanced(5);">Upload ảnh logo</a>
			                         <div id="sys_show_image_banner">
			                             <?php if(isset($user_shop->shop_logo) && $user_shop->shop_logo !=''){?>
			                                 <img height='300' width='400' src='<?php echo FunctionLib::getThumbImage($user_shop->shop_logo,$user_shop->shop_id,FOLDER_SHOP,400,300)?>'/>
			                             <?php }?>
			                         </div>
			                         <input name="img" type="hidden" id="img" value="<?php if(isset($user_shop->shop_logo)){ echo $user_shop->shop_logo; } ?>">
			                         <input name="img_old" type="hidden" id="img_old" value="<?php if(isset($user_shop->shop_logo)){ echo $user_shop->shop_logo; } ?>">
			                         <input type="hidden" id="id_hiden" name="id" value="<?php if(isset($user_shop->shop_id)){ echo $user_shop->shop_id; } ?>"/>
			                    </div>
								<?php } ?>

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
<?php if($user_shop->is_shop == SHOP_VIP){?>
<!--Popup upload ảnh-->
<div class="modal fade" id="sys_PopupUploadImgOtherPro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Upload ảnh</h4>
            </div>
            <div class="modal-body">
                <form name="uploadImage" method="post" action="#" enctype="multipart/form-data">
                    <div class="form_group">
                        <div id="sys_show_button_upload">
                            <div id="sys_mulitplefileuploader" class="btn btn-primary">Upload ảnh</div>
                        </div>
                        <div id="status"></div>

                        <div class="clearfix"></div>
                        <div class="clearfix" style='margin: 5px 10px; width:100%;'>
                            <div id="div_image"></div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--Popup upload ảnh-->
<?php } ?>
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