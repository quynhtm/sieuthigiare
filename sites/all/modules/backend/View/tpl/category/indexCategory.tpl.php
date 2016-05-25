<div class="search-box" style="display: none">
	<div class="wrapp-search-box">
		<div class="search-box-title">Thông tin tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<div class="col-lg-3">
				<label class="control-label">Tên danh mục</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Tên danh mục" id="category_name" class="keyword" name="category_name" value="<?php echo $dataSearch['category_name'] ?>"/></div>
			</div>

			<div class="col-lg-3">
				<label class="control-label">Danh mục cha</label>
				<div><select class="form-control input-sm" name="category_parent_id"><?php echo $optionCategoryParent;?></select></div>
			</div>

			<div class="col-lg-3">
				<label class="control-label">Hiện ở trang chủ</label>
				<div><select class="form-control input-sm" name="category_content_front"><?php echo $optionShowContent;?></select></div>
			</div>

			<div class="col-lg-3">
				<label class="control-label">Trạng thái</label>
				<div><select class="form-control input-sm" name="category_status"><?php echo $optionStatus;?></select></div>
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
				<a href="<?php echo $base_url; ?>/admincp/category/add" title="Thêm mới" class="icon-plus icon-admin green"></a>
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
						<th width="2%"class="td_list">STT</th>
						<th width="1%" class="td_list"><input type="checkbox" id="checkAll"/></th>
						<th width="30%" class="td_list">Tên danh mục</th>
						<th width="20%" class="td_list">Danh mục cha</th>
						<th width="10%" class="td_list">Show SP home (vịtri)</th>
						<th width="8%" class="td_list">Vị trí</th>
						<th width="5%" class="td_list">Status</th>
						<th width="5%" class="td_list">Action</th>
					</tr>
					</thead>
					<tbody>
					<?php foreach ($result as $key => $item) {?>
					<tr <?php if($item['category_parent_id'] == 0){ echo 'style="background-color:#E0E0E0 !important "';}?> >
						<td><?php echo $key+1 ?></td>
						<td><input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item['category_id'] ?>" /></td>
						<td><?php echo $item['padding_left'].$item['category_name']; ?></td>
						<td><?php echo '['.$item['category_parent_id'].'] '.$item['category_parent_name']; ?></td>
						<td>
							<?php
							if($item['category_parent_id'] == 0){
								echo $arrShowContent[$item['category_content_front']].' ('.$item['category_content_front_order'].')';
							}else{
								echo '-----';
							}
							?>
						</td>
						<td><?php echo $item['category_order']; ?></td>
						<td>
							<?php echo ($item['category_status']== STASTUS_SHOW )? '<i class="icon-ok icon-admin green"></i>': '<i class="icon-remove icon-admin red"></i>'; ?>
						</td>
						<td>
							<?php $linkEdit = $base_url.'/admincp/category/edit/'.$item['category_id']; ?>
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
		DELETE_ITEM.init('admincp/category');
	});
</script>
