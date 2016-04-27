<?php global $base_url;?>
<div class="main-manager-shop">
	<div class="header">
		<?php require_once(DRUPAL_ROOT.'/'.path_to_theme().'/View/tpl/shopHeader.tpl.php') ?>
	</div>
	<div class="content">
		<div class="wrapp-shop">
			<div class="col-lg-12">

			</div>
			<div class="list-shop-show">
				<div class="title-table-shop-shop">Danh sách liên hệ đã gửi cho quản trị site</div>
				<div class="show-box-paging">
					<div class="col-lg-12">
						<b><?php echo t('Tổng số: ')?> <?php echo $totalItem ?></b>
						<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
							<div style="text-align: right">
								<a href="<?php echo $base_url?>/gui-lien-he.html" class="btn btn-warning">Gửi liên hệ</a>
							</div>
						</form>
					</div>
					<div class="showListPage">
						<?php print render($pager); ?>
					</div>
				</div>
				<form id="formListItem" method="post" action='<?php echo $base_url?>/xoa-san-pham'>
					<div class="showListItem">
						<table class="table" width="100%" cellpadding="5" cellspacing="1" border="1">
							<thead>
							<tr>
								<th width="5%">STT</th>
								<th width="15%">Thông tin sản phẩm</th>
								<th width="30%">Thông tin khách hàng</th>
								<th width="30%">Ghi chú của khách</th>
								<th width="10%">Tình trạng ĐH</th>
								<th width="10%">Ngày đặt</th>
							</tr>
							</thead>
							<tbody>
								<?php
								if(!empty($result)){
									foreach($result as $k=>$item) {?>
									<tr>
										<td><?php echo $k+1 ?></td>
										<td>
											<?php
												echo '<b>Sản phẩm: </b>['.$item->order_product_id.'] <a href="'.FunctionLib::buildLinkDetail($item->order_product_id, $item->order_product_name).'" target="_blank" title="Trang chủ shop '.$item->order_product_name.'">'.$item->order_product_name.'</a><br/>';
												echo '<b>Danh mục:</b> '.$item->order_category_name.'<br/>';
												if($item->order_product_type_price == TYPE_PRICE_NUMBER && $item->order_product_price_sell > 0){
													echo 'Giá bán: <b class="price_sell">'.FunctionLib::numberFormat($item->order_product_price_sell). 'đ</b><br/>';
												}else{
													echo 'Giá liên hệ với shop<br/>';
												}
												echo '<b>Số lượng mua:</b> '.$item->order_quality_buy;
											?>
										</td>
										<td>
											<?php

												echo 'Name: <b>'.$item->order_customer_name.'</b> <br/>';
												echo 'Phone: <b>'.$item->order_customer_phone.'</b> <br/>';
												echo 'Email: <b>'.$item->order_customer_email.'</b> <br/>';
												echo 'Địa chỉ: '.$item->order_customer_address.'<br/>';
											?>
										</td>
										<td><?php echo $v->order_customer_note ?></td>
										<td><?php echo isset($arrStatus[$v->order_status])?$arrStatus[$v->order_status]:'Đơn hàng mới' ?></td>
										<td><?php echo date('d-m-Y',$v->order_time)?></td>
									</tr>
								<?php } } ?>
							</tbody>
						</table>
					</div>
				</form>
				<div class="show-box-paging">
					<div class="total-rows"><b><?php echo t('Tổng số: ')?> <?php echo $totalItem ?></b></div>
					<div class="showListPage">
						<?php print render($pager); ?>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
