<?php
	global $base_url;
	$param = arg();
?>
<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php if($param[2]=='add')echo 'Thêm bài mới';else echo 'Sửa bài viết';?></h5>
		</div>
	</div>
	<div class="page-content-box">
		 <form class="form-horizontal" name="txtForm" action="" method="post" enctype="multipart/form-data">
		 	
            <div class="control-group">
                <label class="control-label">Tiêu đề<span>*</span></label>
                <div class="controls">
                    <input type="text" name="title" value="<?php if(isset($arrOneItem->title)){ echo $arrOneItem->title; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Keyword<span>*</span></label>
                <div class="controls">
                    <input type="text" name="keyword" value="<?php if(isset($arrOneItem->keyword)){ echo $arrOneItem->keyword; } ?>">
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">Mô tả</label>
                <div class="controls">
                    <textarea name="intro"><?php if(isset($arrOneItem->intro)){ echo $arrOneItem->intro; } ?></textarea>
                </div>
            </div>
            
            <div class="control-group">
                <label class="control-label">Nội dung</label>
                <div class="controls">
                    <textarea name="content"><?php if(isset($arrOneItem->content)){ echo $arrOneItem->content; } ?></textarea>
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
            
            <div class="control-group">
                <label class="control-label">Meta title</label>
                <div class="controls">
                    <textarea name="meta_title"><?php if(isset($arrOneItem->meta_title)){ echo $arrOneItem->meta_title; } ?></textarea>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Meta keywords</label>
                <div class="controls">
                    <textarea name="meta_keywords"><?php if(isset($arrOneItem->meta_keywords)){ echo $arrOneItem->meta_keywords; } ?></textarea>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Meta description</label>
                <div class="controls">
                    <textarea name="meta_description" ><?php if(isset($arrOneItem->meta_description)){ echo $arrOneItem->meta_description; } ?></textarea>
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
<script>
    CKEDITOR.replace('content');
</script>