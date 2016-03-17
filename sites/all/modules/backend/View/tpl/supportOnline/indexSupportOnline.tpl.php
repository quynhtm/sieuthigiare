<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title"><?php echo t('Tìm kiếm bài viết')?>:</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<input type="text" id="keyword" class="keyword" name="keyword" />
			<select class="box-select" name="status">
				<option>--Chọn trạng thái--</option>
				<option value="0">Ẩn</option>
				<option value="1">Hiện</option>
			</select>
			<input type="submit" id="btnSearch" class="btnSearch" value="<?php echo t('Tìm kiếm')?>">
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
				<a href="<?php echo $base_url; ?>/admincp/supportOnline/add" title="Add" class="icon-add"></a>
                <a href="javascript:void(0)" title="Delete" id="deleteMoreItem" class="icon-delete"></a>
           </span>
		</div>
	</div>
	<div class="page-content-box">
		<form id="formListItem"  name="txtForm" action="" method="post">
			<div class="showListItem">
				<table class="table table-bordered table-hover table-striped" width="100%" cellpadding="5" cellspacing="1" border="1">
					<thead>
					<tr>
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
						<td><input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->id ?>" /></td>
						<td><?php echo $item->title; ?></td>
						<td><?php echo $item->mobile; ?></td>
						<td><?php echo $item->skyper; ?></td>
						<td><?php echo $item->yahoo; ?></td>
						<td><?php echo date('d-m-Y h:i',$item->created); ?></td>
						<td><?php echo $item->order_no; ?></td>
						<td>
							<?php
								if($item->status==1){
									$status='<span class="bg-status-show">'.t('Hiện').'</span>';
								}else{
									$status='<span class="bg-status-hidden">'.t('Ẩn').'</span>';
								}
							echo $status;
							?>
						</td>
						<td>
							<?php $linkEdit = $base_url.'/admincp/supportOnline/edit/'.$item->id; ?>
							<a class="icon huge" href="<?php echo $linkEdit; ?>"  title="Update Item"><i class="icon-pencil bgLeftIcon"></i></a>
							<a class="icon huge" id="deleteOneItem" href="javascript:void(0)" title="Delete Item"><i class="icon-remove bgLeftIcon"></i></a>
						</td>
					</tr>
					<?php }?>
					</tbody>
				</table>

				<input  type="hidden" name="txtFormName" value="txtFormName"/>
			</div>
		</form>
		<div class="show-bottom-info">
			<div class="total-rows"><?php echo t('Tổng số bài viết')?> <?php echo $totalItem ?></div>
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
