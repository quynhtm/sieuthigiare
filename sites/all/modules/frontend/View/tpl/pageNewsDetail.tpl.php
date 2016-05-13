<?php 
	global $base_url;

	$news_id = $result->news_id;
	$news_title = $result->news_title;
	$news_desc_sort = $result->news_desc_sort;
	$news_content = Utility::setNofollow($result->news_content);
	
	$news_image = $result->news_image;
	if($result->news_image != ''){
		$news_image = FunctionLib::getThumbImage($result->news_image, $news_id, FOLDER_PRODUCT,400,500);
	}

	SeoMeta::SEO($news_title.' - '.WEB_SITE, $news_image, $news_title.' - '.WEB_SITE, $news_title.' - '.WEB_SITE, $news_desc_sort.' - '.WEB_SITE);

?>
<div class="container">
	<div class="link-breadcrumb">
		<a href="<?php echo $base_url; ?>" title="Trang chủ">Trang chủ</a>
		<i class="icon-double-angle-right"></i>
		<a href="<?php echo $base_url.'/'.$catNameAlias ?>" title="<?php echo $catName ?>"><?php echo $catName ?></a>
		<i class="icon-double-angle-right"></i>
		<a href="<?php echo FunctionLib::buildLinkNewsDetail($news_id, $news_title) ?>" title="<?php echo $news_title ?>"><?php echo $news_title ?></a>
	</div>
	<div class="main-view-post">
		<div class="left-news-view">
			<div class="wrapp-content-news">
				<h1 class="title-news"><?php echo $news_title ?></h1>
				<div class="intro-news"><?php echo $news_desc_sort ?></div>
				<div class="content-news"><?php echo $news_content ?></div>
			</div>
			<?php if(!empty($arrSameNews)){?>
			<div class="same-content-news">
				<div class="same-title">Bài viết khác:</div>
				<ul>
					<?php foreach($arrSameNews as $v){?>
					<li><i class="icon-double-angle-right"></i> <a href="<?php echo FunctionLib::buildLinkNewsDetail($catNameAlias, $v->news_id, $v->news_title) ?>" title="<?php echo $v->news_title ?>"><?php echo $v->news_title ?></a></li>
					<?php } ?>
				</ul>
			</div>
			<?php } ?>
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
				<div class="fb-like" data-href="<?php echo FunctionLib::buildLinkDetail($news_id, $news_title); ?>" 
					data-layout="button_count" data-action="like" 
					data-show-faces="false" data-share="true">
				</div>
			</div>
		</div>
	</div>
</div>