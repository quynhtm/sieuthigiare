<?php global $base_url; ?>
<div class="box-header-midd-wrapp">
	<div class="container">
		<div class="box-menu-list">
			<div class="content-box-menu">
				<?php if(!empty($arrCategory)){?>
				<ul>
					<?php foreach($arrCategory as $key=>$cat){?>
					<?php if(isset($cat['name']) && $cat['name'] != ''){ ?>
					<li>
						<a href="<?php echo FunctionLib::buildLinkCategory(0, 0, $key, $cat['name']) ?>"><?php echo $cat['name'] ?></a>
						<?php if(isset($cat['sub']) && !empty($cat['name'])) {?>
						<div class="list-subcat" style="background: #fff">
							<ul>
								<?php foreach($cat['sub'] as $k=>$sub){ ?>
								<li><a href="<?php echo FunctionLib::buildLinkCategory(0, 0, $k, $sub) ?>"><?php echo $sub ?></a></li>
								<?php } ?>
							</ul>
						</div>
						<?php } ?>
					</li>
					<?php } ?>
					<?php } ?>
				</ul>
				<?php } ?>
			</div>
		</div>
		<div class="slider-box-mid">
			<div class="nivoSlider" id="slider">
				<?php foreach($bannerLager as $v){ ?>
				<a title="<?php echo $v->banner_name ?>" href="<?php echo $v->banner_link ?>" target="_blank" class="nivo-imageLink" style="display: block;">
					<img src="<?php echo FunctionLib::getThumbImage($v->banner_image, $v->banner_id, FOLDER_BANNER, 0, 0) ?>" alt="<?php echo $v->banner_name ?>"/>
				</a>
				<?php } ?>
			</div>
		</div>
		<div class="ads-right-mid">
			<?php foreach($bannerSmall as $v){ ?>
			<div class="item-right-slider">
				<a href="<?php echo $v->banner_link ?>" title ="<?php echo $v->banner_name ?>">
					<img src="<?php echo FunctionLib::getThumbImage($v->banner_image, $v->banner_id, FOLDER_BANNER, 300, 210) ?>" alt="<?php echo $v->banner_name ?>"/>
				</a>
			</div>
			<?php } ?>
		</div>
	</div>
</div>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('#slider').nivoSlider();
    });
</script>