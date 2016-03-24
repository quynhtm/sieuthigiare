<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<input type="text" id="title" class="keyword" name="title" value="<?php echo $dataSearch['title'] ?>"/>
			<select class="box-select" name="status">
				<option value="0" <?php if($dataSearch['status']==0){?>selected="selected"<?php } ?>>Ẩn</option>
				<option value="1" <?php if($dataSearch['status']==1){?>selected="selected"<?php } ?>>Hiện</option>
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
				<a href="<?php echo $base_url; ?>/admincp/usershop/add" title="Add" class="icon-add"></a>
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
						<th width="1%">STT</th>
						<th width="1%"><input type="checkbox" id="checkAll"/></th>
						<th width="20%">Thông tin shop</th>
						<th width="20%">Tên shop</th>
						<th width="20%">Địa chỉ</th>

						<th width="10%">Trạng thái</th>
						<th width="9%">Online</th>
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
								echo $item->user_name;
								echo '<br/>'.$item->phone;
								echo '<br/>'.$item->email;
							?>
						</td>
						<td><?php echo $item->name_shop; ?></td>
						<td><?php echo $item->address; ?></td>

						<td>
							<?php
								if($item->status == 1){
									echo $status='<span class="bg-status-show">'.t('Action').'</span>';
								}elseif($item->status == 2){
									echo $status='<span class="bg-status-hidden">'.t('Khóa').'</span>';
								}elseif($item->status == 0){
									echo $status='<span class="bg-status-hidden">'.t('Ẩn').'</span>';
								}
							?>
						</td>
						<td>
							<?php
								if($item->is_login == 1){
									echo $is_login ='<span class="bg-status-show">'.t('Online').'</span>';
								}else{
									echo $is_login ='<span class="bg-status-hidden">'.t('Offline').'</span>';
								}
							?>
						</td>

						<td><?php echo date('d-m-Y h:i',$item->created); ?></td>
						<td>
							<?php $linkEdit = $base_url.'/admincp/usershop/edit/'.$item->id; ?>
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
		DELETE_ITEM.init('admincp/usershop');
	});
</script>
