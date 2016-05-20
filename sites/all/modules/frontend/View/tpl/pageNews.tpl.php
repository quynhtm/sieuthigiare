<?php 
	global $base_url; 
?>
<div class="container">
	<div class="link-breadcrumb">
		<a href="<?php echo $base_url; ?>" title="Trang chủ">Trang chủ</a>
		<i class="icon-double-angle-right"></i>
		<a href="<?php echo $base_url.'/'.$catNameAlias ?>.html" title="<?php echo $catName ?>"><?php echo $catName ?></a>
	</div>
	<div class="main-view-post">
		<div class="wrapp-content-news">
			<div class="left-news-view">
				<h1 class="title-news"><?php echo $catName ?></h1>
				<div class="list-news-post">
					<?php foreach($result as $v) {?>
					<div class="item-news">
						<div class="post-img">
							<a title="<?php echo $v->news_title ?>" href="<?php echo FunctionLib::buildLinkNewsDetail($catNameAlias, $v->news_id, $v->news_title) ?>">
								<?php if($v->news_image != ''){?>
								<img alt="<?php echo $v->news_title ?>"
								src="<?php echo FunctionLib::getThumbImage($v->news_image,$v->news_id,FOLDER_NEWS,400,400) ?>">
								<div class="post-format">
									<i class="icon-file-text"></i>
								</div>
								<?php }else{ ?>
								<img src="<?php echo IMAGE_DEFAULT ?>"/>
								<?php } ?>
							</a>
							
						</div>
						<div class="post-data">
							<h2 class="post-title"><a  href="<?php echo FunctionLib::buildLinkNewsDetail($catNameAlias, $v->news_id, $v->news_title) ?>"><?php echo $v->news_title ?></a></h2>
							<div class="post-content"><?php echo  Utility::substring($v->news_desc_sort, 500, '...')?></div>
							<div class="redmoreNews"> <a href="<?php echo FunctionLib::buildLinkNewsDetail($catNameAlias, $v->news_id, $v->news_title) ?>">Xem thêm</a></div>
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
			<div class="right-news-view">
				<div class="content-right-product search">
					<form action="<?php echo $base_url.'/tim-kiem-tin-tuc.html' ?>" method="GET">
						<input type="text" name="keyword" class="keyword-news" />
						<input type="hidden" name="catalias" value="<?php echo $catNameAlias ?>" />
						<button value="s" name="submit" class="btn btn-primary">Tìm kiếm</button>
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
					<div class="fb-like" data-href="<?php echo $base_url.'/'.$catNameAlias ?>" 
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
		</div>
	</div>
</div>