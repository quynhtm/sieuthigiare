<?php global $base_url;?>

<div class="main-view-post box-register">
	<div class="form-login">
		<h1 class="title-head">Đăng nhập <span>/</span> <a href="<?php echo $base_url.'/dang-ky.html' ?>" class="link-tab" rel="nofollow" >Đăng ký mở gian hàng</a></h1>
		<!-- <a class="btn-face" href="javascript:;"></a>
		<a class="btn-google" href="javascript:;"></a>
		<a class="btn-yahoo" href="javascript:;"></a> -->
		<form class="formSendLogin" method="post" action="<?php echo $base_url?>/dang-nhap.html" class="form-inline">
			<div class="form-group">
				<label class="control-label">Tên đăng nhập<span>(*)</span></label>
				<input type="text" id="user_shop_login" class="form-control" name="user_shop_login">
			</div>
			<div class="form-group">
				<label class="control-label">Mật khẩu<span>(*)</span></label>
				<input type="password" id="password_shop_login" class="form-control" name="password_shop_login">
			</div>
			<input type="hidden" name="txtFormNameLogin" id="txtFormNameLogin" value="txtFormNameLogin"/>
			<button type="submit" id="submitLogin" class="btn btn-primary">Đăng nhập</button>
			<a class="forgotpass" href="<?php echo $base_url ?>/quen-mat-khau.html" rel="nofollow">Bạn quên mật khẩu?</a>
		</form>
	</div>
</div>