<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Thông tin tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<div class="col-lg-3">
				<label class="control-label">User đăng nhập</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Tên đăng nhập" id="user_shop" class="keyword" name="user_shop" value="<?php echo $dataSearch['user_shop'] ?>"/></div>
			</div>
			<div class="col-lg-3">
				<label class="control-label">Tên hiển thị của shop</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Tên hiển thị của shop" id="shop_name" class="keyword" name="shop_name" value="<?php echo $dataSearch['shop_name'] ?>"/></div>
			</div>
			<div class="col-lg-3">
				<label class="control-label">Số điện thoại</label>
				<div><input type="text" class="form-control input-sm" placeholder ="số điện thoại" id="shop_phone" class="keyword" name="shop_phone" value="<?php echo $dataSearch['shop_phone'] ?>"/></div>
			</div>
			<div class="col-lg-3">
				<label class="control-label">Email</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Email" id="shop_email" class="keyword" name="shop_email" value="<?php echo $dataSearch['shop_email'] ?>"/></div>
			</div>

			<div class="col-lg-3 paddingTop10">
				<label class="control-label">Danh mục shop dùng</label>
				<div><select class="form-control input-sm" name="shop_category"><?php echo $optionCategroy;?></select></div>
			</div>
			<div class="col-lg-3 paddingTop10">
				<label class="control-label">Lượt up của shop</label>
				<div><select class="form-control input-sm" name="number_limit_product"><?php echo $optionNumberLimitProduct;?></select></div>
			</div>
			<div class="col-lg-2 paddingTop10">
				<label class="control-label">Trạng thái</label>
				<div><select class="form-control input-sm" name="shop_status"><?php echo $optionStatus;?></select></div>
			</div>
			<div class="col-lg-2 paddingTop10">
				<label class="control-label">Loại shop</label>
				<div><select class="form-control input-sm" name="is_shop"><?php echo $optionIsShop;?></select></div>
			</div>

			<div class="col-lg-2 paddingTop10">
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
                <a href="javascript:void(0)" title="Xóa Xóa" id="deleteMoreItem" class="icon-trash icon-admin red"></a>
                <a href="javascript:void(0)" title="Khóa Shop" id="blockUserMoreItem" class="icon-unlock-alt icon-admin red"></a>
                <a href="javascript:void(0)" title="Mở Shop" id="showUserMoreItem" class="icon-ok icon-admin green"></a>
                <a href="javascript:void(0)" title="Ẩn Shop" id="hideUserMoreItem" class="icon-remove icon-admin red"></a>
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
						<th width="18%">Tên shop</th>
						<th width="23%">Địa chỉ</th>
						<th width="12%">Loại gian hàng</th>
						<th width="5%">Status</th>
						<th width="8%" class="align_center">Online</th>
						<th width="8%" class="align_center">Ngày tạo</th>
						<th width="10%" class="align_center">Action</th>
					</tr>
					</thead>
					<tbody>
					<?php foreach ($result as $key => $item) {?>
						<tr style="padding: 10px 0px;">
							<td><?php echo $key+1 ?></td>
							<td><input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->shop_id ?>" /></td>
							<td>
								<?php
									echo '['.$item->shop_id.'] <a href="'.FunctionLib::buildLinkCategory($item->shop_id, $item->shop_name, 0, '').'" target="_blank" title="Trang chủ shop '.$item->shop_name.'"><b>'.$item->user_shop.'</b></a>';
									echo '<br/>'.$item->shop_phone;
									echo '<br/>'.$item->shop_email;
								?>
							</td>
							<td>
								<?php
									echo '<a href="'.FunctionLib::buildLinkCategory($item->shop_id, $item->shop_name, 0, '').'" target="_blank" title="Trang chủ shop '.$item->shop_name.'"><b>'.$item->shop_name.'</b></a>';
									echo '<br/>'.$item->shop_category_name;
								?>
							</td>
							<td><?php echo $item->shop_address; ?></td>
							<td><?php echo isset($arrIsShop[$item->is_shop])? $arrIsShop[$item->is_shop].' ('.$item->number_limit_product.')': 'Chưa chọn loại Shop' ?></td>
							<td class="align_center">
								<?php
									if($item->shop_status == STASTUS_SHOW){
										echo '<i class="icon-ok icon-admin green"></i>';
									}elseif($item->shop_status == STASTUS_HIDE){
										echo '<i class="icon-remove icon-admin red"></i>';
									}else{
										echo '<i class="icon-unlock-alt icon-admin red"></i>';
									}
								?>
							</td>
							<td class="align_center">
								<?php
									echo ($item->is_login == SHOP_ONLINE)? '<i class="icon-smile icon-admin green"></i> <br/>'.date('H:i:s d-m-Y',$item->shop_time_login): '<i class="icon-meh icon-admin red"></i><br/>'.date('H:i:s d-m-Y',$item->shop_time_logout);
								?>
							</td>
							<td class="align_center"><?php echo date('H:i:s d-m-Y',$item->shop_created); ?></td>
							<td class="align_center">
								<?php $linkLoginAs = $base_url.'/admincp/techloginas?shop='.$item->user_shop ?>
								<a target="_blank" href="<?php echo $linkLoginAs; ?>" title="Tech login as"><i class="icon-signin icon-admin green "></i></a>
								<br/>
								<?php $linkEdit = $base_url.'/admincp/usershop/edit/'.$item->shop_id; ?>
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
		DELETE_ITEM.init('admincp/usershop');
		BLOCK_USER_SHOP.init('admincp/usershop');
		SHOW_USER_SHOP.init('admincp/usershop');
		HIDE_USER_SHOP.init('admincp/usershop');
	});
</script>
