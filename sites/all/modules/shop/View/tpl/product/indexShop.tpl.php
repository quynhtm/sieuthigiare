<?php 
	global $base_url;
	if(isset($user_shop->shop_name) && $user_shop->shop_name != ''){
		SeoMeta::SEO($user_shop->shop_name, '', $user_shop->shop_name, $user_shop->shop_name, $user_shop->shop_name);
	}
?>
<div class="container">
	<div class="link-breadcrumb">
		<a href="<?php echo $base_url; ?>">Trang chủ</a>
		<i class="icon-double-angle-right"></i>
		<a href="<?php echo FunctionLib::buildLinkCategory($user_shop->shop_id,$user_shop->shop_name);?>"><?php echo isset($user_shop->shop_name)? $user_shop->shop_name : 'Trang chủ của shop';?></a>
	</div>
	<div class="main-view-post">
		<div class="wrap-main-view shop">
			<div class="left-category-shop">
				<div class="wrapp-category-menu">
					<div class="title-category-parent">
						<?php 
							if(isset($user_shop->shop_category_name) && $user_shop->shop_category_name != ''){
								echo $user_shop->shop_category_name;
							}else{
								echo 'Danh mục sản phẩm';
							} 
						?>
					</div>
					<?php if(isset($arrCategoryChildren) && !empty($arrCategoryChildren)){
						$shop_id = isset($user_shop->shop_id)? $user_shop->shop_id : 0;
					?>
					<ul>
						<?php foreach($arrCategoryChildren as $k =>$v){?>
						<li><a class="<?php if($category_id == $k){ ?>act<?php } ?>" href="<?php echo FunctionLib::buildLinkCategory($shop_id, '', $k, $v) ?>" title="<?php echo $v?>"><?php echo $v?></a></li>
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

			</div>
			<div class="right-show-product-shop body-list-item ">
				<?php if(!empty($bannerList)){ ?>
				<div class="banner-shop-content">
					<?php foreach($bannerList as $v){ ?>
					<a title="<?php echo $v->banner_name ?>" href="<?php echo $v->banner_link ?>" target="_blank">
						<img src="<?php echo FunctionLib::getThumbImage($v->banner_image, $v->banner_id, FOLDER_BANNER, 0, 0) ?>" alt="<?php echo $v->banner_name ?>"/>
					</a>
					<?php } ?>
				</div>
				<?php } ?>
				<div class="content-list-item">
					<?php foreach($result as $v){?>
					<div class="col-lg-3 col-xs-3 ">
						<div class="item">
							<div class="post-thumb">
								<a href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>" title="<?php echo $v->product_name?>">
									<?php if(isset($v->url_image) && $v->url_image != ''){?>
									<img src="<?php echo $v->url_image ?>" alt="<?php echo $v->product_name?>" data-other-src="<?php echo $v->url_image_hover?>">
									<?php }else{ ?>
									<img src="<?php echo IMAGE_DEFAULT ?>"/>
									<?php } ?>
								</a>
							</div>
							<div class="item-content">
								<div class="title-info">
									<h4 class="post-title">
										<a title="<?php echo $v->product_name?>" href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>"><?php echo $v->product_name?></a>
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
												
												<?php if((float)$v->product_price_market > (float)$v->product_price_sell) {?>
											    <span class="sale-off">
											    	-<?php echo number_format(100 - ((float)$v->product_price_sell/(float)$v->product_price_market)*100, 1) ?>%
											    </span>
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
						</div>
					</div>
					<?php } ?>
				</div>
				<div class="show-box-paging">
					<div class="showListPage">
						<?php print render($pager); ?>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>