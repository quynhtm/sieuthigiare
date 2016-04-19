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
	    	<?php if(drupal_is_front_page()){?>
      		<h1 id="logo"><a href="<?php echo $base_url ?>"><img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/logo.png" alt="Sản phẩm rẻ đẹp - San pham re dep" /></a></h1>
      		<?php }else{ ?>
      		<span id="logo"><a href="<?php echo $base_url ?>"><img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/logo.png" alt="Sản phẩm rẻ đẹp - San pham re dep" /></a></span>
      		<?php } ?>
		    <div class="box-top-header-right">
		    	<div class="search-top-center">
		    		<div class="box-search">
						<form name="frmsearch" id="frmsearch" class="frmsearch" method="GET" action="<?php echo $base_url?>/tim-kiem">
							<input type="text" name="keyword" class="keyword" value="<?php echo $keyword ?>" autocomplete="off"  placeholder="Nhập tên hoặc mã sản phẩm..."/>
							<input type="submit" class="btn-search" value="Tìm kiếm"/>
						</form>
					</div>
		    	</div>
		    </div>
		</div>
		<div class="box-header-link">
			<div class="box-menu-title">
				<div class="title-cat-menu">
					<div class="icon-cat-title">
						<span class="ic-line"></span>
					    <span class="ic-line"></span>
					    <span class="ic-line"></span>
					</div>
				    Danh mục
				    <i class="right-down icon-angle-down"></i>
				</div>
			</div>
		</div>
	</div>
</div>
