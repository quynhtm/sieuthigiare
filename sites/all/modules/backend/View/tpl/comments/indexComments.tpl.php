<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Thông tin tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<div class="paddingTop20">
				<div class="col-lg-3">
					<label class="control-label">Id sản phẩm</label>
					<div><input type="text" class="form-control input-sm" placeholder ="ID sản phẩm" id="comment_product_id" name="comment_product_id" value="<?php echo (isset($dataSearch['comment_product_id']) && $dataSearch['comment_product_id'] > 0) ?$dataSearch['comment_product_id']:''; ?>"/></div>
				</div>
				<div class="col-lg-3">
					<label class="control-label">Tên sản phẩm</label>
					<div><input type="text" class="form-control input-sm" placeholder ="Tên sản phẩm" id="comment_product_name" name="comment_product_name" value="<?php echo (isset($dataSearch['comment_product_name']) && $dataSearch['comment_product_name'] != '') ?$dataSearch['comment_product_name']:''; ?>"/></div>
				</div>
				<div class="col-lg-3">
					<label class="control-label">Id Shop</label>
					<div><input type="text" class="form-control input-sm" placeholder ="ID Shop" id="comment_shop_id" name="comment_shop_id" value="<?php echo (isset($dataSearch['comment_shop_id']) && $dataSearch['comment_shop_id'] > 0) ?$dataSearch['comment_shop_id']:''; ?>"/></div>
				</div>
				<div class="col-lg-3">
					<label class="control-label">Tên sản phẩm</label>
					<div><input type="text" class="form-control input-sm" placeholder ="Tên shop" id="comment_shop_name" name="comment_shop_name" value="<?php echo (isset($dataSearch['comment_shop_name']) && $dataSearch['comment_shop_name'] != '') ?$dataSearch['comment_shop_name']:''; ?>"/></div>
				</div>
			</div>
			<div class="clear"></div>
			<div class="paddingTop10">
				<div class="col-lg-3">
					<label class="control-label">Tên khách bình luận</label>
					<div><input type="text" class="form-control input-sm" placeholder ="Tên khách bình luận" id="comment_customer_name" name="comment_customer_name" value="<?php echo (isset($dataSearch['comment_customer_name']) && $dataSearch['comment_customer_name'] != '') ?$dataSearch['comment_customer_name']:''; ?>"/></div>
				</div>
				<div class="col-lg-3">
					<label class="control-label">Trạng thái</label>
					<div><select class="form-control input-sm" name="comment_status"><?php echo $optionStatus;?></select></div>
				</div>
				<div class="col-lg-3">
					<label class="control-label">Kiểu trả lời</label>
					<div><select class="form-control input-sm" name="comment_is_reply"><?php echo $optionReply;?></select></div>
				</div>
				<div class="col-lg-3">
					<label class="control-label">&nbsp;</label>
					<div><button class="btn btn-primary" name="submit" value="1">Tìm kiếm</button></div>
				</div>
			</div>
		</form>
	</div>
</div>

<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php echo (isset($title)) ? $title: t('Quản lý bài viết');?></h5>
			<span class="menu_tools">
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
						<th width="2%">STT</th>
						<th width="1%"><input type="checkbox" id="checkAll"/></th>
						<th width="20%">Sản phẩm</th>
						<th width="15%">Shop</th>
						<th width="15%">Khách BL</th>
						<th width="40%">Nội dung</th>
						<th width="5%">Reply</th>
						<th width="5%">Status</th>
						<th width="5%">Action</th>
					</tr>
					</thead>
					<tbody>
					<?php foreach ($result as $key => $item) {?>
					<tr>
						<td><?php echo $key+1 ?></td>
						<td><input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->comment_id ?>" /></td>
						<td><?php echo ($item->comment_product_id > 0)?'['.$item->comment_product_id.'] '.$item->comment_product_name : ''; ?></td>
						<td><?php echo ($item->comment_shop_id > 0)?'['.$item->comment_shop_id.'] '.$item->comment_shop_name : ''; ?></td>
						<td><?php echo $item->comment_customer_name; ?></td>
						<td><?php echo $item->comment_content; ?></td>
						<td>
							<?php echo ($item->comment_is_reply == 1)? '<i class="icon-ok icon-admin green"></i>': '<i class="icon-remove icon-admin red"></i>'; ?>
						</td>
						<td>
							<?php echo ($item->province_status == 1)? '<i class="icon-ok icon-admin green"></i>': '<i class="icon-remove icon-admin red"></i>'; ?>
						</td>
						<td>
							<?php $linkEdit = $base_url.'/admincp/province/edit/'.$item->comment_id; ?>
							<a href="<?php echo $linkEdit; ?>" title="Update Item"><i class="icon-edit icon-admin green "></i></a>
						</td>
					</tr>
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
		DELETE_ITEM.init('admincp/comments');
	});
</script>
