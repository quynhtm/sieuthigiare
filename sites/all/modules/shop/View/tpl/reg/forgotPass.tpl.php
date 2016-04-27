<?php global $base_url;?>

<div class="main-view-post box-register">
	<div class="form-login">
		<h1 class="title-head">Quên mật khẩu<span></h1>
		
		<form class="formForgotPass" method="post" action="<?php echo $base_url?>/quen-mat-khau.html" class="form-inline">
			<div class="form-group">
				<label class="control-label">Email cần khôi phục mật khẩu<span>(*)</span></label>
				<input type="text" id="email_shop" class="form-control" name="email_shop">
			</div>
			<input type="hidden" name="txtFormForgotPass" id="txtFormForgotPass" value="txtFormForgotPass"/>
			<button type="submit" id="submitForgotPass" class="btn btn-primary">Đăng nhập</button>
		</form>
		
	</div>
</div>