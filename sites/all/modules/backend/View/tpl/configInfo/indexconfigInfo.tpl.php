<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<input type="text" placeholder ="Tiêu đề" id="title" class="keyword" name="title" value="<?php echo $dataSearch['title'] ?>"/>
			<select class="box-select" name="status"><?php echo $optionStatus;?></select>
			<button class="btn btn-primary" name="submit" value="1">Tìm kiếm</button>
		</form>
	</div>
</div>
<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php
					if(isset($title)){
						echo $title;
					}else{
						echo t('Quản lý bài viết');
					}
				?></h5>
			<span class="menu_tools">
				<a href="<?php echo $base_url; ?>/admincp/configinfo/add" title="Add" class="icon-plus icon-admin green"></a>
                <a href="javascript:void(0)" title="Delete" id="deleteMoreItem" class="icon-trash icon-admin red"></a>
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
						<th width="70%">Tiêu đề</th>
						<th width="10%">Ngày tạo</th>
						<th width="5%">Status</th>
						<th width="20%">Action</th>
					</tr>
					</thead>
					<tbody>
					<?php foreach ($result as $key => $item) {?>
					<tr>
						<td><?php echo $key+1 ?></td>
						<td><input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->id ?>" /></td>
						<td><?php echo $item->title; ?></td>
						<td><?php echo date('d/m/Y h:i', $item->created); ?></td>
						<td>
							<?php
							if($item->status == 1){
								$status='<i class="icon-ok icon-admin green "></i>';
							}else{
								$status='<i class="icon-remove icon-admin red "></i></a>';
							}
							echo $status;
							?>
						</td>
						<td>
							<?php $linkEdit = $base_url.'/admincp/configinfo/edit/'.$item->id; ?>
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
		DELETE_ITEM.init('admincp/configinfo');
	});
</script>