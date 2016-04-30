<?php global $base_url;?>
<div class="main-manager-shop">
	<div class="header">
		<?php require_once(DRUPAL_ROOT.'/'.path_to_theme().'/View/tpl/shopHeader.tpl.php') ?>
	</div>
	<div class="content">
		<div class="wrapp-shop">
			<div class="box-shop-search">
				<div class="title-box-shop-search">Thông tin tìm kiếm</div>
				<div class="content-box-shop-search">
					<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">ID sản phẩm</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Mã sản phẩm" name="order_product_id" value="<?php if(isset($dataSearch['order_product_id']) && $dataSearch['order_product_id'] > 0){echo $dataSearch['order_product_id'];} ?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Tên Sản phẩm</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Tên sản phẩm" name="order_product_name" value="<?php if(isset($dataSearch['order_product_name'])){echo $dataSearch['order_product_name'];}?>"/></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Tên khách hàng</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Tên khách hàng" name="order_customer_name" value="<?php if(isset($dataSearch['order_customer_name'])){echo $dataSearch['order_customer_name'];} ?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Số điện thoại KH</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Số điện thoại KH" name="order_customer_phone" value="<?php if(isset($dataSearch['order_customer_phone'])){echo $dataSearch['order_customer_phone'];} ?>"/></div>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Tạo từ ngày</label>
								<div><input type="text" class="form-control input-sm date" placeholder ="Ngày bắt đầu" name="date_start" value="<?php echo $dataSearch['date_start'] ?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Tới ngày</label>
								<div><input type="text" class="form-control input-sm date" placeholder ="Ngày kết thúc" name="date_end" value="<?php echo $dataSearch['date_end'] ?>"/></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Email KH</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Email KH" name="order_customer_email" value="<?php if(isset($dataSearch['order_customer_email'])){echo $dataSearch['order_customer_email'];} ?>"/></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Trạng thái</label>
								<div>
									<select class="form-control input-sm" name="order_status">
										<?php echo $optionStatus ?>
									</select>
								</div>
							</div>
							<div class="form-group">
								<div>
									<button class="btn btn-primary" name="submit" value="1">Tìm kiếm</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="list-shop-show">
				<div class="title-table-shop-shop">Danh sách Đơn hàng của shop</div>
				<div class="show-box-paging">
					<div class="col-lg-12">
						<b><?php echo t('Tổng số: ')?> <?php echo $totalItem ?></b>
						<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
							<div style="text-align: right">
								
							</div>
						</form>
					</div>
					<div class="showListPage">
						<?php print render($pager); ?>
					</div>
				</div>
				
				<div class="showListItem showListItemOrder">
					<table class="table" width="100%" cellpadding="5" cellspacing="1" border="1">
						<thead>
						<tr>
							<th width="5%" class="align_center">STT</th>
							<th width="25%">Thông tin sản phẩm</th>
							<th width="20%">Thông tin khách hàng</th>
							<th width="25%">Ghi chú của khách</th>
							<th width="8%" class="align_center">Ngày đặt</th>
							<th width="20%" class="align_center">Tình trạng ĐH</th>
						</tr>
						</thead>
						<tbody>
							<?php
							if(!empty($result)){
								foreach($result as $k=>$item) {?>
								<tr>
									<td class="align_center" style="padding: 10px 0px!important;"><?php echo $k+1 ?></td>
									<td>
										<?php
											echo '<b>SP: </b>['.$item->order_product_id.'] <a href="'.FunctionLib::buildLinkDetail($item->order_product_id, $item->order_product_name).'" target="_blank" title="Trang chủ shop '.$item->order_product_name.'">'.$item->order_product_name.'</a><br/>';
											echo $item->order_category_name.'<br/>';
											if($item->order_product_type_price == TYPE_PRICE_NUMBER && $item->order_product_price_sell > 0){
												echo 'Giá bán: <b class="price_sell">'.FunctionLib::numberFormat($item->order_product_price_sell). 'đ</b><br/>';
											}else{
												echo 'Giá liên hệ với shop<br/>';
											}
											echo 'SL:<b> '.$item->order_quality_buy.'</b> sản phẩm';
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
									<td><?php echo $item->order_customer_note ?></td>
									<td class="align_center"><?php echo date('d-m-Y h:i:s',$item->order_time)?></td>
									<td class="align_center">
										<select name="order_status" class="order-update-status form-control input-sm" data-id="<?php echo $item->order_id ?>">
										<?php 
											echo isset($arrStatus[$item->order_status])? FunctionLib::getOption($arrStatus, $item->order_status):'Đơn hàng mới';
										?>
										</select>
									</td>
								</tr>
							<?php } } ?>
						</tbody>
					</table>
				</div>
				
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
