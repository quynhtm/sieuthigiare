<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php echo (isset($item_id) && $item_id > 0) ? 'Sửa thông tin '.$title: t('Thêm thông tin '.$title);?></h5>
		</div>
	</div>
	<div class="page-content-box paddingTop30">
		 <form class="form-horizontal" name="txtForm" action="" method="post" enctype="multipart/form-data">
		 	
            <div class="control-group">
                <label class="control-label">Tên danh mục<span>*</span></label>
                <div class="controls">
                    <input type="text" class="form-control input-sm" name="category_name" value="<?php if(isset($arrItem->category_name)){ echo $arrItem->category_name; } ?>">
                </div>
            </div>

            <div class="control-group">
                 <label class="control-label">Danh mục cha<span>*</span></label>
                 <div class="controls">
                     <select class="form-control input-sm" name="category_parent_id">
                         <?php echo $optionCategoryParent;?>
                     </select>
                 </div>
             </div>
             <div class="control-group">
                 <label class="control-label">Vị trí danh mục</label>
                 <div class="controls">
                     <input type="text"class="form-control input-sm" name="category_order" value="<?php if(isset($arrItem->category_order)){ echo $arrItem->category_order; } ?>">
                 </div>
             </div>


             <div class="control-group">
                 <label class="control-label">Trạng thái</label>
                 <div class="controls">
                     <select class="form-control input-sm" name="category_status">
                         <?php echo $optionStatus;?>
                     </select>
                 </div>
             </div>

             <div class="control-group">
                 <label class="control-label">Hiện ở trang chủ</label>
                 <div class="controls">
                     <select class="form-control input-sm" name="category_content_front">
                         <?php echo $optionShowContent;?>
                     </select>
                 </div>
            </div>
            <div class="control-group">
                <label class="control-label">Vị trí trang chủ</label>
                <div class="controls">
                    <input type="text"class="form-control input-sm" name="category_content_front_order" value="<?php if(isset($arrItem->category_content_front_order)){ echo $arrItem->category_content_front_order; } ?>">
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