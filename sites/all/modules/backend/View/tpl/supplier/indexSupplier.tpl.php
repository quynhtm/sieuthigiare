<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<input type="text" id="supplier_full_name" class="keyword" name="supplier_full_name" value="<?php echo $dataSearch['supplier_full_name'] ?>"/>
			<select class="box-select" name="supplier_status">
				<option value="0" <?php if($dataSearch['supplier_status']==0){?>selected="selected"<?php } ?>>Ẩn</option>
				<option value="1" <?php if($dataSearch['supplier_status']==1){?>selected="selected"<?php } ?>>Hiện</option>
			</select>
			<input type="submit" id="btnSearch" class="btn btn-primary" value="<?php echo t('Tìm kiếm')?>">
		</form>
	</div>
</div>
<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5><?php
					if(isset($title)){
						echo $title;
					}else{
						echo t('Quản lý bài viết');
					}
				?></h5>
			<span class="tools">
                <a href="javascript:void(0)" title="Delete" id="deleteMoreItem" class="icon-remove"></a>
           </span>
		</div>
	</div>
	<div class="page-content-box">
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
						<td><input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->id ?>" /></td>
						<td>
							<?php
								echo $item->supplier_full_name;
							?>
						</td>
						<td><?php echo $item->supplier_phone; ?></td>
						<td><?php echo $item->supplier_hot_line; ?></td>

						<td><?php echo $item->supplier_email; ?></td>
						<td><?php echo $item->supplier_website; ?></td>
						<td><?php echo date('d-m-Y h:i',$item->supplier_created); ?></td>
						<td>
							<a class="icon huge" id="deleteOneItem" href="javascript:void(0)" title="Delete Item"><i class="icon-remove"></i></a>
						</td>
					</tr>
					<?php }?>
					</tbody>
				</table>

				<input  type="hidden" name="txtFormName" value="txtFormName"/>
			</div>
		</form>
		<div class="show-bottom-info">
			<div class="total-rows"><?php echo t('Tổng số item ')?> <?php echo $totalItem ?></div>
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
