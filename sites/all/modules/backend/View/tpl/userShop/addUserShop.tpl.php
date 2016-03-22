<?php
	global $base_url;
	$param = arg();
?>
<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5>
				<?php 
					if($param[2]=='add')
						echo 'Thêm bài mới';
					else
						echo 'Sửa bài viết';
				?>
			</h5>
		</div>
	</div>
	<div class="page-content-box">
		 <form class="form-horizontal" name="txtForm" action="" method="post" enctype="multipart/form-data">
		 	
            <div class="control-group">
                <label class="control-label">Tên shop<span>*</span></label>
                <div class="controls">
                    <input type="text" name="name_shop" value="<?php if(isset($arrOneItem[0]->name_shop)){ echo $arrOneItem[0]->name_shop; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Tên đăng nhập<span>*</span></label>
                <div class="controls">
                    <input type="text" name="user_name" value="<?php if(isset($arrOneItem[0]->user_name)){ echo $arrOneItem[0]->user_name; } ?>">
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Trạng thái</label>
                <div class="controls">
                    <select name="status">
                        <option value="0" <?php if(isset($arrOneItem[0]->status) && $arrOneItem[0]->status == 0){ ?>selected="selected"<?php } ?>>Ẩn</option>
                        <option value="1" <?php if(isset($arrOneItem[0]->status) && $arrOneItem[0]->status == 1){ ?>selected="selected"<?php } ?>>Hiện</option>
                    </select>
                </div>
            </div>
        
            <div class="form-actions">
                <input type="hidden" value="txt-form-post" name="txt-form-post">
				<button type="submit" name="txtSubmit" id="buttonSubmit" class="btn btn-primary">Lưu</button>
                <button type="reset" class="btn">Bỏ qua</button>
            </div>
		 </form>
	</div>
</div>