<?php global $base_url;?>

<div class="main-view-post box-register">
	<div class="form-send-register">
		<h1 class="title-head">Đăng ký mở gian hàng <span>/</span> <a href="<?php echo $base_url.'/dang-nhap.html' ?>" class="link-tab" rel="nofollow" >Đăng nhập</a></h1>
		<form class="formSendRegister" method="post" action="<?php echo $base_url?>/dang-ky.html" class="form-inline">
			<div class="form-left-reg">
				<div class="form-group">
					<label class="control-label">Tên đăng nhập<span>(*)</span></label>
					<input type="text" id="user_shop" class="form-control" name="user_shop">
				</div>
				<div class="form-group">
					<label class="control-label">Mật khẩu<span>(*)</span></label>
					<input type="password" id="user_password" class="form-control" name="user_password">
				</div>
				<div class="form-group">
					<label class="control-label">Nhập lại mật khẩu<span>(*)</span></label>
					<input type="password" id="rep_user_password" class="form-control" name="rep_user_password">
				</div>
			</div>
			<div class="form-right-reg">
				<div class="form-group">
					<label class="control-label">Số điện thoại<span>(*)</span></label>
					<input type="text" id="shop_phone" name="shop_phone" class="form-control">
				</div>
				<div class="form-group">
					<label class="control-label">Email<span>(*)</span></label>
					<input type="text" id="shop_email" name="shop_email" class="form-control">
				</div>
				<div class="form-group">
					<label class="control-label">Tỉnh/thành<span>(*)</span></label>
					<select id="shop_province" name="shop_province" class="form-control">
						<?php foreach ($listProvices as $k => $v) { ?>
						<option value="<?php echo $k ?>"><?php echo $v ?></option>
						<?php } ?>
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="agree">
					<input type="checkbox" value="true" name="agree">
					<span class="checkbox-note">Tôi đã xem và đồng ý với chính sách bảo mật của shopcuatui.com.vn</span>
				</div>
			</div>
			<div class="form-group-action">
				<div class="list-action">
					<input type="hidden" name="txtFormNameRegister" id="txtFormNameRegister" value="txtFormNameRegister"/>
					<button type="submit" id="submitRegister" class="btn btn-primary">Đăng ký</button>
				</div>
			</div>
		</form>
	</div>
</div>