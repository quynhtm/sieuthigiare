<?php 
	global $base_url;
	if(isset($user_shop->shop_name) && $user_shop->shop_name != ''){
		
		if($user_shop->is_shop == SHOP_VIP){
			$path = PATH_UPLOAD.'/shop/'.$user_shop->shop_id.'/'.$user_shop->shop_logo;
			if($user_shop->shop_logo != '' && is_file($path)){
				$meta_img = $base_url.'/uploads/shop/'.$user_shop->shop_id.'/'.$user_shop->shop_logo;
			}else{
				$meta_img = IMAGE_DEFAULT_SHOP;
			}
		}else{
			$meta_img = IMAGE_DEFAULT_SHOP;
		}

		if($user_shop->shop_about != ''){
			$des_sort = strip_tags($user_shop->shop_about);
		}else{
			$des_sort = $user_shop->shop_name;
		}

		SeoMeta::SEO($user_shop->shop_name, $meta_img, $user_shop->shop_name, $user_shop->shop_name, $des_sort);
	}
?>
<div class="container">
	<div class="link-breadcrumb">
		<a href="<?php echo $base_url; ?>" title="Trang chủ">Trang chủ</a>
		<i class="icon-double-angle-right"></i>
		<a href="<?php echo FunctionLib::buildLinkCategory($user_shop->shop_id,$user_shop->shop_name);?>" title="<?php echo isset($user_shop->shop_name)? $user_shop->shop_name : 'Trang chủ của shop';?><?php echo ' - '.WEB_SITE ?>"><?php echo isset($user_shop->shop_name)? $user_shop->shop_name : 'Trang chủ của shop';?></a>
	</div>
	<div class="main-view-post">
		<div class="wrap-main-view shop">
			<div class="left-category-shop">
				<div class="wrapp-category-menu">
					<div class="title-category-parent">
						Danh mục sản phẩm
					</div>
					<?php if(isset($treeCategoryShop) && !empty($treeCategoryShop)){
						$shop_id = isset($user_shop->shop_id)? $user_shop->shop_id : 0;
					?>
					<ul>
						<?php foreach($treeCategoryShop as $k =>$v){?>
							<?php if(in_array($k,$arrCateParenId)){?>
								<li><b><?php echo $v?></b></li><!--- ten danh mục cha không có link-->
							<?php }else{?>
								<li><a class="<?php if($category_id == $k){ ?>act<?php } ?>" href="<?php echo FunctionLib::buildLinkCategory($shop_id, '', $k, $v) ?>" title="<?php echo $v?>"><?php echo $v?></a></li>
							<?php } ?>
						<?php } ?>
					</ul>
					<?php } ?>
				</div>
				<div class="content-right-product">
					<div id="fb-root"></div>
						<script>(function(d, s, id) {
						  var js, fjs = d.getElementsByTagName(s)[0];
						  if (d.getElementById(id)) return;
						  js = d.createElement(s); js.id = id;
						  js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.6";
						  fjs.parentNode.insertBefore(js, fjs);
						}(document, 'script', 'facebook-jssdk'));</script>
					<div class="fb-like" data-href="<?php echo FunctionLib::buildLinkCategory($user_shop->shop_id, $user_shop->shop_name, 0, '') ?>" 
						data-layout="button_count" data-action="like" 
						data-show-faces="false" data-share="true">
					</div>
				</div>
				<div class="content-right-product">
					<div class="order-number-phone">
						<p><b>Quý khách muốn đặt qua điện thoại</b></p>
						<div class="number-phone">
							<div class="icon-phone"></div>
							<?php echo $user_shop->shop_phone?>
						</div>
						<p><a href="<?php echo FunctionLib::buildLinkCategory($user_shop->shop_id, $user_shop->shop_name, 0, '') ?>" title="Shop: <?php echo $user_shop->shop_name ?>"><?php echo $user_shop->shop_name ?></a></p>
						<?php if($user_shop->shop_address !=''){?>
							<p><b>Thông tin liên hệ: </b></p>
							<p><?php echo $user_shop->shop_email;?></p>
							<p><?php echo $user_shop->shop_address;?></p>
						<?php }?>
					</div>
				</div>
			</div>
			<div class="right-show-product-shop body-list-item ">
				<?php if(!empty($bannerList)){ ?>
				<div class="banner-shop-content">
					<?php foreach($bannerList as $v){ 
						if($v->banner_is_rel != 1){
							$rel = 'rel="nofollow"';
						}else{
							$rel = '';
						}
					?>
					<a <?php echo $rel ?> title="<?php echo $v->banner_name ?>" href="<?php echo $v->banner_link ?>" target="_blank">
						<img src="<?php echo FunctionLib::getThumbImage($v->banner_image, $v->banner_id, FOLDER_BANNER, 0, 0) ?>" alt="<?php echo $v->banner_name ?>"/>
					</a>
					<?php } ?>
				</div>
				<?php } ?>
				<div class="content-list-item">
					<ul>
						<?php foreach($result as $v){?>
						<li class="item">
							<div class="post-thumb">
								<a href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>" title="<?php echo $v->product_name?><?php echo ' - '.WEB_SITE ?>">
									<?php if($v->product_image != ''){?>
									<img src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $v->product_id, $v->product_image, 300, 300, '', true, true) ?>" alt="<?php echo $h->product_name?><?php echo ' - '.WEB_SITE ?>" 
									data-other-src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $v->product_id, $v->product_image_hover, 300, 300, '', true, true) ?>">
									<?php }else{ ?>
									<img src="<?php echo IMAGE_DEFAULT ?>"/>
									<?php } ?>
								</a>
							</div>
							<div class="item-content">
								<div class="title-info">
									<h4 class="post-title">
										<a title="<?php echo $v->product_name?><?php echo ' - '.WEB_SITE ?>" href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>"><?php echo $v->product_name?></a>
									</h4>
									<div class="item-price">
                                		<?php if($v->product_type_price == 2){?>
                                			<span class="amount-call">Liên hệ: <i class="num-call"><?php echo $phone ?></i></span>
                                		<?php }else{?>
                                    		<?php if($v->product_price_sell > 0){?>
	                                    		<span class="amount-1"><?php echo number_format($v->product_price_sell)?>đ</span>
												
												<?php if($v->product_price_market > 0){?>
												<span class="amount-2"><?php echo number_format($v->product_price_market) ?>đ</span>
												<?php } ?>
												<?php if($v->product_type_price == 1){?>
													<?php if((float)$v->product_price_market > (float)$v->product_price_sell) {?>
												    <span class="sale-off">
												    	-<?php echo number_format(100 - ((float)$v->product_price_sell/(float)$v->product_price_market)*100, 1) ?>%
												    </span>
											    	<?php }?>
											    <?php }?>
									    	<?php }else{ ?>
										    	<span class="amount-call">Liên hệ: <i class="num-call"><?php echo $phone ?></i></span>
										     <?php } ?>	
                                		<?php } ?>
                            		</div>
								</div>
								<?php if($v->product_selloff != ''){?>
				                <div class="item-banner"><?php echo $v->product_selloff ?></div>
				                <?php } ?>
							</div>
						</li>
						<?php } ?>
					</ul>
				</div>
				<div class="show-box-paging" style="margin-top:20px; ">
					<div class="showListPage">
						<?php print render($pager); ?>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>