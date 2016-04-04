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
				<div class="title-box-shop-search"><?php echo $title ?></div>
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
						        <div class="col-sm-9">
						        	<div class="control-group">
						                 <div class="col-lg-8">
						                     <a href="javascript:;"class="btn btn-primary" onclick="Common_admin.uploadMultipleImages(2);">Upload ảnh</a>
						                     <input name="image_primary" type="hidden" id="image_primary" value="">
						                     <input name="image_primary_hover" type="hidden" id="image_primary_hover" value="">
						                 </div>
						            </div>
									<!--hien thi anh-->
						            <ul id="sys_drag_sort" class="ul_drag_sort">
						            <?php if(isset($arrItem->product_image_other)){
						                $key_primary = -1;
						                $image_primary = $arrItem->product_image;
						                $image_primary_hover = $arrItem->product_image_hover;
						                ?>
						                    <?php
						                        if(trim($arrItem->product_image_other) != ''){
						                            $list_product_image_other = unserialize($arrItem->product_image_other);
						                            foreach($list_product_image_other as $k=>$v){ ?>
						                                <li id="sys_div_img_other_<?php echo $k ?>">
						                                    <div class="div_img_upload">
						                                        <img src="<?php echo $base_url.'/uploads/product/'.$arrItem->product_id.'/'.$v?>" height="80" width="80">
						                                        <input type="hidden" id="sys_img_other_<?php echo $k ?>" name="img_other[]" value="<?php echo $v ?>" class="sys_img_other">
						                                        <div class='clear'></div>
						                                        <input type="radio" id="chẹcked_image_<?php echo $k ?>" name="chẹcked_image" value="<?php echo $k ?>"
						                                               <?php if (isset($image_primary) && ($image_primary == $v)){ ?> checked="checked" <?php }?>
						                                        onclick="Common_admin.checkedImage('<?php echo $v ?>','<?php echo $k ?>');">
						                                        <label for="chẹcked_image_<?php echo $k ?>" style='font-weight:normal'>Ảnh đại diện</label>
						                                        <br/>
						                                        <input type="radio" id="chẹcked_image_hover<?php echo $k ?>" name="chẹcked_image_hover" value="<?php echo $k ?>"
						                                               <?php if (isset($image_primary_hover) && ($image_primary_hover == $v)){ ?> checked="checked" <?php }?>
						                                        onclick="Common_admin.checkedImageHover('<?php echo $v ?>','<?php echo $k ?>');">
						                                        <label for="chẹcked_image_hover<?php echo $k ?>" style='font-weight:normal'>Ảnh Hover</label>
						                                        <br/>
						                                        <a href="javascript:void(0);" id="sys_delete_img_other_<?php echo $k ?>"onclick="Common_admin.removeImage('<?php echo $k ?>','<?php if(isset($arrItem->product_id)){ echo $arrItem->product_id; } ?>','<?php echo $v ?>','1');">Xóa ảnh</a>
						                                        <span style="display: none"><b><?php echo $k ?></b></span>
						                                    </div>
						                                    <?php
						                                        if(isset($image_primary) && $image_primary == $v){
						                                            $key_primary = $k;
						                                        }
						                                    ?>
						                                </li>
						                            <?php }?>
						                            <input type="hidden" id="sys_key_image_primary" name="sys_key_image_primary" value="<?php echo $key_primary ?>">
						                        <?php } ?>

						            <?php } ?>
						            </ul>
						            <input name="list1SortOrder" id ='list1SortOrder' type="hidden" />
						            <!--ket thuc hien thi anh-->
						        </div>
							</div>
					        <div class="row">
					        	<div class="col-sm-6">
						        	<div class="control-group">
						                <label class="control-label">Chi tiết<span>(*)</span></label>
						                 <div class="controls"><button type="button" onclick="Common_admin.insertImageContent(2)" class="btn btn-primary">Chèn ảnh vào nội dung</button></div>
						                <div class="controls product_content">
						                	<textarea name="product_content" class="form-control input-sm" cols="30" rows="10"><?php if(isset($arrItem->product_content)) { echo $arrItem->product_content; } ?></textarea>
						                </div>
						            </div>
						            <div class="form-actions">
						                <input type="hidden" id="id_hiden" name="id" value="<?php if(isset($arrItem->product_id)) { echo $arrItem->product_id; } ?>"/>
						                <input type="hidden" value="txt-form-post" name="txt-form-post">
										<button type="submit" name="submit" id="buttonFormShopSubmit" class="btn btn-primary" value="1">Lưu</button>
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

<!--Popup anh khac de chen vao noi dung bai viet-->
<div class="modal fade" id="sys_PopupImgOtherInsertContent" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Click ảnh để chèn vào nội dung</h4>
            </div>
            <div class="modal-body">
                <form name="uploadImage" method="post" action="#" enctype="multipart/form-data">
                    <div class="form_group">
                        <div class="clearfix"></div>
                        <div class="clearfix" style='margin: 5px 10px; width:100%;'>
                            <div id="div_image" class="float_left">
                                <?php if (isset($arrImageOther) && count($arrImageOther) > 0) {?>
                                <?php foreach($arrImageOther as $kk => $img_other) {?>
                                    <span class="float_left image_insert_content">
                                        <a class="img_item" href="javascript:void(0);" onclick="insertImgContent('<?php echo $img_other['image_big']?>')" >
                                            <img src="<?php echo $img_other['image_small']?>" width="80" height="80">
                                        </a>
                                    </span>
                                <?php } } ?>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- chen anh vào noi dung-->

<script>
	CKEDITOR.replace('product_content',{height:600});
</script>
<script type="text/javascript">
    //keo tha anh
   jQuery("#sys_drag_sort").dragsort({ dragSelector: "div", dragBetween: true, dragEnd: saveOrder });
    function saveOrder() {
        var data = jQuery("#sys_drag_sort li div span").map(function() { return jQuery(this).children().html(); }).get();
        jQuery("input[name=list1SortOrder]").val(data.join(","));
    };
    function insertImgContent(src){
        CKEDITOR.instances.product_content.insertHtml('<img src="'+src+'"/>');
    }
</script>
