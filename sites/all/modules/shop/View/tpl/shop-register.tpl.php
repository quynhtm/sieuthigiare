<?php global $base_url;?>
<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="main-view-post">
				<div class="wrap-main-view">
					<h1 class="title-head"><a href="<?php echo $base_url?>/dang-ky.html" title="Đăng ký">Đắng ký gian hàng</a></h1>
					<div class="view-content-static">
						<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<form class="formSendRegister" method="post" action="" class="form-inline">
									<div class="form-group">
										<label class="control-label">Tên gian hàng<span>(*)</span></label>
										<input type="text" id="txtNameShop" class="form-control" name="txtNameShop" value="<?php if(isset($data_post['name_shop'])){ echo $data_post['name_shop']; } ?>">
									</div>
									<div class="form-group">
										<label class="control-label">Tên đăng nhập<span>(*)</span></label>
										<input type="text" id="txtName" class="form-control" name="txtName" value="<?php if(isset($data_post['name'])){ echo $data_post['name']; } ?>">
									</div>
									<div class="form-group">
										<label class="control-label">Mật khẩu<span>(*)</span></label>
										<input type="password" id="txtPass" class="form-control" name="txtPass" value="<?php if(isset($data_post['pass'])){ echo $data_post['pass']; } ?>">
									</div>
									<div class="form-group">
										<label class="control-label">Nhập lại mật khẩu<span>(*)</span></label>
										<input type="password" id="txtRePass" class="form-control" name="txtRePass">
									</div>
									<div class="form-group">
										<label class="control-label">Số điện thoại<span>(*)</span></label>
										<input type="text" id="txtMobile" name="txtMobile" class="form-control" value="<?php if(isset($data_post['phone'])){ echo $data_post['phone']; } ?>">
									</div>
									<div class="form-group">
										<label class="control-label">Email<span>(*)</span></label>
										<input type="text" id="txtEmail" name="txtEmail" class="form-control" value="<?php if(isset($data_post['name_shop'])){ echo $data_post['name_shop']; } ?>">
									</div>
									<div class="form-group">
										<label class="control-label">Tỉnh/thành<span>(*)</span></label>
										<select id="txtProvice" name="txtProvice" class="form-control">
											<option value="1">Hà Nội</option>
										</select>
									</div>
									<input type="hidden" name="txtFormNameRegister" id="txtFormNameRegister" value="txtFormNameRegister"/>
									<button type="submit" id="submitRegister" class="btn btn-primary">Đăng ký</button>
									<button type="reset" id="resetRegister" class="btn btn-default">Làm lại</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>