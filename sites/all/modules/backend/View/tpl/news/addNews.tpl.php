<?php global $base_url ?>
<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php echo (isset($item_id) && $item_id > 0) ? 'Sửa thông tin '.$title: t('Thêm thông tin '.$title);?></h5>
		</div>
	</div>
	<div class="page-content-box paddingTop30">
		 <form class="form-horizontal" name="txtForm" action="" method="post" enctype="multipart/form-data">
		 	
             <div class="control-group">
                <label class="control-label">Title tin tức<span>*</span></label>
                <div class="controls">
                    <input type="text" class="form-control input-sm" name="news_title" value="<?php if(isset($arrItem->news_title)){ echo $arrItem->news_title; } ?>">
                </div>
             </div>
             <div class="control-group">
                 <label class="control-label">Danh mục tin</label>
                 <div class="controls">
                     <select class="form-control input-sm" name="news_category">
                         <?php echo $optionCategory;?>
                     </select>
                 </div>
             </div>
             <div class="control-group">
                 <label class="control-label">Loại tin</label>
                 <div class="controls">
                     <select class="form-control input-sm" name="news_type">
                         <?php echo $optionType;?>
                     </select>
                 </div>
             </div>

             <div class="control-group">
                 <label for="textName" class="control-label marginTop_15">Ảnh đại diện</label>
                 <div class="col-lg-8">
                     <a href="javascript:;"class="btn btn-primary" onclick="Common_admin.uploadMultipleImages(1);">Upload ảnh </a>
                     <input name="image_primary" type="hidden" id="image_primary" value="<?php if(isset($arrItem->news_image)){ echo $arrItem->news_image; } ?>">
                 </div>
            </div>
            <!--hien thi anh-->
            <ul id="sys_drag_sort" class="ul_drag_sort">
            <?php if(isset($arrItem->news_image_other)){
                $key_primary = -1;
                $image_primary = $arrItem->news_image;
                ?>
                    <?php
                        if(trim($arrItem->news_image_other) != ''){
                            $list_news_image_other = unserialize($arrItem->news_image_other);
                            foreach($list_news_image_other as $k=>$v){ ?>
                                <li id="sys_div_img_other_<?php echo $k ?>">
                                    <div class="div_img_upload">
                                        <img src="<?php echo $base_url.'/uploads/news/'.$arrItem->news_id.'/'.$v?>" height="80" width="80">
                                        <input type="hidden" id="sys_img_other_<?php echo $k ?>" name="img_other[]" value="<?php echo $v ?>" class="sys_img_other">
                                        <div class='clear'></div>
                                        <input type="radio" id="chẹcked_image_<?php echo $k ?>" name="chẹcked_image" value="<?php echo $k ?>"
                                               <?php if (isset($image_primary) && ($image_primary == $v)){ ?> checked="checked" <?php }?>
                                        onclick="Common_admin.checkedImage('<?php echo $v ?>','<?php echo $k ?>');">
                                        <label for="chẹcked_image_<?php echo $k ?>" style='font-weight:normal'>Ảnh đại diện</label>
                                        <br/><a href="javascript:void(0);" id="sys_delete_img_other_<?php echo $k ?>"onclick="Common_admin.removeImage('<?php echo $k ?>','<?php if(isset($arrItem->news_id)){ echo $arrItem->news_id; } ?>','<?php echo $v ?>','1');">Xóa ảnh</a>
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

            <div class="control-group">
                <label class="control-label">Mô tả ngắn</label>
                <div class="controls">
                    <textarea name="news_desc_sort"><?php if(isset($arrItem->news_desc_sort)){ echo $arrItem->news_desc_sort; } ?></textarea>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Nội dung</label>
                <div class="controls"><button type="button" onclick="Common_admin.insertImageContent(1)" class="btn btn-primary">Chèn ảnh vào nội dung</button></div>
                <div class="controls">
                    <textarea name="news_content"><?php if(isset($arrItem->news_content)){ echo $arrItem->news_content; } ?></textarea>
                </div>
            </div>
        
            <div class="control-group">
                <label class="control-label">Trạng thái</label>
                <div class="controls">
                    <select class="form-control input-sm" name="news_status">
                        <?php echo $optionStatus;?>
                    </select>
                </div>
            </div>
            <div class="form-actions">
                <input type="hidden" id="id_hiden" name="id" value="<?php if(isset($arrItem->news_id)){ echo $arrItem->news_id; } ?>"/>
                <input type="hidden" value="txt-form-post" name="txt-form-post">
				<button type="submit" name="txtSubmit" id="buttonSubmit" class="btn btn-primary">Lưu lại</button>
                <button type="reset" class="btn">Bỏ qua</button>
            </div>
		 </form>
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

<script>
    CKEDITOR.replace('news_content', {height:800});
</script>

<script type="text/javascript">
    //kéo thả ảnh
   jQuery("#sys_drag_sort").dragsort({ dragSelector: "div", dragBetween: true, dragEnd: saveOrder });
    function saveOrder() {
        var data = jQuery("#sys_drag_sort li div span").map(function() { return jQuery(this).children().html(); }).get();
        jQuery("input[name=list1SortOrder]").val(data.join(","));
    };
    function insertImgContent(src){
        CKEDITOR.instances.news_content.insertHtml('<img src="'+src+'"/>');
    }
</script>