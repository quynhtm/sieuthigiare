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
                <label class="control-label">Name<span>*</span></label>
                <div class="controls">
                    <input type="text" name="title" value="<?php if(isset($arrOneItem->title)){ echo $arrOneItem->title; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Yahoo</label>
                <div class="controls">
                    <input type="text" name="yahoo" value="<?php if(isset($arrOneItem->yahoo)){ echo $arrOneItem->yahoo; } ?>">
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Skyper</label>
                <div class="controls">
                    <input type="text" name="skyper" value="<?php if(isset($arrOneItem->skyper)){ echo $arrOneItem->skyper; } ?>">
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label">Mobile</label>
                <div class="controls">
                    <input type="text" name="mobile" value="<?php if(isset($arrOneItem->mobile)){ echo $arrOneItem->mobile; } ?>">
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label">Email</label>
                <div class="controls">
                    <input type="text" name="email" value="<?php if(isset($arrOneItem->email)){ echo $arrOneItem->email; } ?>">
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Số thứ tự</label>
                <div class="controls">
                    <input type="text" name="order_no" value="<?php if(isset($arrOneItem->order_no)){ echo $arrOneItem->order_no; } ?>">
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Trạng thái</label>
                <div class="controls">
                    <select name="status">
                        <option value="0" <?php if(isset($arrOneItem->status) && $arrOneItem->status == 0){ ?>selected="selected"<?php } ?>>Ẩn</option>
                        <option value="1" <?php if(isset($arrOneItem->status) && $arrOneItem->status == 1){ ?>selected="selected"<?php } ?>>Hiện</option>
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