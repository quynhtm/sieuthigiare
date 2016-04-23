<?php 
	global $base_url;
?>
<div class="container">
	
	<div class="w-list-block">
		<div class="title-list-item">Sản phẩm mới</div>
		<div class="content-list-item w-home">
			<ul>
				<?php foreach($result as $item){ ?>
				<li class="item">
					<div class="post-thumb">
						<?php if((float)$item->product_price_market > (float)$item->product_price_sell) {?>
					    <span class="sale-off">
					    	-<?php echo number_format(100 - ((float)$item->product_price_sell/(float)$item->product_price_market)*100, 1) ?>%
					    </span>
					    <?php } ?>
						<a href="<?php echo FunctionLib::buildLinkDetail($item->product_id, $item->product_name); ?>" title="<?php echo $item->product_name?>">
							<img src="<?php echo FunctionLib::getThumbImage($item->product_image,$item->product_id,FOLDER_PRODUCT,300,300) ?>" 
							data-other-src="<?php echo FunctionLib::getThumbImage($item->product_image_hover,$item->product_id,FOLDER_PRODUCT,300,300) ?>" 
							alt="<?php echo $item->product_name ?>"/>
						</a>
					</div>
					<div class="item-content">
						<div class="title-info">
							<h4 class="post-title">
								<a href="" title="<?php echo $item->product_name?>"><?php echo $item->product_name?></a>
							</h4>
							<div class="item-price">
                        		<?php if($item->product_type_price == 2){?>
                        			<span class="amount-call">Liên hệ: <i class="link-shop"><?php echo $item->user_shop_name ?></i></span>
                        		<?php }else{?>
                            		<?php if($item->product_price_sell > 0 && $item->product_price_market > 0){?>
                            		<span class="amount-1"><?php echo number_format($item->product_price_sell)?>đ</span>
									<span class="amount-2"><?php echo number_format($item->product_price_market) ?>đ</span>
							    <?php } ?>
                        		<?php } ?>
                    		</div>
						</div>

						<?php if($item->product_selloff != ''){?>
		                <div class="item-banner"><?php echo $item->product_selloff ?></div>
		                <?php } ?>
						
						<?php if($item->product_type_price == 1){?>
		                <div class="mgt5 amount-call">gian hàng: <i class="link-shop"><?php echo $item->user_shop_name ?></i></div>
						<?php } ?>

					</div>
				</li>
				<?php } ?>
			</ul>
		</div>	
	</div>
	
</div>

