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
								<div><input type="text" class="form-control input-sm" placeholder ="Mã sản phẩm" name="product_id" value="<?php echo $dataSearch['product_id'] ?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Tên Sản phẩm</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Tên sản phẩm" name="product_name" value="<?php echo $dataSearch['product_name'] ?>"/></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Danh mục</label>
								<div>
									<select class="form-control input-sm" name="category_id">
										<?php echo $optionCategoryChildren ?>	
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label">Trạng thái</label>
								<div>
									<select class="form-control input-sm" name="product_status">
										<?php echo $optionStatus ?>	
									</select>
								</div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Từ ngày</label>
								<div><input type="text" class="form-control input-sm date" placeholder ="Ngày bắt đầu" name="date_start" value="<?php echo $dataSearch['date_start'] ?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Tới ngày</label>
								<div><input type="text" class="form-control input-sm date" placeholder ="Ngày kết thúc" name="date_end" value="<?php echo $dataSearch['date_end'] ?>"/></div>
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
				<form id="formListItem" method="post" action='<?php echo $base_url?>/xoa-san-pham'>
					<div class="showListItem">
						<table class="table" width="100%" cellpadding="5" cellspacing="1" border="1">
							<thead>
							<tr>
								<th width="5%">Ảnh</th>
								<th width="2%">Chọn<br/><input type="checkbox" id="checkAll" onclick="CHECKALL_ITEM.init();"/></th>
								<th width="">[Mã] Tên sản phẩm</th>
								<th width="">Danh mục</th>
								<th width="">Giá bán</th>
								<th width="">Giá thị trường</th>
								<th width="">Mô tả</th>
								<th width="">Ngày tạo</th>
								<th width="">Trạng thái</th>
								<th width="">Thao tác</th>
							</tr>
							</thead>
							<tbody>
								<?php foreach($result as $k=>$v) {?>
								<tr>
									<td>
										<?php if( isset($v->url_image)) {?>
										<div style="position: relative;">
											<div style="position: relative; z-index: 10">
												<img src="<?php echo $v->url_image; ?>" class='imge_hover' id='<?php echo $v->product_id ?>'/>
											</div>
											<div id='div_hover_<?php echo $v->product_id ?>'style="position: absolute; bottom: 30px; left: 40px; border: 2px solid #ccc; padding: 5px; background: #F4F9FF; z-index: 1000; display: none">
												<img src="<?php echo $v->url_image; ?>" height="200" width="200"/>
											</div>
										</div>
										<?php } else{?>
											<img src="<?php echo IMAGE_DEFAULT ?>" width="80px"/>
										<?php }?>

									</td>
									<td><input type="checkbox" class="checkItem" name="id[]" value="<?php echo $v->product_id?>"/></td>
									<td><?php echo $v->product_name ?></td>
									<td><?php echo $v->category_name ?></td>
									<td>
										<?php 
											$price_market = number_format($v->product_price_sell);
											if($price_market == 0){
												echo "Liên hệ với shop";
											}else{
												echo $price_market;
											}
										?>
									</td>
									<td>
										<?php 
											$price_sell = number_format($v->product_price_market);
											if($price_sell == 0){
												echo "Liên hệ";
											}else{
												echo $price_sell;
											}
										?>
									</td>
									<td><?php echo Utility::substring($v->product_content, $length = 100, $replacer='...')?></td>
									<td><?php echo date('d/m/Y h:i', $v->time_created)?></td>
									<td>
										<?php
											$status = '';
											if($v->product_status == 1){
												$status ='<i class="icon-ok font-size-20 green "></i>';
											}else{
												$status ='<i class="icon-remove font-size-20 red "></i></a>';
											}
											echo $status;
										?>
									</td>
									<td>
									<?php $linkEdit = $base_url.'/sua-san-pham/'.$v->product_id.'/'.Stdio::pregReplaceStringAlias($v->product_name).'.html' ?>
									<a href="<?php echo $linkEdit; ?>" title="sửa"><i class="icon-edit green font-size-20"></i></a>
									<a href="javascript:void(0)" class="deleteItem" title="Xóa"><i class="icon-trash font-size-20 red"></i></a>
									</td>
								</tr>
								<?php } ?>
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
<script>
	jQuery(document).ready(function($){
		jQuery('a.deleteItem').click(function(){
			var total = jQuery( ".showListItem tbody input:checked" ).length;
			if(total==0){
				alert('Vui lòng chọn ít nhất 1 bản ghi để xóa!');
				return false;
			}else{
				if (confirm('Bạn muốn xóa [OK]:Đồng ý [Cancel]:Bỏ qua?)')){
					jQuery('form#formListItem').attr("action", BASEPARAMS.base_url+"/xoa-san-pham");
					jQuery('form#formListItem').submit();
					return true;
				}
				return false;
			}
		});
		jQuery('.date').datetimepicker({
			timepicker:false,
 			format:'d/m/Y',
 			lang:'vi'
		});
	});
</script>