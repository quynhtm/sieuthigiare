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
                <label class="control-label">Tiêu đề<span>*</span></label>
                <div class="controls">
                    <input type="text" name="title" value="<?php if(isset($arrOneItem[0]->title)){ echo $arrOneItem[0]->title; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Keyword<span>*</span></label>
                <div class="controls">
                    <input type="text" name="keyword" value="<?php if(isset($arrOneItem[0]->keyword)){ echo $arrOneItem[0]->keyword; } ?>">
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Mô tả</label>
                <div class="controls">
                    <textarea name="intro"><?php if(isset($arrOneItem[0]->intro)){ echo $arrOneItem[0]->intro; } ?></textarea>
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label">Nội dung</label>
                <div class="controls">
                    <textarea name="content"><?php if(isset($arrOneItem[0]->content)){ echo $arrOneItem[0]->content; } ?></textarea>
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
            
            <div class="control-group">
                <label class="control-label">Meta title</label>
                <div class="controls">
                    <textarea name="meta_title"><?php if(isset($arrOneItem[0]->meta_title)){ echo $arrOneItem[0]->meta_title; } ?></textarea>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Meta keywords</label>
                <div class="controls">
                    <textarea name="meta_keywords"><?php if(isset($arrOneItem[0]->meta_keywords)){ echo $arrOneItem[0]->meta_keywords; } ?></textarea>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Meta description</label>
                <div class="controls">
                    <textarea name="meta_description" ><?php if(isset($arrOneItem[0]->meta_description)){ echo $arrOneItem[0]->meta_description; } ?></textarea>
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