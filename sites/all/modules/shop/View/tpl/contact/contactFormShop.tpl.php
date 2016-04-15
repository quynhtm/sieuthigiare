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
				<div class="title-box-shop-search"><?php echo $title ?></div>
				<div class="content-box-shop-search">
					<div class="wrapp-box-info">

							<div class="row">
								<!--Block 1-->
								<div class="col-sm-3">
									<div class="control-group">
										<label class="control-label">Tiêu đề tin<span>(*)</span></label>
										<div class="controls">
											<input type="text" class="form-control input-sm" placeholder="Tiêu đề tin" name="contact_title" value="">
										</div>
									</div>
						        </div>
							</div>

					        <div class="row">
					        	<div class="col-sm-7">
						        	<div class="control-group">
						                <label class="control-label">Nội dung liên hệ<span>(*)</span></label>
						                <div class="controls product_content">
						                	<textarea id="contact_content" name="contact_content" class="form-control input-sm" cols="30" rows="10"></textarea>
						                </div>
						            </div>
						        </div>
								<div class="col-sm-10">
						            <div class="form-actions">
						                <input type="hidden" value="txt-form-post" name="txt-form-post">
										<button type="submit" name="submit" id="buttonFormShopSubmit" class="btn btn-primary" value="1" >Gửi yêu cầu</button>
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

<script>
	CKEDITOR.replace('contact_content',{height:400});
</script>

