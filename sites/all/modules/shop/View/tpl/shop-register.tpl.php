<?php global $base_url;?>
<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="main-view-post box-register">
				<div class="wrap-main-view">
					<h1 class="title-head"><a href="<?php echo $base_url?>/dang-ky.html" title="Đăng ký">Đăng ký</a></h1>
					<div class="view-content-static">
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
								<div class="login-other">
									<div class="title-login-other">Đăng nhập nhanh với</div>
									<a class="btn-face" href="javascript:;"></a>
									<a class="btn-google" href="javascript:;"></a>
									<a class="btn-yahoo" href="javascript:;"></a>
								</div>
							</div>
							<div class="col-lg-8 col-md-8 col-sm-8 col-xs-8">
								<div class="title-login-me">Đăng ký tại sieuthigiare.vn</div>
								<form class="formSendRegister" method="post" action="" class="form-inline">
									<div class="form-left-reg">
										<div class="form-group">
											<label class="control-label">Tên đăng nhập<span>(*)</span></label>
											<input type="text" id="user_name" class="form-control" name="user_name">
										</div>
										<div class="form-group">
											<label class="control-label">Mật khẩu<span>(*)</span></label>
											<input type="password" id="password" class="form-control" name="password">
										</div>
										<div class="form-group">
											<label class="control-label">Nhập lại mật khẩu<span>(*)</span></label>
											<input type="password" id="rep_password" class="form-control" name="rep_password">
										</div>
										<div class="form-group">
											<div class="agree">
												<input type="checkbox" value="true">
												<span class="checkbox-note">Tôi đã xem và đồng ý với chính sách bảo mật của sieuthigiare.vn</span>
											</div>
										</div>
									</div>
									<div class="form-right-reg">
										<div class="form-group">
											<label class="control-label">Tên gian hàng<span>(*)</span></label>
											<input type="text" id="name_alias" class="form-control" name="name_alias">
										</div>
										
										<div class="form-group">
											<label class="control-label">Số điện thoại<span>(*)</span></label>
											<input type="text" id="phone" name="phone" class="form-control">
										</div>
										<div class="form-group">
											<label class="control-label">Email<span>(*)</span></label>
											<input type="text" id="email" name="email" class="form-control">
										</div>
										<div class="form-group">
											<label class="control-label">Tỉnh/thành<span>(*)</span></label>
											<select id="provice" name="provice" class="form-control">
												<?php foreach ($listProvices as $v) { ?>
												<option value="<?php echo $v->id ?>"><?php echo $v->title ?></option>
												<?php } ?>
											</select>
										</div>
									</div>
									<div class="form-group-action">
										<input type="hidden" name="txtFormNameRegister" id="txtFormNameRegister" value="txtFormNameRegister"/>
										<button type="submit" id="submitRegister" class="btn btn-primary">Đăng ký</button>
										<button type="reset" id="resetRegister" class="btn btn-default">Làm lại</button>

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