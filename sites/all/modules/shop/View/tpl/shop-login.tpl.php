<?php global $base_url;?>
<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="main-view-post">
				<div class="wrap-main-view">
					<h1 class="title-head"><a href="<?php echo $base_url?>/dang-nhap.html" title="Đăng ký">Đắng nhập gian hàng</a></h1>
					<div class="view-content-static">
						<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<form class="formSendRegister" method="post" action="" class="form-inline">
									<div class="form-group">
										<label class="control-label">Tên đăng nhập<span>(*)</span></label>
										<input type="text" id="txtName" class="form-control" name="txtName" value="<?php if(isset($data_post['name'])){ echo $data_post['name']; } ?>">
									</div>
									<div class="form-group">
										<label class="control-label">Mật khẩu<span>(*)</span></label>
										<input type="password" id="txtPass" class="form-control" name="txtPass" value="<?php if(isset($data_post['pass'])){ echo $data_post['pass']; } ?>">
									</div>
									<input type="hidden" name="txtFormNameLogin" id="txtFormNameLogin" value="txtFormNameLogin"/>
									<button type="submit" id="submitLogin" class="btn btn-primary">Đăng nhập</button>
									<button type="reset" id="resetLogin" class="btn btn-default">Làm lại</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>