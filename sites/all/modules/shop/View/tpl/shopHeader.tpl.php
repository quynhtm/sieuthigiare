<?php 
	global $base_url, $user_shop;
?>
<div class="wrapp-shop">	
	<div class="left-head-shop">
		<i class="icon-dashboard"></i>
		<div class="navigator">
			<ul>
				<li><a href="<?php echo $base_url ?>">Trang chủ</a></li>
				<li><a href="<?php echo $base_url.'/gian-hang/'.$user_shop->shop_id.'/'.Stdio::pregReplaceStringAlias($user_shop->shop_name).'.html' ?>">Trang chủ shop</a></li>
				<li><a href="<?php echo $base_url.'/quan-ly-gian-hang.html'?>">Quản lý sản phẩm</a></li>
			</ul>
		</div>
	</div>
	<div class="right-head-shop">
		<?php 
			if($user_shop->shop_id != 0){
				echo 'Chào: '.ucfirst($user_shop->user_shop);
		 	} 
		 ?>
		<i class="icon-caret-down"></i>
		<div class="panel-user-shop">
			<ul>
				<li><a rel="nofollow" href="<?php echo $base_url ?>/sua-thong-tin-gian-hang.html">Sửa thông tin gian hàng</a></li>
				<li><a rel="nofollow" href="<?php echo $base_url ?>/doi-mat-khau.html">Đổi mật khẩu</a></li>
				<li><a rel="nofollow" href="<?php echo $base_url?>/thoat.html">Thoát</a></li>
			</ul>
		</div>
	</div>
</div>