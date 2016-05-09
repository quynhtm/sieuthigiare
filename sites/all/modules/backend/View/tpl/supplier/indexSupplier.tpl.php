<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Thông tin tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<div class="col-lg-2">
				<label class="control-label">Tên NCC</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Tên nhà cung cấp" id="supplier_name" name="supplier_name" value="<?php echo $dataSearch['supplier_name'] ?>"/></div>
			</div>
			<div class="col-lg-2">
				<label class="control-label">Email NCC</label>
				<div><input type="text"class="form-control input-sm"  placeholder ="Email nhà cung cấp" id="supplier_email" name="supplier_email" value="<?php echo $dataSearch['supplier_email'] ?>"/></div>
			</div>
			<div class="col-lg-2">
				<label class="control-label">Phone NCC</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Phone nhà cung cấp" id="supplier_phone" name="supplier_phone" value="<?php echo $dataSearch['supplier_phone'] ?>"/></div>
			</div>
			<div class="col-lg-2">
				<label class="control-label">Trạng thái</label>
				<div><select class="form-control input-sm" name="supplier_status"><?php echo $optionStatus;?></select></div>
			</div>
			<div class="col-lg-2">
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
                <a href="javascript:void(0)" title="Xóa item" id="deleteMoreItem" class="icon-trash icon-admin red"></a>
                <a href="javascript:void(0)" title="Gửi mail nhà cung cấp" id="sendMailSupplier" class="icon-envelope icon-admin red"></a>
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
				<table class="table table-bordered table-hover table-striped" width="100%" cellpadding="5" cellspacing="1" border="1">
					<thead>
					<tr>
						<th width="1%">STT</th>
						<th width="1%"><input type="checkbox" id="checkAll"/></th>
						<th width="20%">Tên NCC</th>
						<th width="15%">Mobifone</th>
						<th width="15%">Hotline</th>

						<th width="10%">Email</th>
						<th width="10%">Website</th>
						<th width="10%">Ngày tạo</th>
						<th width="9%">Action</th>
					</tr>
					</thead>
					<tbody>
					<?php foreach ($result as $key => $item) {?>
						<tr>
							<td><?php echo $key+1; ?></td>
							<td><input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->supplier_id ?>" /></td>
							<td>
								<?php
								echo $item->supplier_name;
								?>
							</td>
							<td><?php echo $item->supplier_phone; ?></td>
							<td><?php echo $item->supplier_hot_line; ?></td>

							<td><?php echo $item->supplier_email; ?></td>
							<td><?php echo $item->supplier_website; ?></td>
							<td><?php echo date('d-m-Y h:i',$item->supplier_created); ?></td>
							<td>
								<?php echo ($item->supplier_status == 1)? '<i class="icon-ok icon-admin green"></i>': '<i class="icon-remove icon-admin red"></i>'; ?>
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
		DELETE_ITEM.init('admincp/supplier');
	});
</script>
