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
				<div class="title-box-shop-search">Thêm mới sản phẩm</div>
				<div class="content-box-shop-search">
					<div class="wrapp-box-info">
						<form action="" method="post" id="frmformShop" class="frmformShop" name="frmformShop" enctype="multipart/form-data">
							<div class="row">
								<div class="col-sm-3">
									<div class="control-group">
						                <label class="control-label">Danh mục<span>(*)</span></label>
						                <div class="controls">
						                    <select class="form-control input-sm" name="category_id">
						                    	<?php echo $optionCategoryChildren ?>
						                    </select>
						                </div>
						            </div>
						            <div class="control-group">
						                <label class="control-label">Mã sản phẩm<span>(*)</span></label>
						                <div class="controls">
						                    <input type="text" class="form-control input-sm" placeholder="Mã sản phẩm" name="product_code" value="<?php if(isset($arrItem->product_code)) { echo $arrItem->product_code; } ?>">
						                </div>
						            </div>
									<div class="control-group">
						                <label class="control-label">Tên Sản phẩm<span>(*)</span></label>
						                <div class="controls">
						                    <input type="text" class="form-control input-sm" placeholder="Tên Sản phẩm" name="product_name" value="<?php if(isset($arrItem->product_name)) { echo $arrItem->product_name; } ?>">
						                </div>
						            </div>
						             <div class="control-group">
						                <label class="control-label">Giá bán</label>
						                <div class="controls">
						                    <input type="text" class="form-control input-sm" placeholder="Giá bán" name="product_price_sell" value="<?php if(isset($arrItem->product_price_sell)) { echo $arrItem->product_price_sell; } ?>">
						                </div>
						            </div>
						            <div class="control-group">
						                <label class="control-label">Giá thị trường</label>
						                <div class="controls">
						                    <input type="text" class="form-control input-sm" placeholder="Giá thị trường" name="product_price_market" value="<?php if(isset($arrItem->product_price_market)) { echo $arrItem->product_price_market; } ?>">
						                </div>
						            </div>
						        </div>
						        <div class="col-sm-3">
						        	<div class="control-group">
						                <label class="control-label">Ảnh chính</label>
						                <div class="controls btn btn-default btn-file">
						                	<input type="file" name="product_image">
						                </div>
						            </div>
						             <div class="control-group">
						                <label class="control-label">Ảnh phụ</label>
						                <div class="controls btn btn-default btn-file">
						                	<input type="file" name="product_image_hover">
						                </div>
						            </div>
						        </div>
							</div>
					        <div class="row">
					        	<div class="col-sm-6">
						        	<div class="control-group">
						                <label class="control-label">Chi tiết</label>
						                <div class="controls">
						                	<textarea name="product_content" class="form-control input-sm" cols="30" rows="10"><?php if(isset($arrItem->product_content)) { echo $arrItem->product_content; } ?></textarea>
						                </div>
						            </div>
						            <div class="form-actions">
						                <input type="hidden" value="txt-form-post" name="txt-form-post">
										<button type="submit" name="submit" id="buttonSubmit" class="btn btn-primary" value="1">Lưu</button>
						                <button type="reset" class="btn">Bỏ qua</button>
						            </div>
						        </div>
					        </div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	CKEDITOR.replace('product_content');
</script>