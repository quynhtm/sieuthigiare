<?php global $base_url;?>
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<div class="link-breadcrumb">
				<a href="<?php echo $base_url; ?>">Trang chủ</a>
				<i class="icon-double-angle-right"></i>
				<a href="<?php echo FunctionLib::buildLinkCategory($user_shop->shop_id,$user_shop->shop_name);?>"><?php echo isset($user_shop->shop_name)? $user_shop->shop_name : 'Trang chủ của shop';?></a>
			</div>
			<div class="main-view-post box-register">
				<div class="wrap-main-view shop">
					<div class="left-category-shop">
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
					<div class="right-show-product-shop body-list-item ">
						<div class="banner-shop-content">
							<?php if(!empty($bannerList)){ ?>
								<?php foreach($bannerList as $v){ ?>
								<a title="<?php echo $v->banner_name ?>" href="<?php echo $v->banner_link ?>" target="_blank">
									<img src="<?php echo FunctionLib::getThumbImage($v->banner_image, $v->banner_id, FOLDER_BANNER, 0, 0) ?>" alt="<?php echo $v->banner_name ?>"/>
								</a>
								<?php } ?>
							<?php } ?>
							
						</div>
						<div class="content-list-item">
							<?php foreach($result as $v){?>
							<div class="col-lg-3 col-xs-3 ">
								<div class="item">
									<div class="post-thumb">
										<a href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>" title="<?php echo $v->product_name?>">
											<img src="<?php echo $v->url_image ?>" alt="<?php echo $v->product_name?>" data-other-src="<?php echo $v->url_image_hover?>">
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
		                                    		<?php if($v->product_price_sell > 0 && $v->product_price_market > 0){?>
		                                    		<span class="amount-1"><?php echo number_format($v->product_price_sell)?>đ</span>
													<span class="amount-2"><?php echo number_format($v->product_price_market) ?>đ</span>
													<?php if((float)$v->product_price_market > (float)$v->product_price_sell) {?>
												    <span class="sale-off">
												    	-<?php echo number_format(100 - ((float)$v->product_price_sell/(float)$v->product_price_market)*100, 1) ?>%
												    </span>
												    <?php } ?>
											    <?php } ?>
	                                    		<?php } ?>
                                    		</div>
										</div>
										<div class="item-rating">
				                            <div class="rating-box">
				                                <div class="rating" style="width:0%" id="rate-1"></div>
				                            </div>
				                        </div>
				                        <div class="item-banner"><?php echo $v->product_selloff ?></div>
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
	</div>	
</div>