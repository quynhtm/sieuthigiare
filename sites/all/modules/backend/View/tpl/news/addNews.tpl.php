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
                 <label for="textName" class="control-label marginTop_15">Ảnh đại diện</label>
                 <div class="col-lg-8">
                     <a href="javascript:;"class="btn btn-primary" onclick="Common_admin.uploadMultipleImages(1);">Upload ảnh </a>
                 </div>
            </div>
            <!--hien thi anh-->
            <?php if(isset($arrItem->news_image_other)){?>
            <ul id="sys_drag_sort" class="ul_drag_sort">
                <?php 
                    if($arrItem->news_image_other != ''){
                        $list_news_image_other = unserialize($arrItem->news_image_other);
                        foreach($list_news_image_other as $k=>$v){      
                ?>
                <li id="sys_div_img_other_<?php echo $k ?>">
                    <div class="div_img_upload">
                        <img src="<?php echo $base_url.'/uploads/news/'.$arrItem->news_id.'/'.$v?>" height="80" width="80">
                        <input type="hidden" id="sys_img_other_<?php echo $k ?>" name="img_other[]" value="<?php echo $v ?>" class="sys_img_other">
                        <div class='clear'></div>
                        <input type="radio" id="chẹcked_image_<?php echo $k ?>" name="chẹcked_image" value="<?php echo $k ?>" onclick="Common_admin.checkedImage('<?php echo $v ?>','<?php echo $k ?>');">
                        <label for="chẹcked_image_{$key}" style='font-weight:normal'>Ảnh đại diện</label>
                        <br/><a href="javascript:void(0);" id="sys_delete_img_other_<?php echo $k ?>"onclick="Common_admin.removeImage('<?php echo $k ?>','<?php if(isset($arrItem->news_id)){ echo $arrItem->news_id; } ?>','<?php echo $v ?>','1');">Xóa ảnh</a>
                        <span style="display: none"><b><?php echo $k ?></b></span>
                    </div>
                </li>
                <?php 
                    } 
                        } 
                ?>
            </ul>
            <input name="list1SortOrder" id ='list1SortOrder' type="hidden" />
            <?php } ?>
            <!--ket thuc hien thi anh-->    
            <div class="control-group">
                <label class="control-label">Mô tả ngắn</label>
                <div class="controls">
                    <textarea name="news_desc_sort"><?php if(isset($arrItem->news_desc_sort)){ echo $arrItem->news_desc_sort; } ?></textarea>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Nội dung</label>
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
CKEDITOR.replace('news_desc_sort');
CKEDITOR.replace('news_content');
</script>