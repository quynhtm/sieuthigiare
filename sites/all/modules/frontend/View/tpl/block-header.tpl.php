<?php 
	global $base_url, $user_shop;
	$keyword = isset($_GET['keyword']) ? trim($_GET['keyword']) : '';
?>
<div class="link-top-head">
	<div class="container">
		<div class="box-login">
			<a href="' ?>" class="link-normal">Hướng dẫn mua hàng</a>
			<?php if($user_shop->shop_id == 0){?>
			<a href="<?php echo $base_url.'/dang-nhap.html' ?>" class="btnLog" rel="nofollow" >Đăng nhập</a>
			<a href="<?php echo $base_url.'/dang-ky.html' ?>" class="btnLog" rel="nofollow" >Đăng ký</a>
			<?php }else{ ?>
			<a href="<?php echo $base_url.'/quan-ly-gian-hang.html' ?>" rel="nofollow" class="btnLog">Quản lý gian hàng</a>
			<a href="<?php echo $base_url.'/thoat.html' ?>" rel="nofollow" class="btnLog">Thoát</a>
			<?php } ?>
		</div>
	</div>
</div>
<div class="center-header">
 	<div class="container">
	    <div class="top-header">	
	    	<div class="navbar-header">
	      		<?php if(drupal_is_front_page()){?>
	      		<h1 id="logo"><a href="<?php echo $base_url ?>"><img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/logo.png" alt="Sản phẩm rẻ đẹp - San pham re dep" /></a></h1>
	      		<?php }else{ ?>
	      		<span id="logo"><a href="<?php echo $base_url ?>"><img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/logo.png" alt="Sản phẩm rẻ đẹp - San pham re dep" /></a></span>
	      		<?php } ?>
	    	</div>
		    <div class="box-top-header-right">
		    	<div class="search-top-center">
		    		<div class="box-search">
						<form name="frmsearch" id="frmsearch" class="frmsearch" method="GET" action="<?php echo $base_url?>/tim-kiem">
							<input type="text" name="keyword" class="keyword" value="<?php echo $keyword ?>" autocomplete="off"  placeholder="Nhập tên hoặc mã sản phẩm..."/>
							<input type="submit" class="btn-search" value="Tìm kiếm"/>
						</form>
					</div>
					<div class="guide-link">Gợi ý tìm kiếm:
						<a href="" title="">Giày nam</a>,
						<a href="" title="">Áo sơ mi nữ</a>,
						<a href="" title="">Túi xách nữ</a>,
						<a href="" title="">Áo thun nam</a>,...
					</div>
					<div class="phone-call-num">
						<span class="icon-phone-head"><?php echo Utility::keyword('SITE_HOTLINE')?></span>
						<span class="time-work">(Thời gian làm việc: 8:00 - 17:30 các ngày trong tuần)</span>
					</div>
		    	</div>
				<a href="<?php echo $base_url ?>/gio-hang.html" title="Giỏ hàng">
				<div class="box-shop-cart">
					<span class="icon-shop"></span>
					<span class="num-in-cart">Giỏ hàng</span>
				</div>
				</a>
		    </div>
		</div>
	</div>
</div>
	
