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
                <label class="control-label">Tên shop<span>*</span></label>
                <div class="controls">
                    <input type="text" name="shop_name" value="<?php if(isset($arrOneItem->shop_name)){ echo $arrOneItem->shop_name; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Tên đăng nhập<span>*</span></label>
                <div class="controls">
                    <input type="text" name="user_shop" value="<?php if(isset($arrOneItem->user_shop)){ echo $arrOneItem->user_shop; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Số điện thoại</label>
                <div class="controls">
                    <input type="text" name="shop_phone" value="<?php if(isset($arrOneItem->shop_phone)){ echo $arrOneItem->shop_phone; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Email</label>
                <div class="controls">
                    <input type="text" name="shop_email" value="<?php if(isset($arrOneItem->shop_email)){ echo $arrOneItem->shop_email; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Địa chỉ</label>
                <div class="controls">
                    <input type="text" name="shop_address" value="<?php if(isset($arrOneItem->shop_address)){ echo $arrOneItem->shop_address; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Giới hạn số sản phẩm</label>
                <div class="controls">
                    <input type="text" name="number_limit_product" value="<?php if(isset($arrOneItem->number_limit_product)){ echo $arrOneItem->number_limit_product; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Loại gian hàng</label>
                <div class="controls">
                    <select name="is_shop">
                        <option value="0" <?php if(isset($arrOneItem->is_shop) && $arrOneItem->is_shop == 0){ ?>selected="selected"<?php } ?>>Thường</option>
                        <option value="1" <?php if(isset($arrOneItem->is_shop) && $arrOneItem->is_shop == 1){ ?>selected="selected"<?php } ?>>Vip</option>
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Trạng thái</label>
                <div class="controls">
                    <select name="shop_status">
                        <option value="0" <?php if(isset($arrOneItem->shop_status) && $arrOneItem->shop_status == 0){ ?>selected="selected"<?php } ?>>Ẩn</option>
                        <option value="1" <?php if(isset($arrOneItem->shop_status) && $arrOneItem->shop_status == 1){ ?>selected="selected"<?php } ?>>Hiện</option>
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