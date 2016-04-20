<?php global $base_url;?>
<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="main-view-post box-register">
				<div class="wrap-main-view">
					<h1 class="title-head">Đăng ký / <span>Đăng nhập</span></h1>
					<div class="view-content-static">
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
								<div class="login-other">
									<div class="title-login-other">Đăng nhập</div>
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
									</form>
								</div>
							</div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
								<div class="title-login-me">Đăng ký mở shop trên sieuthigiare.vn</div>
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
											<span class="checkbox-note">Tôi đã xem và đồng ý với chính sách bảo mật của sieuthigiare.vn</span>
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
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>