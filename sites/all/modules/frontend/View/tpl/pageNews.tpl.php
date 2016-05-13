<?php 
	global $base_url; 
?>
<div class="container">
	<div class="link-breadcrumb">
		<a href="<?php echo $base_url; ?>" title="Trang chủ">Trang chủ</a>
		<i class="icon-double-angle-right"></i>
		<a href="<?php echo $base_url.'/'.$catNameAlias ?>" title="<?php echo $catName ?>"><?php echo $catName ?></a>
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
								<img alt="<?php echo $v->news_title ?>"
								src="<?php echo FunctionLib::getThumbImage($v->news_image,$v->news_id,FOLDER_NEWS,400,400) ?>">
								<div class="post-format">
									<i class="icon-file-text"></i>
								</div>
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
			</div>	
		</div>
	</div>
</div>