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
								<div><input type="text" class="form-control input-sm" placeholder ="Mã sản phẩm" name="product_id" value="<?php if(isset($dataSearch['product_id']) && $dataSearch['product_id'] > 0){echo $dataSearch['product_id'];} ?>"/></div>
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
							<th width="5%" class="td_list">Ảnh</th>
							<th width="23%" class="td_list">[Mã] Tên sản phẩm</th>
							<?php if($is_shop_vip){?>
							<th width="20%" class="td_list">Nhà cung cấp</th>
							<?php }?>
							<th width="15%" class="td_list">Giá bán</th>
							<th width="12%" class="td_list">Danh mục</th>
							<th width="10%" class="td_list">Mô tả ngắn</th>
							<th width="6%" class="td_list">Trạng thái</th>
							<th width="15%" class="td_list align_center" >Thao tác</th>
						</tr>
						</thead>
						<tbody>
							<?php foreach($result as $k=>$v) {?>
							<tr>
								<td style="">
									<?php if( isset($v->product_image) && $v->product_image != '') {?>
									<div style="position: relative; margin: 15px 0px">
										<div style="position: relative; z-index: 10">
											<img height="80" width="80" src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $v->product_id, $v->product_image, 80, 80, '', true, true) ?>" class='imge_hover' id='<?php echo $v->product_id ?>'/>
										</div>
										<div id='div_hover_<?php echo $v->product_id ?>'style="position: absolute; bottom: 30px; left: 40px; border: 2px solid #ccc; padding: 5px; background: #F4F9FF; z-index: 1000; display: none">
											<img src="<?php echo ThumbImg::thumbBaseNormal(FOLDER_PRODUCT, $v->product_id, $v->product_image_hover, 300, 300, '', true, true) ?>"/>
										</div>
									</div>
									<?php } else{?>
										<img src="<?php echo IMAGE_DEFAULT ?>" width="80px"/>
									<?php }?>

								</td>
								<td>
									<?php
										echo '['.$v->product_id.'] <a href="'.FunctionLib::buildLinkDetail($v->product_id,$v->product_name).'" target="_blank" title="Chi tiết sản phẩm">'.$v->product_name.'</a>';
										echo '<br/>Ngày tạo: '.date('d/m/Y h:i', $v->time_created);
									?>
								</td>
								<?php if($is_shop_vip){
										$inforNcc = DataCommon::getProviderById($v->provider_id); ?>
									<td>
										<?php
										if($inforNcc){
											echo $inforNcc->provider_name;
											echo '<br/>'.$inforNcc->provider_phone;
											echo '<br/>'.$inforNcc->provider_email;
											echo '<br/>'.$inforNcc->provider_address;
										}
										?>
									</td>
								<?php }?>

								<td>
									<?php

									$price_sell = FunctionLib::numberFormat($v->product_price_sell);
									if($price_sell == 0){
										echo "<br/>Giá liên hệ";
									}else{
										echo '<br/>Giá bán: <b class="price_sell">'.$price_sell.'đ</b>';
									}

									$price_market = FunctionLib::numberFormat($v->product_price_market);
									if($price_market > 0){
										echo '<br/>Giá thị trường: <b>'.$price_market.'đ</b>';
									}

									$product_price_input = FunctionLib::numberFormat($v->product_price_input);
									if($product_price_input > 0){
										echo '<br/>Giá nhập: <b>'.$product_price_input.'đ</b>';
									}
									?>
								</td>
								<td><?php echo $v->category_name ?></td>
								<td><?php echo Utility::substring($v->product_content, $length = 200, $replacer='...')?></td>


								<td class="align_center">
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
								<td class="align_center">
									<?php $linkEdit = $base_url.'/sua-san-pham/'.$v->product_id.'/'.Stdio::pregReplaceStringAlias($v->product_name).'.html' ?>
									<a href="<?php echo $linkEdit; ?>" title="sửa"><i class="icon-edit green font-size-20"></i></a>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="<?php echo $base_url.'/xoa-san-pham?id='.$v->product_id ?>" class="deleteItem" title="Xóa"><i class="icon-trash font-size-20 red"></i></a>
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
<script>
	jQuery(document).ready(function($){
		//hover view anh
		jQuery(".imge_hover").mouseover(function() {
			var id = jQuery(this).attr('id');
			jQuery("#div_hover_" + id).show();
		});
		jQuery(".imge_hover").mouseout(function() {
			var id = jQuery(this).attr('id');
			jQuery("#div_hover_" + id).hide();
		});

		jQuery('a.deleteItem').click(function(){
			if (confirm('Bạn muốn xóa [OK]:Đồng ý [Cancel]:Bỏ qua?)')){
				return true;
			}
			return false;
		});
		jQuery('.date').datetimepicker({
			timepicker:false,
 			format:'d/m/Y',
 			lang:'vi'
		});
	});
</script>