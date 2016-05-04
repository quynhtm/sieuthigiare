<?php 
	global $base_url; 
?>
<div class="container">
	<div class="link-breadcrumb">
		<a href="<?php echo $base_url; ?>">Trang chủ</a>
		<i class="icon-double-angle-right"></i>
		<a href="<?php echo $base_url ?>/san-pham-moi.html" title="Sản phẩm mới">Sản phẩm mới</a>
	</div>
	<div class="main-view-post">
		<div id="main-product-new" class="content-list-item w-home">
			<?php if(!empty($result)){ ?>
				<ul>
					<?php foreach($result as $v){?>
					<li class="item">
						<div class="post-thumb">
							<a href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>" title="<?php echo $v->product_name?>">
								<?php if(isset($v->product_image) && $v->product_image != ''){?>
								<img src="<?php echo FunctionLib::getThumbImage($v->product_image,$v->product_id,FOLDER_PRODUCT,300,300) ?>" 
									 alt="<?php echo $v->product_name.' - shopcuatui.com.vn'; ?>">
								<?php }else{ ?>
								<img src="<?php echo IMAGE_DEFAULT ?>"/>
								<?php } ?>
							</a>
						</div>
						<div class="item-content">
							<div class="title-info">
								<h4 class="post-title">
									<a title="<?php echo $v->product_name?>" href="<?php echo FunctionLib:: buildLinkDetail($v->product_id, $v->product_name); ?>"><?php echo $v->product_name?></a>
								</h4>
								<div class="item-price">
		                    		<?php if($v->product_type_price == 2){?>
		                    			<span class="amount-call">Liên hệ:
		                    				<a class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($v->user_shop_id, $v->user_shop_name, 0, '') ?>">
						                		<?php echo $v->user_shop_name ?>
						                	</a>
		                    			</span>
		                    		<?php }else{?>
		                        		<?php if($v->product_price_sell > 0){?>
		                            		<span class="amount-1"><?php echo number_format($v->product_price_sell)?>đ</span>
											
											<?php if($v->product_price_market > 0){?>
											<span class="amount-2"><?php echo number_format($v->product_price_market) ?>đ</span>
											<?php } ?>
											
											<?php if((float)$v->product_price_market > (float)$v->product_price_sell) {?>
										    <span class="sale-off">
										    	-<?php echo number_format(100 - ((float)$v->product_price_sell/(float)$v->product_price_market)*100, 1) ?>%
										    </span>
									    	<?php }?>
								    	<?php }else{ ?>
									    	<span class="amount-call">Liên hệ: <i class="num-call"><?php echo $phone ?></i></span>
									     <?php } ?>	
		                    		<?php } ?>
		                		</div>
							</div>
							<?php if($v->product_selloff != ''){?>
			                <div class="item-banner"><?php echo $v->product_selloff ?></div>
			                <?php } ?>
			                <?php if($v->product_type_price == 1){?>
			                <div class="mgt5 amount-call">Liên hệ:
			                	<a class="link-shop" href="<?php echo FunctionLib::buildLinkCategory($v->user_shop_id, $v->user_shop_name, 0, '') ?>">
			                		<?php echo $v->user_shop_name ?>
			                	</a>
			            	</div>
							<?php } ?>

						</div>
					</li>
					<?php } ?>
				</ul>
				<div class="loadProductNew">
					<input type="hidden" name="totalPage" id="totalPage" value="<?php echo $totalPage ?>">
					<input type="hidden" name="currentPage" id="currentPage" value="<?php echo $currentPage ?>">
				</div>

			<?php }else{ ?>
				<div class="not-product"><?php echo NOT_PRODUCT ?></div>
			<?php } ?>
	</div>
	</div>
</div>