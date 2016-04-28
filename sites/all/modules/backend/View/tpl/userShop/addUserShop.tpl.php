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
                    <input type="text" name="shop_name" value="<?php if(isset($user_shop->shop_name)){ echo $user_shop->shop_name; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Tên đăng nhập<span>*</span></label>
                <div class="controls">
                    <input type="text" name="user_shop" readonly value="<?php if(isset($user_shop->user_shop)){ echo $user_shop->user_shop; } ?>">
                </div>
            </div>
             <div class="control-group">
                <label class="control-label">Đổi mật khẩu - nếu có</label>
                <div class="controls">
                    <input type="password" name="user_password_edit" value="">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Số điện thoại</label>
                <div class="controls">
                    <input type="text" name="shop_phone" value="<?php if(isset($user_shop->shop_phone)){ echo $user_shop->shop_phone; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Email</label>
                <div class="controls">
                    <input type="text" name="shop_email" value="<?php if(isset($user_shop->shop_email)){ echo $user_shop->shop_email; } ?>">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">Địa chỉ</label>
                <div class="controls">
                    <input type="text" name="shop_address" value="<?php if(isset($user_shop->shop_address)){ echo $user_shop->shop_address; } ?>">
                </div>
            </div>
             <div class="control-group">
                 <label class="control-label">Danh mục sản phẩm<span>(*)</span></label>
                 <div class="controls">
                     <select class="form-control input-sm" name="shop_category[]" multiple="multiple" style="height: 250px;">
                         <option value="-1">--Chọn danh mục đăng bán sản phẩm -- </option>
                         <?php
                         if(count($arrCategoryParent) >0){
                             foreach ($arrCategoryParent as $key => $text) {
                                 $input = '<option value="' . $key . '"';
                                 if (in_array($key, $arrShopCate)) {
                                     $input .= ' selected';
                                 }
                                 $input .= '>' . $text . '</option>';
                                 echo $input;
                             }
                         }
                         ?>
                     </select>
                 </div>
             </div>
            <div class="control-group">
                <label class="control-label">Giới hạn số sản phẩm</label>
                <div class="controls"><select class="form-control input-sm" name="number_limit_product"><?php echo $optionNumberLimitProduct;?></select></div>
            </div>

             <div class="control-group">
                <label class="control-label">Loại gian hàng</label>
                <div class="controls"><select class="form-control input-sm" name="is_shop"><?php echo $optionIsShop;?></select></div>
            </div>
            <div class="control-group">
                <label class="control-label">Trạng thái</label>
                <div class="controls"><select class="form-control input-sm" name="shop_status"><?php echo $optionStatus;?></select></div>
            </div>
            <div class="control-group">
                <label class="control-label">Chính sách giao nhận</label>
                <div class="controls"><textarea id="shop_transfer" name="shop_transfer" class="form-control input-sm" cols="30" rows="10"><?php if(isset($user_shop->shop_transfer)) { echo $user_shop->shop_transfer; } ?></textarea></div>
            </div>
            <div class="control-group">
                <label class="control-label">Giới thiệu của shop</label>
                <div class="controls"><textarea id="shop_about" name="shop_about" class="form-control input-sm" cols="30" rows="10"><?php if(isset($user_shop->shop_about)) { echo $user_shop->shop_about; } ?></textarea></div>
            </div>

            <div class="form-actions">
                <input type="hidden" value="txt-form-post" name="txt-form-post">
				<button type="submit" name="txtSubmit" id="buttonSubmit" class="btn btn-primary">Lưu</button>
                <button type="reset" class="btn">Bỏ qua</button>
            </div>
		 </form>
	</div>
</div>

<script type="text/javascript">
    CKEDITOR.replace(
        'shop_about',
        {
            toolbar: [
                { name: 'document',    items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
                { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
                { name: 'colors',      items : [ 'TextColor','BGColor' ] },
            ],
        },
        {height:400}
    );
    CKEDITOR.replace(
        'shop_transfer',
        {
            toolbar: [
                { name: 'document',    items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
                { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
                { name: 'colors',      items : [ 'TextColor','BGColor' ] },
            ],
        },
        {height:400}
    );
</script>