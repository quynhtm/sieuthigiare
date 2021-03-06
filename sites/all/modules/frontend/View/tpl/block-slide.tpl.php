<?php global $base_url; ?>
<div class="box-header-midd-wrapp">
	<div class="container">
		<div class="box-menu-list">
			<div class="content-box-menu">
				<?php if(!empty($arrCategory)){?>
				<ul>
					<?php 
					$i=0;
					foreach($arrCategory as $cat){
					$i++;
					if($i<=11){
					?>
					<?php if(isset($cat['category_parent_name']) && $cat['category_parent_name'] != ''){ ?>
					<li>
						<a href="<?php echo FunctionLib::buildLinkCategory(0, 0, $cat['category_id'], $cat['category_parent_name']) ?>" title="<?php echo $cat['category_parent_name'] ?>"><?php echo $cat['category_parent_name'] ?></a>
						<?php if(isset($cat['arrSubCategory']) && !empty($cat['arrSubCategory'])) {?>
						<?php 	
							$url = '';
							if($cat['category_image_background'] != ''){
							$url = 'url('.FunctionLib::getThumbImage($cat['category_image_background'],$cat['category_id'],FOLDER_CATEGORY,735,428).') no-repeat bottom right';
						} ?>
						<div class="list-subcat" style="background: #fff <?php echo $url ?>">
							<?php
								$list_ul = array_chunk($cat['arrSubCategory'], 10);
							?>
							<?php foreach($list_ul as $ul){?>
							<ul>
								<?php foreach($ul as $sub){ ?>
								<li><a href="<?php echo FunctionLib::buildLinkCategory(0, 0, $sub['category_id'], $sub['category_name']) ?>" title="<?php echo $sub['category_name'] ?>"><?php echo $sub['category_name'] ?></a></li>
								<?php } ?>
							</ul>
							<?php } ?>
						</div>
						<?php } ?>
					</li>
					<?php } ?>
					<?php } ?>
					<?php } ?>
				</ul>
				<?php } ?>
			</div>
		</div>
		<div class="slider-box-mid">
			<div id="sliderMid">
				<?php 
				if(!empty($bannerSliderLager)){
				foreach($bannerSliderLager as $v){ 
					if($v->banner_is_rel != 1){
						$rel = 'rel="nofollow"';
					}else{
						$rel = '';
					}
				?>
				<div class="slide ">
					<a <?php echo $rel ?> title="<?php echo $v->banner_name ?>" href="<?php echo $v->banner_link ?>" <?php if($v->banner_is_target == BANNER_TARGET_BLANK){?>target="_blank"<?php }?>>
						<img src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_BANNER, $v->banner_id, $v->banner_image, 730, 428, '', true, true) ?>" alt="<?php echo $v->banner_name ?>"/>
					</a>
				</div>
				<?php } } ?>
			</div>
		</div>
		<div class="ads-right-mid">
			<div class="item-right-slider">
				<div id="sliderRight1">
					<?php 
					if(!empty($bannerRightSliderSmall_1)){
					foreach($bannerRightSliderSmall_1 as $v2){ 
						if($v2->banner_is_rel != 1){
							$rel = 'rel="nofollow"';
						}else{
							$rel = '';
						}
					?>
					<div class="slide">
						<a <?php echo $rel ?> href="<?php echo $v2->banner_link ?>" title ="<?php echo $v2->banner_name ?>" <?php if($v2->banner_is_target == BANNER_TARGET_BLANK){?>target="_blank"<?php }?>>
							<img src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_BANNER, $v2->banner_id, $v2->banner_image, 300, 210, '', true, true) ?>" alt="<?php echo $v2->banner_name ?>"/>
						</a>
					</div>
					<?php } } ?>
				</div>
			</div>
			<div class="item-right-slider">
				<div id="sliderRight2">
					<?php 
					if(!empty($bannerRightSliderSmall_2)){
					foreach($bannerRightSliderSmall_2 as $v2){ 
						if($v2->banner_is_rel != 1){
							$rel = 'rel="nofollow"';
						}else{
							$rel = '';
						}
					?>
					<div class="slide">
						<a <?php echo $rel ?> href="<?php echo $v2->banner_link ?>" title ="<?php echo $v2->banner_name ?>" <?php if($v2->banner_is_target == BANNER_TARGET_BLANK){?>target="_blank"<?php }?>>
							<img src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_BANNER, $v2->banner_id, $v2->banner_image, 300, 210, '', true, true) ?>" alt="<?php echo $v2->banner_name ?>"/>
						</a>
					</div>
					<?php } } ?>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery('#sliderMid').bxSlider({
			slideWidth: 610,
			slideHeight: 340,
			minSlides: 1,
			maxSlides: 2,
			slideMargin: 10,
			mode: 'fade',
			pager: true,
			auto: true,
		});

		jQuery('#sliderRight1, #sliderRight2').bxSlider({
			slideWidth: 268,
			slideHeight: 170,
			minSlides: 1,
			maxSlides: 2,
			slideMargin: 10,
			mode: 'fade',
			pager: false,
			auto: true,
		});
    });
</script>