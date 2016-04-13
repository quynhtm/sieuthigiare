<?php global $base_url;?>
<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="link-breadcrumb">
				<a href="">Trang chủ</a><i class="icon-double-angle-right"></i>
				<a href=""><?php echo isset($user_shop->shop_name)? $user_shop->shop_name : 'Trang chủ của shop';?></a>
			</div>
			<div class="main-view-post box-register">
				<div class="wrap-main-view">
					<div class="left-category-shop">
						<div class="title-category-parent">DANH MỤC SẢN PHẨM</div>
						<?php if(isset($arrCategoryChildren) && !empty($arrCategoryChildren)){
							$shop_id = isset($user_shop->shop_id)? $user_shop->shop_id : 0;
							$shop_id = isset($user_shop->shop_name)? $user_shop->shop_id : 0;
						?>
						<ul>
							<?php foreach($arrCategoryChildren as $k =>$v){?>
							<li><a href="<?php echo $base_url.'/gian-hang/'.$shop_id.'/c'.$k.'/shop-teen.html' ?>" title="<?php echo $v?>"><?php echo $v?></a></li>
							<?php } } ?>
						</ul>
					</div>
					<div class="right-show-product-shop body-list-item ">
						<div class="banner-shop-content">
							<a href="" title=""><img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/banner.jpg" alt=""></a>
						</div>
						<div class="content-list-item">
							<?php foreach($result as $v){?>
							<div class="col-lg-3 col-xs-3 ">
								<div class="item">
									<div class="post-thumb">
										<a href="" title=""><img src="<?php echo $v->url_image ?>" alt="<?php echo $v->product_name?>" alt="<?php echo $v->product_name?>" data-other-src="<?php echo $v->url_image_hover?>"></a>
									</div>
									<div class="item-content">
										<div class="title-info">
											<h4 class="post-title"><a title="<?php echo $v->product_name?>" href=""><?php echo $v->product_name?></a></h4>
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