<?php 
	global $base_url; 
?>
<div class="container">
	<div class="link-breadcrumb">
		<a href="<?php echo $base_url; ?>" title="Trang chủ">Trang chủ</a>
		<i class="icon-double-angle-right"></i>
		<a href="<?php echo $base_url.'/tim-kiem-video.html?keyword='.$keyword ?>" title="Tìm kiếm video">Kết quả tìm kiếm video<i>"<?php echo $keyword  ?>"</i></a>
	</div>
	<div class="main-view-post">
		<div class="wrapp-content-video">
			<div class="left-video-view">
				<div class="content-right-product search">
					<form method="GET" action="<?php echo $base_url ?>/tim-kiem-video.html">
						<input type="text" class="keyword-news" name="keyword" value="<?php echo $keyword ?>"/>
						<button class="btn btn-primary" name="submit" value="s">Tìm kiếm</button>
					</form>
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
					<div class="fb-like" data-href="<?php echo $base_url.'/tim-kiem-video.html?keyword='.$keyword ?>" 
						data-layout="button_count" data-action="like" 
						data-show-faces="false" data-share="true">
					</div>
				</div>
				<div class="right-bottom-content-view">
					<div class="title-hot"><span>Sản phẩm nổi bật</span></div>
					<div class="content-right-bottom-content-view">
						<ul>
							<?php 
								foreach($productNew as $k=>$h){
							?>
							<li class="item">
								<a class="i-thumb post-thumb" title="<?php echo $h->product_name?><?php echo ' - '.WEB_SITE ?>" href="<?php echo FunctionLib:: buildLinkDetail($h->product_id, $h->product_name); ?>">
									<?php if($h->product_image != ''){?>
									<img src="<?php echo FunctionLib::getThumbImage($h->product_image, $h->product_id, FOLDER_PRODUCT, 300, 300) ?>" alt="<?php echo $h->product_name?><?php echo ' - '.WEB_SITE ?>" 
									data-other-src="<?php echo FunctionLib::getThumbImage($h->product_image, $h->product_id, FOLDER_PRODUCT, 300, 300) ?>">
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
							<?php } ?>
						</ul>
					</div>
				</div>
			</div>
			<div class="right-video-view">
				<h1 class="title-video">Kết quả tìm kiếm video - <i>(Nguồn Youtube.com)</i></h1>
				<div class="list-video-post">
					<?php foreach($result as $v) {?>
					<div class="item-video">
						<a title="<?php echo $v->video_name ?>" class="thumb <?php if($v->video_img == ''){ echo 'no-img'; }?>" 
							href="<?php echo FunctionLib::buildLinkVideoDetail('video', $v->video_id, $v->video_name) ?>">
							<?php if($v->video_img != ''){?>
							<img alt="<?php echo $v->video_name ?>"
								src="<?php echo FunctionLib::getThumbImage($v->video_img, $v->video_id,FOLDER_VIDEO,400,400) ?>">
							<?php }else{?>
							<img src="<?php echo IMAGE_DEFAULT_VIDEO ?>"/>
							<?php } ?>
							<div class="post-format">
								<i class="icon-play"></i>
							</div>
						</a>
						<div class="description">
							<h3 class="title-item ellipsis"><a title="<?php echo $v->video_name ?>" 
								href="<?php echo FunctionLib::buildLinkVideoDetail('video', $v->video_id, $v->video_name) ?>"><?php echo $v->video_name ?></a>
							</h3>
							<p class="intro"><?php echo  Utility::substring($v->video_sort_desc, 200, '...')?></p>
						</div>
					</div>
					<?php } ?>
					<div class="show-box-paging" style="margin-top:20px; ">
						<div class="showListPage">
							<?php print render($pager); ?>
						</div>
					</div>
				</div>
			</div>	
		</div>
	</div>
</div>