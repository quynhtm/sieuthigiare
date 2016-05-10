<?php 
	global $base_url; 
?>
<?php foreach($result as $v){?>
<li class="item">
	<div class="post-thumb">
		<a href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>" title="<?php echo $v->product_name?><?php echo ' - '.WEB_SITE ?>">
			<?php if(isset($v->product_image) && $v->product_image != ''){?>
			<img src="<?php echo FunctionLib::getThumbImage($v->product_image,$v->product_id,FOLDER_PRODUCT,300,300) ?>"
				 data-other-src="<?php echo FunctionLib::getThumbImage($v->product_image_hover,$v->product_id,FOLDER_PRODUCT,300,300) ?>"
				 alt="<?php echo $v->product_name?><?php echo ' - '.WEB_SITE ?>">
			<?php }else{ ?>
			<img src="<?php echo IMAGE_DEFAULT ?>"/>
			<?php } ?>
		</a>
	</div>
	<div class="item-content">
		<div class="title-info">
			<h4 class="post-title">
				<a title="<?php echo $v->product_name?><?php echo ' - '.WEB_SITE ?>" href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>"><?php echo $v->product_name?></a>
			</h4>
			<div class="item-price">
        		<?php if($v->product_type_price == 2){?>
        			<span class="amount-call">Liên hệ:
        				<a title="<?php echo $v->user_shop_name ?>" class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($v->user_shop_id, $v->user_shop_name, 0, '') ?>">
	                		<?php echo $v->user_shop_name ?>
	                	</a>
        			</span>
        		<?php }else{?>
            		<?php if($v->product_price_sell > 0){?>
                		<span class="amount-1"><?php echo number_format($v->product_price_sell)?>đ</span>
						
						<?php if($v->product_price_market > 0){?>
						<span class="amount-2"><?php echo number_format($v->product_price_market) ?>đ</span>
						<?php } ?>
						<?php if($v->product_type_price == 1){?>
							<?php if((float)$v->product_price_market > (float)$v->product_price_sell) {?>
						    <span class="sale-off">
						    	-<?php echo number_format(100 - ((float)$v->product_price_sell/(float)$v->product_price_market)*100, 1) ?>%
						    </span>
					    	<?php }?>
					    <?php }?>
			    	<?php }else{ ?>
				    	<span class="amount-call">Liên hệ: 
							<a title="<?php echo $v->user_shop_name ?>" class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($v->user_shop_id, $v->user_shop_name, 0, '') ?>">
		                		<?php echo $v->user_shop_name ?>
		                	</a>
				    	</span>
				     <?php } ?>	
        		<?php } ?>
    		</div>
		</div>
		<?php if($v->product_selloff != ''){?>
        <div class="item-banner"><?php echo $v->product_selloff ?></div>
        <?php } ?>
        <?php if($v->product_type_price == 1){?>
        <div class="mgt5 amount-call">Liên hệ:
        	<a title="<?php echo $v->user_shop_name ?>" class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($v->user_shop_id, $v->user_shop_name, 0, '') ?>">
        		<?php echo $v->user_shop_name ?>
        	</a>
    	</div>
		<?php } ?>

	</div>
</li>
<?php } ?>