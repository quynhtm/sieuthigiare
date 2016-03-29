<?php 
	global $base_url, $user_shop;
?>
<div class="main-manager-shop">
	<div class="header">
		<?php require_once(DRUPAL_ROOT.'/'.path_to_theme().'/View/tpl/shopHeader.tpl.php') ?>
	</div>
	<div class="content">
		<div class="wrapp-shop">
			<div class="box-shop-search">
				<div class="title-box-shop-search">Đổi mật khẩu đăng nhập</div>
				<div class="content-box-shop-search">
					<form action="" method="post" id="frmEditPass" class="frmEditPass" name="frmEditPass">
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Tên đăng nhập<span>(*)</span></label>
								<div><input type="text" class="form-control input-sm" placeholder ="Tên đăng nhập" name="user_shop_login"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Mật khẩu<span>(*)</span></label>
								<div><input type="password" class="form-control input-sm" placeholder ="Mật khẩu" name="user_shop_password"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Nhập lại mật khẩu<span>(*)</span></label>
								<div><input type="password" class="form-control input-sm" placeholder ="Nhập lại mật khẩu" name="user_shop_rep_password"/></div>
							</div>
							<div class="form-group">
								<input type="hidden" name="frmEditPass" id="frmEditPass" value="frmEditPass"/>
								<button class="btn btn-primary" name="submit" value="1">Sửa</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>