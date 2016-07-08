<?php 
	global $base_url;
	
	$product_id = $result->product_id;
	$product_name = $result->product_name;
	$product_sort_desc = $result->product_sort_desc;
	$product_content = trim(Utility::setNofollow($result->product_content));
	if($product_content == ''){
		$product_content = $product_sort_desc;
	}
	$product_selloff = $result->product_selloff;
	$price_market = number_format($result->product_price_market);
	$price_sell = number_format($result->product_price_sell);
	
	$category_id = $result->category_id;
	$category_name = $result->category_name;

	$product_type_price = -1;

	if($result->product_type_price == 1 || $result->product_type_price == -1){
		$product_type_price=1;
	}

	$product_image = $result->product_image;
	if($result->product_image != ''){
		$product_image = FunctionLib::getThumbImage($result->product_image, $product_id, FOLDER_PRODUCT,400,500);
	}
	if($result->product_image_other != ''){
		$product_image_other = unserialize($result->product_image_other);
	}
	
	SeoMeta::SEO($product_name.' - '.WEB_SITE, $product_image, $product_name.' - '.WEB_SITE, $product_name.' - '.WEB_SITE, $product_sort_desc.' - '.WEB_SITE);

?>
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<div class="link-breadcrumb">
				<a href="<?php echo $base_url; ?>" title="Trang chủ">Trang chủ</a>
				<i class="icon-double-angle-right"></i>
				<a href="<?php echo FunctionLib::buildLinkCategory($user_shop->shop_id, $user_shop->shop_name, 0, '') ?>" title="<?php echo $user_shop->shop_name ?>"><?php echo $user_shop->shop_name ?></a>
				<i class="icon-double-angle-right"></i>
				<a href="<?php echo FunctionLib::buildLinkCategory($user_shop->shop_id, $user_shop->shop_name, $category_id, $category_name) ?>" title="<?php echo $category_name ?>"><?php echo $category_name ?></a>
				<i class="icon-double-angle-right"></i>
				<a href="<?php echo FunctionLib::buildLinkDetail($product_id, $product_name) ?>" title="<?php echo $product_name ?><?php echo ' - '.WEB_SITE ?>"><?php echo $product_name ?></a>
			</div>
			<div class="main-view-post box-detail-product">
				<div class="wrap-main-view">
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
									<a href="javascript:void(0)" data-zoom="<?php echo FunctionLib::getThumbImage($img, $product_id, FOLDER_PRODUCT, 400, 500) ?>">
										<img src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $product_id, $img, 100, 100, '', true, true) ?>" alt="<?php echo $product_name ?><?php echo ' - '.WEB_SITE ?>"/>
									</a>
								</li>
								<?php } ?>
							</ul>
							<?php } ?>
							<div class="max-thumb-img">
								<?php if($product_image != ''){?>
								<a href="javascript:void(0)" title="">
									<img src="<?php echo $product_image; ?>" alt="<?php echo $product_name ?><?php echo ' - '.WEB_SITE ?>"/>
								</a>
								<?php }else{ ?>
									<img src="<?php echo IMAGE_DEFAULT ?>"/>
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
								<div class="des-point">
									<?php echo $product_sort_desc ?>
								</div>
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
								<div id="fb-root"></div>
									<script>(function(d, s, id) {
									  var js, fjs = d.getElementsByTagName(s)[0];
									  if (d.getElementById(id)) return;
									  js = d.createElement(s); js.id = id;
									  js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.6";
									  fjs.parentNode.insertBefore(js, fjs);
									}(document, 'script', 'facebook-jssdk'));</script>
								<div class="fb-like" data-href="<?php echo FunctionLib::buildLinkDetail($product_id, $product_name); ?>" 
									data-layout="button_count" data-action="like" 
									data-show-faces="false" data-share="true">
								</div>
							</div>
							<div class="content-right-product">
								<div class="order-number">
									<label for="buy-number">Số lượng</label>
									<select class="sl-num" id="buy-num" name="buy-num">
		                                <?php for($i=1;$i<=10; $i++){ ?>
		                                <option value="<?php echo $i ?>"><?php echo $i ?></option>
										<?php } ?>
		                            </select>
								</div>
								<div id="buttonFormBuySubmit" data-pid="<?php echo $product_id ?>" class="buynow btn">Mua ngay</div>
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
					</div>
					
					<div class="center-content-view">
						<div class="title-center-content-view">Sản phẩm bạn có thể quan tâm</div>
						<div class="content-center-content-view">
							<div class="jcarousel-wrapper">
								<div class="jcarousel">
									<ul>
										<?php
										if(!empty($arrSame)){
											foreach($arrSame as $k=>$same){?>
										<li class="item">
											<a class="img-thumb post-thumb" title="<?php echo $same->product_name?><?php echo ' - '.WEB_SITE ?>" href="<?php echo FunctionLib:: buildLinkDetail($same->product_id, $same->product_name); ?>">
												<?php if($same->product_image != ''){?>
												<img src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $same->product_id, $same->product_image, 300, 300, '', true, true) ?>" alt="<?php echo $same->product_name?><?php echo ' - '.WEB_SITE ?>" 
													data-other-src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $same->product_id, $same->product_image_hover, 300, 300, '', true, true) ?>">
												<?php }else{ ?>
												<img src="<?php echo IMAGE_DEFAULT ?>"/>
												<?php } ?>
											</a>
											<a class="item-name" title="<?php echo $same->product_name?><?php echo ' - '.WEB_SITE ?>" href="<?php echo FunctionLib:: buildLinkDetail($same->product_id, $same->product_name); ?>"><?php echo $same->product_name?></a>
											<div class="item-price">
												<?php if($same->product_type_price == 2){?>
													<p class="price-sale">Liên hệ</p>
												<?php }else{ ?>
													<p class="price-sale">
														<?php if($same->product_price_sell > 0){?>
															<?php echo number_format($same->product_price_sell)?><span>đ</span>
															<?php if($same->product_price_market > 0){?>
															<i>(<?php echo number_format($same->product_price_market)?>)</i>
															<?php } ?>
														<?php }else{ ?>
															Liên hệ
														<?php } ?>
													</p>
												<?php } ?>
											</div>
							                <div class="mgt5 amount-call">
							                	<a title="<?php echo $same->user_shop_name ?>" class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($same->user_shop_id, $same->user_shop_name, 0, '') ?>">
							                		<?php echo $same->user_shop_name ?>
							                	</a>
							            	</div>
										</li>
										<?php } ?>
										<?php } ?>
									</ul>
								</div>
								<?php if(count($arrSame)>5){ ?>
								<a href="#" class="jcarousel-control-prev">&lsaquo;</a> 
								<a href="#" class="jcarousel-control-next">&rsaquo;</a>
								<?php } ?>
							</div>
						</div>
					</div>
					<div class="bottom-content-view">
						<div class="left-bottom-content-view">
							<ul class="tab">
								<li class="act" data-tab="1">Chi tiết sản phẩm</li>
								<li data-tab="2">Bình luận</li>
								<li data-tab="3">Chính sách giao nhận</li>
								<li data-tab="4">Giới thiệu Shop</li>
							</ul>
							<div class="content-bottom-content-view">
								<div class="act show-tab show-tab-1"><?php echo $product_content ?></div>
								<div class="show-tab show-tab-2">
									<!--
									<div class="form-comment-post">
										<div class="col-sm-8">
											<div class="row">
												<div class="control-group">
													<span id="clickFormCommentSubmit" class="btn btn-primary">Nhận xét sản phẩm</span>
												</div>
												<div class="wrapp-form-comment-post">
													<div class="control-group">
														<label class="control-label">Họ tên</label>
														<div class="controls">
															<input type="text" class="form-control input-sm" placeholder="Họ tên" name="">
														</div>
													</div>
													<div class="control-group">
														<label class="control-label">Tiêu đề</label>
														<div class="controls">
															<input type="text" class="form-control input-sm" placeholder="Tiêu đề" name="">
														</div>
													</div>
													<div class="control-group">
														<label class="control-label">Bình luận</label>
														<div class="controls">
															<textarea name="product_content" id="product_content" class="form-control input-sm" cols="30" rows="5"></textarea>
														</div>
													</div>
													<button type="submit" name="submit" id="buttonFormCommentSubmit" class="btn btn-primary" value="1">Gửi nhận xét</button>
												</div>
											</div>
										</div>
									</div>
									<div class="item-comment">
										<div class="c-title">
											<span class="c-name">Duy Nguyen</span>
											<span class="c-time">- 8 giờ trước</span>
										</div>
										<div class="c-comment">
											Mình mới mua sp này ,rất tiện lợi ,dùng rất ok
										</div>
										<div class="rep-comment">Trả lời</div>
										<div class="list-comment">
											<div class="item-rep">
												<div class="c-title">
													<span class="c-name">Duy Nguyen</span>
													<span class="c-time">- 8 giờ trước</span>
												</div>
												<div class="c-comment">
													Chào bạn Phạm Văn Khoa, Bộ phận CSKH của chúng tôi sẽ liên hệ để hỗ trợ bạn đặt đơn hàng. 
													Bạn vui lòng giữ liên lạc nhé. Cảm ơn bạn đã quan tâm đến các sản phẩm do chúng tôi cung cấp!
												</div>
												<div class="rep-comment">Trả lời</div>
											</div>
											<div class="item-rep">
												<div class="c-title">
													<span class="c-name">Duy Nguyen</span>
													<span class="c-time">- 8 giờ trước</span>
												</div>
												<div class="c-comment">
													Chào bạn Phạm Văn Khoa, Bộ phận CSKH của chúng tôi sẽ liên hệ để hỗ trợ bạn đặt đơn hàng. 
													Bạn vui lòng giữ liên lạc nhé. Cảm ơn bạn đã quan tâm đến các sản phẩm do chúng tôi cung cấp!
												</div>
												<div class="rep-comment">Trả lời</div>
											</div>
										</div>
									</div>
									-->
									<div class="social-comment">
									<div class="content-comment-facebook">
										<div class="socialFacebook">
											<div id="fb-root"></div>
											<script>(function(d, s, id) {
											  var js, fjs = d.getElementsByTagName(s)[0];
											  if (d.getElementById(id)) return;
											  js = d.createElement(s); js.id = id;
											  js.src = "//connect.facebook.net/vi_VN/all.js#xfbml=1&appId=342626259177944";
											  fjs.parentNode.insertBefore(js, fjs);
											}(document, 'script', 'facebook-jssdk'));</script>
											<div class="fb-comments" data-href="<?php echo FunctionLib:: buildLinkDetail($product_id, $product_name); ?>" data-width="800px" data-num-posts="10"></div>
										</div>
									</div>
								</div>
								</div>
								<div class="show-tab show-tab-3"><?php echo $user_shop->shop_transfer ?></div>
								<div class="show-tab show-tab-4"><?php echo $user_shop->shop_about ?></div>
							</div>
						</div>
						<div class="right-bottom-content-view">
							<div class="title-hot"><span>Sản phẩm nổi bật</span></div>
							<div class="content-right-bottom-content-view">
								<ul>
									<?php
										if(!empty($arrProductHot)){
										foreach($arrProductHot as $kk=>$h){
									?>
										<li class="item">
											<a class="i-thumb post-thumb" title="<?php echo $h->product_name?><?php echo ' - '.WEB_SITE ?>" href="<?php echo FunctionLib:: buildLinkDetail($h->product_id, $h->product_name); ?>">
												<?php if($h->product_image != ''){?>
												<img src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $h->product_id, $h->product_image, 300, 300, '', true, true) ?>" alt="<?php echo $h->product_name?><?php echo ' - '.WEB_SITE ?>" 
												data-other-src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $h->product_id, $h->product_image_hover, 300, 300, '', true, true) ?>">
												<?php }else{ ?>
												<img src="<?php echo IMAGE_DEFAULT ?>"/>
												<?php } ?>
											</a>

											<a class="item-name" title="<?php echo $h->product_name?><?php echo ' - '.WEB_SITE ?>" href="<?php echo FunctionLib:: buildLinkDetail($h->product_id, $h->product_name); ?>"><?php echo $h->product_name?></a>
											<div class="item-price">
												<?php if($h->product_type_price == 2){?>
													<p class="price-sale">Liên hệ</p>
												<?php }else{ ?>
													<p class="price-sale">
														<?php if($h->product_price_sell > 0){?>

															<?php echo number_format($h->product_price_sell)?><span>đ</span>
															<?php if($h->product_price_market > 0){?>
															<i>(<?php echo number_format($h->product_price_market)?>)</i>
															<?php } ?>

														<?php }else{ ?>
															Liên hệ
														<?php } ?>
													</p>
												<?php } ?>
											</div>
											<div class="mgt5 amount-call">
												<a title="<?php echo $h->user_shop_name ?>" class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($h->user_shop_id, $h->user_shop_name, 0, '') ?>">
													<?php echo $h->user_shop_name ?>
												</a>
											</div>
										</li>
									<?php } } ?>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>