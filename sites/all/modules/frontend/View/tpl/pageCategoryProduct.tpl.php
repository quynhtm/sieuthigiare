<?php 
	global $base_url; 

	if(isset($arrCatCurrent->category_name) && $arrCatCurrent->category_name != ''){
		SeoMeta::SEO($arrCatCurrent->category_name, '', $arrCatCurrent->category_name, $arrCatCurrent->category_name, $arrCatCurrent->category_name);
	}
?>
<div class="container">
	<div class="link-breadcrumb">
		<a href="<?php echo $base_url; ?>" title="Trang chủ">Trang chủ</a>
		<i class="icon-double-angle-right"></i>
		<a href="<?php echo FunctionLib::buildLinkCategory(0, 0, $arrCatCurrent->category_id, $arrCatCurrent->category_name) ?>" title="<?php echo $arrCatCurrent->category_name ?>"><?php echo $arrCatCurrent->category_name ?></a>
	</div>
	<div class="main-view-post">
		<div class="wrap-main-view shop">
			<div class="left-category-shop">
				<div class="wrapp-category-menu">
					<div class="title-category-parent">
						<?php 
							if(!empty($catParent)){
								if(isset($catParent->category_name) && $catParent->category_name != '' ){
									echo $catParent->category_name;
								}else{
									echo "Danh mục sản phẩm";
								}
							}
						?>
					</div>
					<ul>
						<?php 
						if(!empty($arrCategoryChildren)){
							foreach($arrCategoryChildren as $k =>$v){?>
							<li><a <?php if($arrCatCurrent->category_id == $k){ ?>class="act"<?php } ?> href="<?php echo FunctionLib::buildLinkCategory(0, 0, $k, $v) ?>" title="<?php echo $v?>"><?php echo $v?></a></li>
						<?php } 
						}
						?>
					</ul>
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
					<div class="fb-like" data-href="<?php echo FunctionLib::buildLinkCategory(0, 0, $arrCatCurrent->category_id, $arrCatCurrent->category_name) ?>" 
						data-layout="button_count" data-action="like" 
						data-show-faces="false" data-share="true">
					</div>
				</div>
				<!--Banner quả cáo-->
				<?php if(!empty($bannerLeft)){ ?>
					<div class="right-product-new">
						<?php foreach($bannerLeft as $value){
							$rel3 = ($value->banner_is_rel != 1)? 'rel="nofollow"' : '';
							?>
							<div class="item-right-ads">
								<a <?php echo $rel3 ?> href="<?php echo $value->banner_link ?>" title ="<?php echo $value->banner_name ?>" <?php if($value->banner_is_target == BANNER_TARGET_BLANK){?>target="_blank"<?php }?>>
									<img src="<?php echo FunctionLib::getThumbImage($value->banner_image, $value->banner_id, FOLDER_BANNER, 300, 0) ?>" alt="<?php echo $value->banner_name ?>"/>
								</a>
							</div>
						<?php } ?>
					</div>
				<?php } ?>

			</div>
			<div class="right-show-product-shop body-list-item">
				<?php if(!empty($bannerCategoryParent)){ ?>
					<div class="banner-shop-content">
						<?php foreach($bannerCategoryParent as $v){
							$rel = ($v->banner_is_rel != 1)? 'rel="nofollow"' : '';
						?>
							<a <?php echo $rel ?> title="<?php echo $v->banner_name ?>" href="<?php echo $v->banner_link ?>" target="_blank">
								<img src="<?php echo FunctionLib::getThumbImage($v->banner_image, $v->banner_id, FOLDER_BANNER, 1018, 245) ?>" alt="<?php echo $v->banner_name ?>"/>
							</a>
						<?php } ?>
					</div>
				<?php } ?>

				<?php if(!empty($result)) {?>
				<div class="content-list-item">
					<ul>
						<?php foreach($result as $v){?>
						<li class="item">
							<div class="post-thumb">
								<a href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>" title="<?php echo $v->product_name?><?php echo ' - '.WEB_SITE ?>">
									<?php if(isset($v->url_image) && $v->url_image != ''){?>
									<img src="<?php echo $v->url_image ?>" alt="<?php echo $v->product_name ?><?php echo ' - '.WEB_SITE ?>" data-other-src="<?php echo $v->url_image_hover?>">
									<?php }else{ ?>
									<img src="<?php echo IMAGE_DEFAULT ?>"/>
									<?php } ?>
								</a>
							</div>
							<div class="item-content">
								<div class="title-info">
									<h4 class="post-title">
										<a title="<?php echo $v->product_name?> <?php echo ' - '.WEB_SITE ?>" href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>"><?php echo $v->product_name?></a>
									</h4>
									<div class="item-price">
                                		<?php if($v->product_type_price == 2){?>
                                			<span class="amount-call">Liên hệ:
                                				<a title="<?php echo $v->user_shop_name ?>" class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($v->user_shop_id, $v->user_shop_name, 0, '') ?>">
							                		<?php echo $v->user_shop_name ?>
							                	</a>
                                			</span>
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
										    	<span class="amount-call">Liên hệ: 
													<a title="<?php echo $v->user_shop_name ?>" class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($v->user_shop_id, $v->user_shop_name, 0, '') ?>">
								                		<?php echo $v->user_shop_name ?>
								                	</a>
										    	</span>
										     <?php } ?>	
                                		<?php } ?>
                            		</div>
								</div>
								<?php if($v->product_selloff != ''){?>
				                <div class="item-banner"><?php echo $v->product_selloff ?></div>
				                <?php } ?>
				                <?php if($v->product_type_price == 1){?>
				                <div class="mgt5 amount-call">Liên hệ:
				                	<a title="<?php echo $v->user_shop_name ?>" class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($v->user_shop_id, $v->user_shop_name, 0, '') ?>">
				                		<?php echo $v->user_shop_name ?>
				                	</a>
				            	</div>
								<?php } ?>

							</div>
						</li>
						<?php } ?>
					</ul>
				</div>
				<div class="show-box-paging">
					<div class="showListPage">
						<?php print render($pager); ?>
					</div>
				</div>
				<?php }else{ ?>
				<div class="not-product"><?php echo NOT_PRODUCT ?></div>
				<?php } ?>
			</div>
		</div>
	</div>
</div>