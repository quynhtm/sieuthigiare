<?php global $base_url ?>
<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php echo (isset($item_id) && $item_id > 0) ? 'Sửa thông tin '.$title: t('Thêm thông tin '.$title);?></h5>
		</div>
	</div>
	<div class="page-content-box paddingTop30">
        <div class="show-bottom-info">
		     <form class="form-horizontal" name="txtForm" action="" method="post" enctype="multipart/form-data">
             <!--Block 1-->
             <div class="col-lg-3">
                 <div class="col-lg-12">
                     <label class="control-label">Tên Sản phẩm<span class="price_sell">(*)</span></label>
                     <div>
                         <input type="text" class="form-control input-sm" placeholder="Tên Sản phẩm" name="product_name" maxlength="255" value="<?php if(isset($arrItem->product_name)) { echo $arrItem->product_name; } ?>">
                     </div>
                 </div>
                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">User Shop<span class="price_sell">(*)</span></label>
                     <div>
                         <select class="form-control input-sm" name="user_shop_id" id="user_shop_id">
                             <?php echo $optionUserShop ?>
                         </select>
                     </div>
                 </div>
                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">Danh mục<span class="price_sell">(*)</span></label>
                     <div>
                         <select class="form-control input-sm" name="category_id" id="category_id">
                             <?php echo $optionCategory ?>
                         </select>
                     </div>
                 </div>

                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">Loại sản phẩm</label>
                     <div>
                         <select class="form-control input-sm" name="product_is_hot">
                             <?php echo $optionTypeProduct ?>
                         </select>
                     </div>
                 </div>
                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">Thứ tự hiển thị</label>
                     <div>
                         <input type="text" class="form-control input-sm" placeholder="Thứ tự hiển thị" name="product_order" maxlength="10" value="<?php if(isset($arrItem->product_order)) { echo $arrItem->product_order; } ?>">
                     </div>
                 </div>

                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">Trạng thái ẩn/hiện</label>
                     <div>
                         <select class="form-control input-sm" name="product_status">
                             <?php echo $optionStatus ?>
                         </select>
                     </div>
                 </div>
             </div>
             <!--Block 2-->
             <div class="col-lg-3">
                 <div class="col-lg-12">
                     <label class="control-label">Kiểu hiển thị giá</label>
                     <div>
                         <select class="form-control input-sm" name="product_type_price" id="product_type_price">
                             <?php echo $optionTypePrice ?>
                         </select>
                     </div>
                 </div>
                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">Giá bán<span class="price_sell">(*)</span></label>
                     <div>
                         <input type="text" placeholder="Giá bán" id="product_price_sell" name="product_price_sell" class="formatMoney text-right form-control" data-v-max="999999999999999" data-v-min="0" data-a-sep="." data-a-dec="," data-a-sign=" đ" data-p-sign="s" value="<?php if(isset($arrItem->product_price_sell)) { echo $arrItem->product_price_sell; } ?>">
                         <input type="hidden" id="product_price_sell_hide" name="product_price_sell_hide" value="0">
                     </div>
                 </div>
                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">Giá thị trường</label>
                     <div>
                         <input type="text" placeholder="Giá thị trường" name="product_price_market" id="product_price_market" class="formatMoney text-right form-control" data-v-max="999999999999999" data-v-min="0" data-a-sep="." data-a-dec="," data-a-sign=" đ" data-p-sign="s" value="<?php if(isset($arrItem->product_price_market)) { echo $arrItem->product_price_market; } ?>">
                         <input type="hidden" id="product_price_market_hide" name="product_price_market_hide" value="0">
                     </div>
                 </div>
                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">Giá nhập</label>
                     <div>
                         <input type="text" placeholder="Giá nhập" name="product_price_input" id="product_price_input" class="formatMoney text-right form-control" data-v-max="999999999999999" data-v-min="0" data-a-sep="." data-a-dec="," data-a-sign=" đ" data-p-sign="s" value="<?php if(isset($arrItem->product_price_sell)) { echo $arrItem->product_price_sell; } ?>">
                         <input type="hidden" id="product_price_input_hide" name="product_price_input_hide" value="0">
                     </div>
                 </div>
                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">Thông tin khuyến mại</label>
                     <div>
                         <input type="text" class="form-control input-sm" placeholder="Thông tin khuyến mại" name="product_selloff" maxlength="255" value="<?php if(isset($arrItem->product_selloff)) { echo $arrItem->product_selloff; } ?>">
                     </div>
                 </div>
             </div>

             <div class="col-lg-6">
                 <div class="col-lg-12 paddingTop10">
                     <div class="col-lg-12">
                         <a href="javascript:;"class="btn btn-primary" onclick="Common_admin.uploadMultipleImages(2);">Upload ảnh</a>
                         <input name="image_primary" type="hidden" id="image_primary" value="<?php if(isset($arrItem->product_image)) { echo $arrItem->product_image; } ?>">
                         <input name="image_primary_hover" type="hidden" id="image_primary_hover" value="<?php if(isset($arrItem->product_image_hover)) { echo $arrItem->product_image_hover; } ?>">
                     </div>
                 </div>
                 <!--hien thi anh-->
                 <ul id="sys_drag_sort" class="ul_drag_sort paddingTop10" style="margin-left: 10px!important;">
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
                                         <a href="javascript:void(0);" id="sys_delete_img_other_<?php echo $k ?>"onclick="Common_admin.removeImage('<?php echo $k ?>','<?php if(isset($arrItem->product_id)){ echo $arrItem->product_id; } ?>','<?php echo $v ?>','2');">Xóa ảnh</a>
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

             <div class="col-lg-12">
                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">Mô tả ngắn<span class="price_sell">(*)</span></label>
                     <div><textarea id="product_sort_desc" name="product_sort_desc" class="form-control input-sm" cols="30" rows="10"><?php if(isset($arrItem->product_sort_desc)) { echo $arrItem->product_sort_desc; } ?></textarea></div>
                 </div>

                 <div class="col-lg-12 paddingTop10">
                     <label class="control-label">Mô tả ngắn<span class="price_sell">(*)</span></label>
                     <div><button type="button" onclick="Common_admin.insertImageContent(2)" class="btn btn-primary">Chèn ảnh vào nội dung</button></div>
                     <div>
                         <textarea name="product_content" id="product_content" class="form-control input-sm" cols="30" rows="10"><?php if(isset($arrItem->product_content)) { echo $arrItem->product_content; } ?></textarea>
                     </div>
                 </div>

                 <div class="col-lg-12 paddingTop10">
                     <input type="hidden" id="id_hiden" name="id" value="<?php if(isset($arrItem->product_id)) { echo $arrItem->product_id; } ?>"/>
                     <input type="hidden" value="txt-form-post" name="txt-form-post">
                     <button type="submit" name="submit" class="buttonFormShopSubmit btn btn-primary" value="1" >Lưu</button>
                     <a href="javascript:void(0);" onclick="window.history.back();" title="Bỏ qua" class="btn btn-warning" style="background-color:#bbb;border-color:#bbb;">Bỏ qua</a>
                 </div>
             </div>
		 </form>
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

<script type="text/javascript">
    //dịnh dạng giá
    jQuery('.formatMoney').autoNumeric('init');
    CKEDITOR.replace('product_content',{height:650});
    CKEDITOR.replace(
        'product_sort_desc',
        {
            toolbar: [
                { name: 'document',    items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
                { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
                { name: 'colors',      items : [ 'TextColor','BGColor' ] },
            ],
        },
        {height:400}
    );

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