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
						                    <input type="text" class="form-control input-sm" placeholder="Mã sản phẩm" name="product_code" value="">
						                </div>
						            </div>
									<div class="control-group">
						                <label class="control-label">Tên sản phẩm<span>(*)</span></label>
						                <div class="controls">
						                    <input type="text" class="form-control input-sm" placeholder="Tên sản phẩm" name="product_name" value="">
						                </div>
						            </div>
						             <div class="control-group">
						                <label class="control-label">Giá bán</label>
						                <div class="controls">
						                    <input type="text" class="form-control input-sm" placeholder="Giá bán" name="product_price_sell" value="">
						                </div>
						            </div>
						            <div class="control-group">
						                <label class="control-label">Giá thị trường</label>
						                <div class="controls">
						                    <input type="text" class="form-control input-sm" placeholder="Giá thị trường" name="product_price_market" value="">
						                </div>
						            </div>
						        </div>
						        <div class="col-sm-3">
						        	<div class="control-group">
						                 <div class="col-lg-8">
						                     <a href="javascript:;"class="btn btn-primary" onclick="Common_admin.uploadMultipleImages(2);">Upload ảnh</a>
						                     <input name="image_primary" type="hidden" id="image_primary" value="">
						                 </div>
						            </div>
									<ul id="sys_drag_sort" class="ul_drag_sort">
										
									</ul>
									<input name="list1SortOrder" id ='list1SortOrder' type="hidden" />
						             
						        </div>
							</div>
					        <div class="row">
					        	<div class="col-sm-6">
						        	<div class="control-group">
						                <label class="control-label">Chi tiết<span>(*)</span></label>
						                <div class="controls">
						                	<textarea name="product_content" class="form-control input-sm" cols="30" rows="10"></textarea>
						                </div>
						            </div>
						            <div class="form-actions">
						                <input type="hidden" id="id_hiden" name="id"/>
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
                        <div id="sys_mulitplefileuploader" class="btn btn-primary">Upload ảnh</div>
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

<script>
	CKEDITOR.replace('product_content');
</script>
<script type="text/javascript">
    //keo tha anh
   jQuery("#sys_drag_sort").dragsort({ dragSelector: "div", dragBetween: true, dragEnd: saveOrder });
    function saveOrder() {
        var data = jQuery("#sys_drag_sort li div span").map(function() { return jQuery(this).children().html(); }).get();
        jQuery("input[name=list1SortOrder]").val(data.join(","));
    };
    function insertImgContent(src){
        CKEDITOR.instances.content.insertHtml('<img src="'+src+'"/>');
    }
</script>