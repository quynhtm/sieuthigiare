<?php global $base_url;?>
<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="link-breadcrumb">
				<a href="">Trang chủ</a><i class="icon-double-angle-right"></i>
				<a href="">Điện máy & công nghệ</a>
			</div>
			<div class="main-view-post box-detail-product">
				<div class="wrap-main-view">
					<?php 
					$product_id=0;
					$product_name='';
					$product_sort_desc='';
					$product_content = '';
					$product_selloff = '';
					$price_market = 0;
					$price_sell = 0;
					$product_type_price=0;
					$product_image ='';
					$product_image_other ='';
					foreach($result as $v){
						$product_id = $v->product_id;
						$product_name = $v->product_name;
						$product_sort_desc = $v->product_sort_desc;
						$product_content = $v->product_content;
						$product_selloff = $v->product_selloff;
						$price_market = number_format($v->product_price_market);
						$price_sell = number_format($v->product_price_sell);
						
						if($v->product_type_price == 1 || $v->product_type_price == -1){
							$product_type_price=1;
						}

						$product_image = $v->product_image;
						if($v->product_image != ''){
							$product_image = FunctionLib::getThumbImage($v->product_image, $product_id, FOLDER_PRODUCT,800,800);
						}
						if($v->product_image_other != ''){
							$product_image_other = unserialize($v->product_image_other);
						}
					?>
					<div class="top-content-view">
						<div class="left-slider-img">
							<?php 
							if(!empty($product_image_other)){
							?>
							<ul class="list-thumb-img">
								<?php 
								foreach($product_image_other as $img){
								?>
								<li>
									<a href="javascript:void(0)" data-zoom="<?php echo FunctionLib::getThumbImage($img, $product_id, FOLDER_PRODUCT, 800, 800) ?>">
										<img src="<?php echo FunctionLib::getThumbImage($img, $product_id, FOLDER_PRODUCT, 100, 100) ?>" alt="<?php echo $product_name ?>"/>
									</a>
								</li>
								<?php } ?>
							</ul>
							<?php } ?>
							<div class="max-thumb-img">
								<?php if($product_image != ''){?>
								<img src="<?php echo $product_image; ?>" alt="<?php echo $product_name ?>"/>
								<?php } ?>
							</div>
						</div>
						<div class="center-des-product">
							<h1><?php echo $product_name ?></h1>
							
							<?php if($product_type_price == 1){ ?>
							
								<?php if($price_market){?>
								<div class="row-price">
									<div class="lbl-row">Giá thị trường:</div>
									<div class="price-origin"><?php echo $price_market ?><span class="td-border">đ</span></div>
								</div>
								<?php } ?>

								<?php if($price_sell){?>
								<div class="row-price">
									<div class="lbl-row lbl-price-sale">Giá bán:</div>
									<div class="price-sale"><?php echo $price_sell ?><span class="td-border">đ</span></div>
								</div>
								<?php } ?>

								<?php if($price_sell==0 && $price_market==0){?>
								<div class="row-price">
									<div class="lbl-row lbl-price-sale">Giá bán:</div>
									<div class="price-sale">Liên hệ</div>
								</div>
								<?php } ?>
							
							<?php }else{ ?>
								<div class="row-price">
									<div class="lbl-row lbl-price-sale">Giá bán:</div>
									<div class="price-sale">Liên hệ</div>
								</div>
							<?php } ?>

							<div class="features-point">
								<div class="lbl-point">Mô tả sản phẩm</div>
								<div class="des-point"><?php echo $product_sort_desc ?></div>
								<?php if($product_selloff !=''){?>
								<div class="box-promotion">
									<div class="lbl-point">Thông tin khuyến mãi</div>
									<div class="box-content-promotion"><?php echo $product_selloff ?></div>
								</div>
								<?php } ?>
							</div>
						</div>
						<div class="right-des-product">
							<div class="content-right-product">
								<div class="order-number">
									<label for="buy-number">Số lượng</label>
									<select class="sl-number" id="buy-number" name="">
		                                <option value="1">1</option>
		                            </select>
								</div>
								<div class="buynow">Mua ngay</div>
							</div>
							<div class="content-right-product">
								<div class="order-number-phone">
									<p>Quý khách muốn đặt qua điện thoại</p>
									<div class="number-phone">
										<div class="icon-phone"></div>
										0913.922.986
									</div>
									<a href="#" title>Shop Teen</a>
								</div>
							</div>
						</div>
					</div>
					<?php } ?>
					<div class="center-content-view">
						<div class="title-center-content-view">Sản phẩm bán bởi "<a href="" title>Siêu thị giá rẻ</a>" </div>
						<div class="content-center-content-view">
							<div class="jcarousel-wrapper">
								<div class="jcarousel">
									<ul>
										<li>
											<a class="img-thumb" href="" title="">
												<img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/p1.jpg" alt="">
											</a>
											<a class="item-name" href="" title="">Điện thoại iPhone 6S Plus Rose Gold 16GB</a>
											<div class="item-price">
												<p class="price-sale">
													20.790.000 <span>đ</span>
													<i>(21.790.000đ)</i>
												</p>
											</div>
										</li>
										<li>
											<a class="img-thumb" href="" title="">
												<img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/p1.jpg" alt="">
											</a>
											<a class="item-name" href="" title="">Điện thoại iPhone 6S Plus Rose Gold 16GB</a>
											<div class="item-price">
												<p class="price-sale">
													20.790.000 <span>đ</span>
													<i>(21.790.000đ)</i>
												</p>
											</div>
										</li>
										<li>
											<a class="img-thumb" href="" title="">
												<img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/p1.jpg" alt="">
											</a>
											<a class="item-name" href="" title="">Điện thoại iPhone 6S Plus Rose Gold 16GB</a>
											<div class="item-price">
												<p class="price-sale">
													20.790.000 <span>đ</span>
													<i>(21.790.000đ)</i>
												</p>
											</div>
										</li>
										<li>
											<a class="img-thumb" href="" title="">
												<img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/p1.jpg" alt="">
											</a>
											<a class="item-name" href="" title="">Điện thoại iPhone 6S Plus Rose Gold 16GB</a>
											<div class="item-price">
												<p class="price-sale">
													20.790.000 <span>đ</span>
													<i>(21.790.000đ)</i>
												</p>
											</div>
										</li>
										<li>
											<a class="img-thumb" href="" title="">
												<img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/p1.jpg" alt="">
											</a>
											<a class="item-name" href="" title="">Điện thoại iPhone 6S Plus Rose Gold 16GB</a>
											<div class="item-price">
												<p class="price-sale">
													20.790.000 <span>đ</span>
													<i>(21.790.000đ)</i>
												</p>
											</div>
										</li>
										<li>
											<a class="img-thumb" href="" title="">
												<img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/p1.jpg" alt="">
											</a>
											<a class="item-name" href="" title="">Điện thoại iPhone 6S Plus Rose Gold 16GB</a>
											<div class="item-price">
												<p class="price-sale">
													20.790.000 <span>đ</span>
													<i>(21.790.000đ)</i>
												</p>
											</div>
										</li>
									</ul>
								</div>
								<a href="#" class="jcarousel-control-prev">&lsaquo;</a> 
								<a href="#" class="jcarousel-control-next">&rsaquo;</a>
							</div>
						</div>
					</div>
					<div class="bottom-content-view">
						<div class="left-bottom-content-view">
							<ul class="tab">
								<li class="act" data-tab="1">Chi tiết sản phẩm</li>
								<li data-tab="2">Chính sách giao nhận</li>
								<li data-tab="3">Nhận xét</li>
							</ul>
							<div class="content-bottom-content-view">
								<div class="act show-tab show-tab-1"><?php echo $product_content ?></div>
								<div class="show-tab show-tab-2">Testing2...</div>
								<div class="show-tab show-tab-3">Testing3...</div>
							</div>
						</div>
						<div class="right-bottom-content-view">
							<div class="title-hot"><span>Sản phẩm nổi bật</span></div>
							<div class="content-right-bottom-content-view">
								<ul>
									<li>
										<a class="i-thumb" href="" title="">
											<img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/p1.jpg" alt="">
										</a>
										<a class="item-name" href="" title="">Điện thoại iPhone 6S Plus Rose Gold 16GB</a>
										<div class="item-price">
											<p class="price-sale">
												20.790.000 <span>đ</span>
												<i>(21.790.000đ)</i>
											</p>
										</div>
									</li>
									<li>
										<a class="i-thumb" href="" title="">
											<img src="<?php echo $base_url.'/'.path_to_theme()?>/View/img/p1.jpg" alt="">
										</a>
										<a class="item-name" href="" title="">Điện thoại iPhone 6S Plus Rose Gold 16GB</a>
										<div class="item-price">
											<p class="price-sale">
												20.790.000 <span>đ</span>
												<i>(21.790.000đ)</i>
											</p>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>