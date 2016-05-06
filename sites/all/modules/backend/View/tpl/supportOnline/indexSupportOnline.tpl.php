<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<div class="col-lg-3">
				<label class="control-label">Tên tỉnh thành</label>
				<div><input type="text" placeholder ="Tiêu đề" id="title" class="form-control input-sm" name="title" value="<?php echo $dataSearch['title'] ?>"/></div>
			</div>
			<div class="col-lg-3">
				<label class="control-label">Trạng thái</label>
				<div><select class="form-control input-sm" name="status"><?php echo $optionStatus;?></select></div>
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
			<h5 class="padding10"><?php
					if(isset($title)){
						echo $title;
					}else{
						echo t('Quản lý bài viết');
					}
				?></h5>
			<span class="menu_tools">
				<a href="<?php echo $base_url; ?>/admincp/supportonline/add" title="Add" class="icon-plus icon-admin green"></a>
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
							<th width="10%">Tiêu đề</th>
							<th width="10%">Mobile</th>
							<th width="10%">Skype</th>

							<th width="10%">Yahoo</th>
							<th width="10%">Ngày tạo</th>
							<th width="10%">Vị trí</th>

							<th width="10%">Trạng thái</th>
							<th width="10%">Action</th>
						</tr>
					</thead>
					<tbody>
						<?php foreach ($result as $key => $item) {?>
						<tr>
							<td><?php echo $key+1; ?></td>
							<td><input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->id ?>" /></td>
							<td><?php echo $item->title; ?></td>
							<td><?php echo $item->mobile; ?></td>
							<td><?php echo $item->skyper; ?></td>
							<td><?php echo $item->yahoo; ?></td>
							<td><?php echo date('d-m-Y h:i',$item->created); ?></td>
							<td><?php echo $item->order_no; ?></td>
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
								<?php $linkEdit = $base_url.'/admincp/supportonline/edit/'.$item->id; ?>
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
		DELETE_ITEM.init('admincp/supportonline');
	});
</script>