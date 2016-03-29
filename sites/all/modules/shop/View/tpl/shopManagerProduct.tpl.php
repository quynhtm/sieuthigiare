<?php 
	global $base_url, $user_shop;
?>
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
								<label class="control-label">Tên Sản phẩm</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Tên sản phẩm" name="product"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Giá sản phẩm</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Giá sản phẩm" name="price"/></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Danh mục</label>
								<div><select class="form-control input-sm" name="category"></select></div>
							</div>
							<div class="form-group">
								<label class="control-label">Trạng thái</label>
								<div><select class="form-control input-sm" name="status"></select></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Ngày bắt đầu</label>
								<div><input type="text" class="form-control input-sm date" placeholder ="Ngày bắt đầu" name="date_start"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Ngày kết thúc</label>
								<div><input type="text" class="form-control input-sm date" placeholder ="Ngày kết thúc" name="date_end"/></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">&nbsp;</label>
								<div>
									<button class="btn btn-primary" name="submit" value="1">Tìm kiếm</button>
									<a href="<?php echo $base_url?>/dang-san-pham.html" class="btn btn-warning">Thêm mới</a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="list-shop-show">
				<div class="title-table-shop-shop">Danh sách sản phẩm đăng bán</div>
				<div class="show-box-paging">
					<div class="total-rows"><b><?php echo t('Tổng số: ')?> <?php echo $totalItem ?></b></div>
					<div class="showListPage">
						<?php print render($pager); ?>
					</div>
				</div>
				<div class="showListItem">
					<table class="table taicon-adminble-bordered table-hover table-striped" width="100%" cellpadding="5" cellspacing="1" border="1">
						<thead>
						<tr>
							<th width="5%">Ảnh</th>
							<th width="2%">Chọn<br/><input type="checkbox" id="checkAll"/></th>
							<th width="">Tên sản phẩm</th>
							<th width="">Danh mục</th>
							<th width="">Giá thị trường</th>
							<th width="">Giá bán</th>
							<th width="">Mô tả</th>
							<th width="">Ngày tạo</th>
							<th width="">Trạng thái</th>
							<th width="">Thao tác</th>
						</tr>
						</thead>
						<tbody>
							<?php foreach($result as $k=>$v) {?>
							<tr>
								<td></td>
								<td><input type="checkbox" value="<?php echo $v->id?>"/></td>
								<td><?php echo $v->product_name ?></td>
								<td></td>
								<td>
									<?php 
										$price_market = number_format($v->product_price_market);
										if($price_market == 0){
											echo "Không có";
										}else{
											echo $price_market;
										}
									?>
								</td>
								<td>
									<?php 
										$price_sell = number_format($v->product_price_sell);
										if($price_sell == 0){
											echo "Liên hệ";
										}else{
											echo $price_sell;
										}
									?>
								</td>
								<td><?php echo $v->product_content ?></td>
								<td><?php echo date('d/m/Y h:i', $v->time_created)?></td>
								<td>
									<?php
									if($v->status == 1){
										$status='<i class="icon-ok font-size-20 green "></i>';
									}else{
										$v='<i class="icon-remove font-size-20 red "></i></a>';
									}
									echo $status;
									?>
								</td>
								<td>
								<?php $linkEdit = $base_url.'/cap-nhat-san-pham/'.$v->id; ?>
								<a href="<?php echo $linkEdit; ?>" title="Update Item"><i class="icon-edit green font-size-20"></i></a>
								<a id="deleteOneItem" href="javascript:void(0)" title="Delete Item"><i class="icon-trash font-size-20 red"></i></a>
								</td>
							</tr>
							<?php } ?>
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