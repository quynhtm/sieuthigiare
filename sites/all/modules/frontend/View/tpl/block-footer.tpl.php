<?php global $base_url;?>
<div class="top-bg-footer">
	<div class="container">
		<div class="top-footer">
	  		<div class="right-top-footer">
	  			<span>Kết nối với chúng tôi:</span>
	  			<a href="https://plus.google.com/100693074505743994095" rel="nofollow">
	  				<i class="icon-google-plus"></i>
	  			</a>
	  			<a href="https://www.facebook.com/profile.php?id=100012051900214" rel="nofollow">
	  				<i class="icon-facebook"></i>
	  			</a>
	  		</div>
		</div>
		<div class="midd-footer">
		  	<ul>
				<li><span>Về chúng tôi</span></li>
				<?php 
				if(!empty($news_intro)){
				foreach($news_intro as $v){?>
				<li><a title="" href="<?php echo FunctionLib::buildLinkNewsDetail('gioi-thieu', $v->news_id, $v->news_title) ?>" target="_blank" rel="nofollow"><?php echo $v->news_title ?></a></li>
				<?php } } ?>
			</ul>
			<ul>
				<li><span>Dành cho người mua</span></li>
				<?php 
				if(!empty($news_customer)){
				foreach($news_customer as $v){?>
				<li><a title="" href="<?php echo FunctionLib::buildLinkNewsDetail('tin-cua-khach', $v->news_id, $v->news_title) ?>" target="_blank" rel="nofollow"><?php echo $v->news_title ?></a></li>
				<?php } } ?>
			</ul>
			<ul>
				<li><span>Dành cho người bán</span></li>
				<?php 
				if(!empty($news_shop)){
				foreach($news_shop as $v){?>
				<li><a title="" href="<?php echo FunctionLib::buildLinkNewsDetail('tin-cua-shop', $v->news_id, $v->news_title) ?>" target="_blank" rel="nofollow"><?php echo $v->news_title ?></a></li>
				<?php } } ?>
			</ul>
			<ul>
				<li>
					<li><span>ShopCuaTui.com.vn</span></li>
					<div class="address">
					    Địa chỉ: Tòa nhà F4 Trung Kính - Cầu Giấy - Hà Nội<br>
					    <span class="phone">ĐT: <?php echo PHONE_CARE ?></span><br>
					</div>
					<div class="bg-icon-temviewer">
						<a rel="nofollow" href="https://www.teamviewer.com/link/?url=505374&id=756347786"><span>Tải về <br/>TeamViewer</span></a>
					</div>
					<div class="note-footer">
						Chú ý: Shopcuatui.com.vn không bán hàng trực tiếp, quý khách mua hàng xin vui lòng liên lạc với shop.
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>
<div class="bottom-footer">
	<div class="container">
		© 2014 ShopCuaTui.COM.VN - Mua sắm online các mặt hàng: thời trang nam, thời trang nữ, thời trang trẻ em, phụ kiện thời trang, đồ gia dụng... 
	</div>
</div>
<span id="back-to-top">
	<i class="icon-caret-up"></i>
</span>