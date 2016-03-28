<?php 
	global $base_url, $user_shop;
?>
<div class="main-manager-shop">
	<div class="header">
		<div class="wrapp-shop">	
			<div class="left-head-shop">
				<i class="icon-dashboard"></i>
				<div class="navigator">
					<ul>
						<li><a href="">Quản lý Shop</a></li>
					</ul>
				</div>
			</div>
			<div class="right-head-shop">
				<?php 
					if($user_shop->shop_id != 0){
						echo ucfirst($user_shop->user_shop);
				 	} 
				 ?>
				<i class="icon-caret-down"></i>
				<div class="panel-user-shop">
					<ul>
						<li><a rel="nofollow" href="">Sửa thông tin</a></li>
						<li><a rel="nofollow" href="">Đổi mật khẩu</a></li>
						<li><a rel="nofollow" href="<?php echo $base_url?>/thoat.html">Thoát</a></li>
					</ul>
				</div>
			</div>
		</div>
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
								<label class="control-label">Mã Sản phẩm</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Mã sản phẩm" name="code"/></div>
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
								<label class="control-label">Tỉnh/thành</label>
								<div><select class="form-control input-sm" name="province"></select></div>
							</div>
							<div class="form-group">
								<label class="control-label">Trạng thái</label>
								<div><select class="form-control input-sm" name="status"></select></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Ngày tạo</label>
								<div><input type="text" class="form-control input-sm date" placeholder ="Ngày tạo" name="date_create" /></div>
							</div>
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
					<div class="total-rows"><b>Tổng số:  65</b></div>
					<div class="showListPage">
						<h2 class="element-invisible">Pages</h2>
						<div class="item-list">
							<ul class="pager">
								<li class="pager-current first">1</li>
								<li class="pager-item"><a href="" title="Go to page 2">2</a></li>
								<li class="pager-item"><a href="" title="Go to page 3">3</a></li>
								<li class="pager-next"><a href="">Sau ›</a></li>
								<li class="pager-last last"><a href="">Trang cuối »</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="showListItem">
					<table class="table taicon-adminble-bordered table-hover table-striped" width="100%" cellpadding="5" cellspacing="1" border="1">
						<thead>
						<tr>
							<th width="5%">Ảnh</th>
							<th width="2%">Chọn<br/><input type="checkbox" id="checkAll"/></th>
							<th width="">[Mã SP] Tên sản phẩm</th>
							<th width="">Danh mục</th>
							<th width="">Tỉnh thành</th>
							<th width="">Giá sản phẩm</th>
							<th width="">Giá bán</th>
							<th width="">Giảm</th>
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
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td><?php number_format($v->product_price_sell)?></td>
								<td></td>
								<td><?php echo date('d/m/Y h:i', $v->time_created)?></td>
								<td></td>
								<td></td>
							</tr>
							<?php } ?>
						</tbody>
					</table>
				</div>
				<div class="show-box-paging">
					<div class="total-rows"><b>Tổng số:  65</b></div>
					<div class="showListPage">
						<h2 class="element-invisible">Pages</h2>
						<div class="item-list">
							<ul class="pager">
								<li class="pager-current first">1</li>
								<li class="pager-item"><a href="" title="Go to page 2">2</a></li>
								<li class="pager-item"><a href="" title="Go to page 3">3</a></li>
								<li class="pager-next"><a href="">Sau ›</a></li>
								<li class="pager-last last"><a href="">Trang cuối »</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>