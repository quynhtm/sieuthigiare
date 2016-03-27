<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php echo (isset($item_id) && $item_id > 0) ? 'Sửa thông tin '.$title: t('Thêm thông tin '.$title);?></h5>
		</div>
	</div>
	<div class="page-content-box paddingTop30">
		 <form class="form-horizontal" name="txtForm" action="" method="post" enctype="multipart/form-data">
		 	
            <div class="control-group">
                <label class="control-label">Tên tỉnh thành<span>*</span></label>
                <div class="controls">
                    <input type="text" class="form-control input-sm" name="province_name" value="<?php if(isset($arrItem->province_name)){ echo $arrItem->province_name; } ?>">
                </div>
            </div>

             <div class="control-group">
                <label class="control-label">Vị trí</label>
                <div class="controls">
                    <input type="text"class="form-control input-sm" name="province_position" value="<?php if(isset($arrItem->province_position)){ echo $arrItem->province_position; } ?>">
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Trạng thái</label>
                <div class="controls">
                    <select class="form-control input-sm" name="province_status">
                        <?php echo $optionStatus;?>
                    </select>
                </div>
            </div>
            <div class="form-actions">
                <input type="hidden" value="txt-form-post" name="txt-form-post">
				<button type="submit" name="txtSubmit" id="buttonSubmit" class="btn btn-primary">Lưu lại</button>
                <button type="reset" class="btn">Bỏ qua</button>
            </div>
		 </form>
	</div>
</div>