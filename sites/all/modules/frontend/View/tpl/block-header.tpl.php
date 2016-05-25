<?php 
	global $base_url, $user_shop;
?>
<div class="link-top-head">
	<div class="container">
		<div class="box-login">
			<?php if(isset($user_shop->shop_id) && $user_shop->shop_id == 0){?>
			<a href="<?php echo $base_url.'/dang-ky.html' ?>" class="btnLog" rel="nofollow"><i class="icon-hand-right"></i> Mở Shop</a>
			<a href="<?php echo $base_url.'/dang-nhap.html' ?>" class="btnLog" rel="nofollow"><i class="icon-signin"></i> Vào Shop</a>
			<?php }else{ ?>
			<a href="<?php echo $base_url.'/quan-ly-gian-hang.html' ?>" rel="nofollow" class="btnLog"><i class="icon-cog"></i> Quản lý gian hàng</a>
			<a href="<?php echo $base_url.'/thoat.html' ?>" rel="nofollow" class="btnLog"><i class="icon-signout"></i> Thoát</a>
			<?php } ?>
		</div>
	</div>
</div>
<div class="center-header">
 	<div class="container">
	    <div class="top-header">	
	    	<?php if(drupal_is_front_page()){?>
      		<h1 id="logo"><a href="<?php echo $base_url ?>"><img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/logo.png" alt="ShopCuaTui" /></a></h1>
      		<?php }else{ ?>
      		<span id="logo"><a href="<?php echo $base_url ?>"><img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/logo.png" alt="ShopCuaTui" /></a></span>
      		<?php } ?>
		    <div class="box-top-header-right">
		    	<div class="search-top-center">
		    		<div class="box-search">
						<form name="frmsearch" id="frmsearch" class="frmsearch" method="GET" action="<?php echo $base_url?>/tim-kiem.html">
							<select name="provices_id" class="provices_id">
								<option value="0">Chọn tỉnh thành</option>
								<?php echo $optionProvices ?>
							</select>
							<select name="category_id" class="category_id">
								<option value="0">Chọn danh mục sản phẩm</option>
								<?php foreach($listCategory as $key => $cat){?>
								<option value="<?php echo $key ?>" <?php if($category_id == $key){ ?>selected="selected"<?php } ?>><?php echo $cat ?></option>
								<?php } ?>
							</select>
							<input type="submit" class="btn-search" value="Tìm kiếm"/>
						</form>
					</div>
		    	</div>
		    	<div class="box-right-focus">
		    		<div class="support-contact">
						<i class="icon-phone"></i> Hỗ trợ
						<i class="idrop"></i>

						<div class="box-hover-support-contact">
							<div class="top-arrow-box"><i></i></div>
							<div class="custommer">
								<b>Dành cho khách hàng:</b> Để mua sản phẩm bạn vui lòng liên hệ theo số điện thoại trong tin đăng của các shop.
							</div>
							<div class="support-user-shop">
								<b>Dành cho chủ shop:</b>
								<ul>
									<li>
										<i></i>
										CSKH: <b><?php echo PHONE_CARE ?></b>
									</li>
									<li>
										<i></i>
										Đăng ký quảng cáo: <b>094.11.99.656</b>
									</li>
									<li>
										<i></i>
										Hỗ trợ trực tuyến:
										<a title="Hỗ trợ trực tuyến qua Skype!" href="skype:nguyenduypt86?chat" class="chat-sky" rel="nofollow"></a>
										<a title="Hỗ trợ trực tuyến qua Skype!" href="skype:mercury_0206?chat" class="chat-sky" rel="nofollow"></a>
										
									</li>
								</ul>
							</div>
						</div>
					</div>
					<?php if($numCart > 0){?>
					<a href="<?php echo $base_url ?>/gio-hang.html" title="Giỏ hàng" rel="nofollow">
			    		<div class="shopping-cart">
			    			<span class="num-item"><?php echo $numCart ?></span>
			    		</div>
			    	</a>
		    		<?php } ?>
		    	</div>
		    </div>
		</div>
		<div class="box-header-link">
			<div class="box-menu-title <?php if(!drupal_is_front_page()){ echo 'box-menu-hover'; }?>">
				<div class="title-cat-menu">
					<div class="icon-cat-title">
						<span class="ic-line"></span>
					    <span class="ic-line"></span>
					    <span class="ic-line"></span>
					</div>
				    Danh mục sản phẩm
				    <i class="right-down icon-angle-down"></i>
				</div>
				<?php if(!empty($arrCategory)){?>
				<div class="content-box-menu header-menu-other">
					<ul>
						<?php 
						$i=0;
						foreach($arrCategory as $cat){
						$i++;
						if($i<=11){
						?>
						<?php if(isset($cat['category_parent_name']) && $cat['category_parent_name'] != ''){ ?>
						<li>
							<a href="<?php echo FunctionLib::buildLinkCategory(0, 0, $cat['category_id'], $cat['category_parent_name']) ?>" title="<?php echo $cat['category_parent_name'] ?>"><?php echo $cat['category_parent_name'] ?></a>
							<?php if(isset($cat['arrSubCategory']) && !empty($cat['arrSubCategory'])) {?>
							<?php 	
								$url = '';
								if($cat['category_image_background'] != ''){
								$url = 'url('.FunctionLib::getThumbImage($cat['category_image_background'],$cat['category_id'],FOLDER_CATEGORY,735,428).') no-repeat bottom right';
							} ?>
							<div class="list-subcat" style="background: #fff <?php echo $url ?>">
								<?php
									$list_ul = array_chunk($cat['arrSubCategory'], 10);
								?>
								<?php foreach($list_ul as $ul){?>
								<ul>
									<?php foreach($ul as $sub){ ?>
									<li><a href="<?php echo FunctionLib::buildLinkCategory(0, 0, $sub['category_id'], $sub['category_name']) ?>" title="<?php echo $sub['category_name'] ?>"><?php echo $sub['category_name'] ?></a></li>
									<?php } ?>
								</ul>
								<?php } ?>
							</div>
							<?php } ?>
						</li>
						<?php } ?>
						<?php } ?>
						<?php } ?>
					</ul>
				</div>
				<?php } ?>
			</div>
			<div class="list-product-new">
				<i class="icon-list-new"></i> <a href="<?php echo $base_url ?>/san-pham-moi.html" title="Sản phẩm mới">Sản phẩm mới</a>
			</div>
			<div class="list-giai-tri">
				<i class="icon-bullhorn"></i> <a href="<?php echo $base_url ?>/tin-tuc-chung.html" title="Tin tức">Tin tức</a>
			</div>
			<div class="list-giai-tri">
				<i class="icon-play-circle"></i> <a href="<?php echo $base_url ?>/video.html" title="Video">Video</a>
			</div>
			<!-- <div class="desc-price-day">
				<i class="icon-star-empty"></i> <a href="#" title="Giảm giá mỗi ngày">Giảm giá mỗi ngày</a>
			</div> -->
			<div class="right-ultity">
				<div class="shop-create">
					<i></i>
					<b>Tạo shop online:</b><br>
					<span>Tiện ích - Đơn giản - Dễ dùng</span>
				</div>
				<div class="shop-transfer">
					<i></i>
					<b>Ship hàng tận nơi:</b><br>
					<span>Giao ngay trong ngày</span>
				</div>
				<div class="shop-diversity">
					<i></i>
					<b>Sản phẩm đa dạng:</b><br>
					<span>Đủ các mặt hàng gọi là có ngay</span>
				</div>
			</div>
		</div>
	</div>
</div>