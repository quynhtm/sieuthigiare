<?php global $base_url;?>

<div class="main-view-post box-register">
	<div class="form-login form-request-password">
		<h1 class="title-head">Quên mật khẩu<span></h1>
		<form class="formForgotPass" method="post" action="<?php echo $base_url?>/quen-mat-khau.html" class="form-inline">
			
			<div class="restore-pass-text01">
				Nhập đầy đủ thông tin để nhận lại mật khẩu mới. Bạn sẽ được hệ thống gửi một thư với các chỉ dẫn để phục hồi mật khẩu.
			</div>

			<div class="form-group">
				<label class="control-label">Tên đăng nhập shop<span>(*)</span></label>
				<input type="text" id="user_shop" class="form-control" name="user_shop" value="<?php if(isset($user_shop)){ echo $user_shop; } ?>">
			</div>
			<div class="form-group">
				<label class="control-label">Email đăng ký shop<span>(*)</span></label>
				<input type="text" id="email_shop" class="form-control" name="email_shop" value="<?php if(isset($shop_email)){ echo $shop_email; } ?>">
			</div>
			<input type="hidden" name="txtFormForgotPass" id="txtFormForgotPass" value="txtFormForgotPass"/>
			<button type="submit" id="submitForgotPass" class="btn btn-primary">Nhận mật khẩu mới</button>
		</form>
		
	</div>
</div>