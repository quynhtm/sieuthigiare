<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Thông tin tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<div class="col-lg-3">
				<label class="control-label">Tên tỉnh thành</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Tên tỉnh thành" id="province_name" class="keyword" name="province_name" value="<?php echo $dataSearch['province_name'] ?>"/></div>
			</div>
			<div class="col-lg-3">
				<label class="control-label">Trạng thái</label>
				<div><select class="form-control input-sm" name="province_status"><?php echo $optionStatus;?></select></div>
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
			<h5 class="padding10"><?php echo (isset($title)) ? $title: t('Quản lý bài viết');?></h5>
			<span class="menu_tools">
				<a href="<?php echo $base_url; ?>/admincp/usershop/add" title="Thêm mới" class="icon-plus icon-admin green"></a>
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
						<th width="1%">STT</th>
						<th width="1%"><input type="checkbox" id="checkAll"/></th>
						<th width="20%">Thông tin shop</th>
						<th width="20%">Tên shop</th>
						<th width="20%">Địa chỉ</th>
						<th width="20%">Loại gian hàng</th>
						<th width="10%">Trạng thái</th>
						<th width="9%">Online</th>
						<th width="10%">Ngày tạo</th>
						<th width="9%">Action</th>
					</tr>
					</thead>
					<tbody>
					<?php foreach ($result as $key => $item) {?>
						<tr>
							<td><?php echo $key+1 ?></td>
							<td><input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->shop_id ?>" /></td>
							<td>
								<?php
									echo $item->user_shop;
									echo '<br/>'.$item->shop_phone;
									echo '<br/>'.$item->shop_email;
								?>
							</td>
							<td><?php echo $item->shop_name; ?></td>
							<td><?php echo $item->shop_address; ?></td>
							<td><?php echo ($item->is_shop == 1)? '<i class="green">Vip</i>': '<i class="red">Thường</i>'; ?></td>
							<td>
								<?php echo ($item->shop_status == 1)? '<i class="icon-ok icon-admin green"></i>': '<i class="icon-remove icon-admin red"></i>'; ?>
							</td>
							<td>
								<?php echo ($item->is_login == 1)? '<i class="icon-ok icon-admin green"></i>': '<i class="icon-remove icon-admin red"></i>'; ?>
							</td>
							<td><?php echo date('d-m-Y h:i:s',$item->shop_created); ?></td>
							<td>
								<?php $linkEdit = $base_url.'/admincp/usershop/edit/'.$item->shop_id; ?>
								<a href="<?php echo $linkEdit; ?>" title="Update Item"><i class="icon-edit icon-admin green "></i></a>
								<a id="deleteOneItem" href="javascript:void(0)" title="Delete Item"><i class="icon-trash icon-admin red"></i></a>
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
		DELETE_ITEM.init('admincp/usershop');
	});
</script>
