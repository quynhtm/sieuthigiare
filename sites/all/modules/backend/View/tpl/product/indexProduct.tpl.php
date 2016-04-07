<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Thông tin tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<div class="col-lg-3">
				<label class="control-label">Id sản phẩm</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Id sản phẩm" id="product_id" class="keyword" name="product_id" value="<?php if(isset($dataSearch['product_name'])){echo $dataSearch['product_name'];}?>"/></div>
			</div>

			<div class="col-lg-3">
				<label class="control-label">Trạng thái</label>
				<div><select class="form-control input-sm" name="product_status"><?php echo $optionStatus;?></select></div>
			</div>

			<div class="col-lg-3">
				<label class="control-label">&nbsp;</label>
				<div><button class="btn btn-primary" name="submit" value="1">Tìm kiếm</button></div>
			</div>
		</form>
	</div>
</div>

<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php echo (isset($title)) ? $title: t('Quản lý sản phẩm');?></h5>
			<span class="menu_tools">
				<a href="<?php echo $base_url; ?>/admincp/product/add" title="Thêm mới" class="icon-plus icon-admin green"></a>
                <a href="javascript:void(0)" title="Xóa item" id="deleteMoreItem" class="icon-trash icon-admin red"></a>
           </span>
		</div>
	</div>
	<div class="page-content-box">
		<div class="show-bottom-info">
			<div class="total-rows"><b><?php echo t('Tổng số: ')?> <?php echo $totalItem ?></b></div>
			<div class="list-item-page">
				<div class="showListPage">
					<?php print render($pager); ?>
				</div>
			</div>
		</div>
		<form id="formListItem"  name="txtForm" action="" method="post">
			<div class="showListItem">
				<table class="table taicon-adminble-bordered table-hover table-striped" width="100%" cellpadding="5" cellspacing="1" border="1">
					<thead>
					<tr>
						<th width="2%"class="td_list">STT <input type="checkbox" id="checkAll"/></th>
						<th width="6%" class="td_list">Ảnh</th>
						<th width="35%" class="td_list">Tên sản phẩm</th>
						<th width="20%" class="td_list">Thông tin giá</th>
						<th width="6%" class="td_list">Status</th>
						<th width="14%" class="td_list">Action</th>
					</tr>
					</thead>
					<tbody>
					<?php if(!empty($result)) {?>
						<?php foreach ($result as $key => $item) {?>
						<tr>
							<td>
								<?php echo $key+1 ?><br/>
								<input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->product_id ?>" />
							</td>
							<td>
								<?php if( isset($item->url_image)) {?>
								<div style="position: relative;">
									<div style="position: relative; z-index: 10">
										<img src="<?php echo $item->url_image ?>" class='imge_hover' id='<?php echo $item->product_id ?>' height="80" width="80"/>
									</div>
									<div id='div_hover_<?php echo $item->product_id ?>'style="position: absolute; bottom: 30px; left: 40px; border: 2px solid #ccc; padding: 5px; background: #F4F9FF; z-index: 1000; display: none">
										<img src="<?php echo $item->url_image ?>" height="150" width="150"/>
									</div>
								</div>
								<?php } else{?>
									<img src="<?php echo IMAGE_DEFAULT ?>" width="60px"/>
								<?php }?>
							</td>

							<td>
								<?php
								echo '<b>P: </b>['.$item->product_id.'] '.$item->product_name.'<br/>';
								echo ($item->category_id > 0)?'<b>C: </b>['.$item->category_id.'] '.$item->category_name.'<br/>': '';
								echo ($item->user_shop_id > 0)?'<b>S: </b>['.$item->user_shop_id.'] '.$item->user_shop_name.'<br/>': '';
								?>
							</td>

							<td>
								<?php
									if($item->product_type_price == TYPE_PRICE_NUMBER){
										echo ($item->product_price_sell > 0)?'Giá bán: <b>'.FunctionLib::numberFormat($item->product_price_sell).'đ</b><br/>': '';
										echo ($item->product_price_market > 0)?'Giá TT: <b>'.FunctionLib::numberFormat($item->product_price_market).'đ</b><br/>': '';
										echo ($item->product_price_input > 0)?'Nhập: <b>'.FunctionLib::numberFormat($item->product_price_input).'đ</b><br/>': '';
									}else{
										echo 'Liên hệ với shop';
									}
								?>
							</td>

							<td><?php echo isset($arrProductStatus[$item->product_status])? $arrProductStatus[$item->product_status]:'chưa xác đinh'; ?></td>
							<td>
								<?php $linkEdit = $base_url.'/admincp/product/edit/'.$item->product_id; ?>
								<a href="<?php echo $linkEdit; ?>" title="Update Item"><i class="icon-edit icon-admin green "></i></a>
								<a id="deleteOneItem" href="javascript:void(0)" title="Delete Item"><i class="icon-trash icon-admin red"></i></a>
							</td>
						</tr>
						<?php }?>
					<?php }?>
					</tbody>
				</table>
				<input  type="hidden" name="txtFormName" value="txtFormName"/>
			</div>
		</form>
		<div class="show-bottom-info">
			<div class="total-rows"><b><?php echo t('Tổng số: ')?> <?php echo $totalItem ?></b></div>
			<div class="list-item-page">
				<div class="showListPage">
					<?php print render($pager); ?>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	jQuery(document).ready(function(){
		//hover view anh
		jQuery(".imge_hover").mouseover(function() {
			var id = jQuery(this).attr('id');
			jQuery("#div_hover_" + id).show();
		});
		jQuery(".imge_hover").mouseout(function() {
			var id = jQuery(this).attr('id');
			jQuery("#div_hover_" + id).hide();
		});
		DELETE_ITEM.init('admincp/product');
	});
</script>
