<?php 
	global $base_url;
?>
<div class="container">
	<?php if(isset($dataShow) && !empty($dataShow)) {?>
	<div class="w-list-block">
		<?php foreach($dataShow as $cate_parent_id =>$value){ ?>
			<?php if($cate_parent_id > 0) {?>
				<div class="title-list-item"><a href="<?php echo FunctionLib::buildLinkCategory(0,'',$cate_parent_id,$value['category_name'])?>" title="Xem tất cả: <?php echo $value['category_name'];?>"><?php echo $value['category_name'];?></a></div>
			<?php }else{?>
				<div class="title-list-item">Sản phẩm mới</div>
			<?php }?>
			<div class="content-list-item w-home">
				<ul>
					<?php 
					if(isset($value['arrProducts']) && !empty($value['arrProducts'])){
					foreach($value['arrProducts'] as $item){ ?>
					<li class="item">
						<div class="post-thumb">
							<?php if($item->product_type_price == 1){?>
								<?php if((float)$item->product_price_market > (float)$item->product_price_sell) {?>
								<span class="sale-off">
									-<?php echo number_format(100 - ((float)$item->product_price_sell/(float)$item->product_price_market)*100, 1) ?>%
								</span>
								<?php } ?>
							<?php } ?>
							<a href="<?php echo FunctionLib::buildLinkDetail($item->product_id, $item->product_name); ?>" title="<?php echo $item->product_name?><?php echo ' - '.WEB_SITE ?>">
								<?php if($item->product_image != ''){?>
								<img src="<?php echo FunctionLib::getThumbImage($item->product_image,$item->product_id,FOLDER_PRODUCT,300,300) ?>"
								data-other-src="<?php echo FunctionLib::getThumbImage($item->product_image_hover,$item->product_id,FOLDER_PRODUCT,300,300) ?>"
								alt="<?php echo $item->product_name ?><?php echo ' - '.WEB_SITE ?>"/>
								<?php }else{ ?>
								<img src="<?php echo IMAGE_DEFAULT ?>"/>
								<?php } ?>
							</a>
						</div>
						<div class="item-content">
							<div class="title-info">
								<h4 class="post-title">
									<a href="<?php echo FunctionLib::buildLinkDetail($item->product_id, $item->product_name); ?>" title="<?php echo $item->product_name?><?php echo ' - '.WEB_SITE ?>"><?php echo $item->product_name?></a>
								</h4>
								<div class="item-price">
									<?php if($item->product_type_price == 2){?>
										<span class="amount-call">Liên hệ:
											<a title="<?php echo $item->user_shop_name ?>" class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($item->user_shop_id, $item->user_shop_name, 0, '') ?>">
												<?php echo $item->user_shop_name ?>
											</a>
										</span>
									<?php }else{?>
										<?php if($item->product_price_sell > 0){?>
											<span class="amount-1"><?php echo number_format($item->product_price_sell)?>đ</span>
											<?php if($item->product_price_market > 0){ ?>
											<span class="amount-2"><?php echo number_format($item->product_price_market) ?>đ</span>
											<?php } ?>
										<?php }else{ ?>
											<span class="amount-call">Liên hệ:
												<a class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($item->user_shop_id, $item->user_shop_name, 0, '') ?>">
													<?php echo $item->user_shop_name ?>
												</a>
											</span>
										<?php } ?>
									<?php } ?>
								</div>
							</div>
							<?php if($item->product_selloff != ''){?>
							<div class="item-banner"><?php echo $item->product_selloff ?></div>
							<?php } ?>

							<?php if($item->product_type_price == 1){?>
							<div class="mgt5 amount-call">
								<a title="<?php echo $item->user_shop_name ?>" class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($item->user_shop_id, $item->user_shop_name, 0, '') ?>">
									<?php echo $item->user_shop_name ?>
								</a>
							</div>
							<?php } ?>
						</div>
					</li>
					<?php } }?>
				</ul>
			</div>
		<?php }?>
	</div>
	<?php }?>
</div>

