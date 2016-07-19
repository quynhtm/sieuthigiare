<?php global $base_url;?>
<div class="main-manager-shop">
	<div class="header">
		<?php require_once(DRUPAL_ROOT.'/'.path_to_theme().'/View/tpl/shopHeader.tpl.php') ?>
	</div>
	<div class="content">
		<div class="wrapp-shop">
			<div class="box-shop-search">
				<div class="title-box-shop-search">Thông tin tìm kiếm</div>
				<div class="content-box-shop-search">
					<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Tên nhà cung cấp</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Tên nhà cung cấp" name="provider_name" value="<?php echo $dataSearch['provider_name'] ?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Trạng thái</label>
								<div>
									<select class="form-control input-sm" name="provider_status">
										<?php echo $optionStatus ?>
									</select>
								</div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Điện thoại</label>
								<div><input type="text" class="form-control input-sm" placeholder ="ĐIện thoại" name="provider_phone" value="<?php echo $dataSearch['provider_phone'] ?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Tạo từ ngày</label>
								<div><input type="text" class="form-control input-sm date" placeholder ="Ngày bắt đầu" name="date_start" value="<?php echo $dataSearch['date_start'] ?>"/></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">Email</label>
								<div><input type="text" class="form-control input-sm" placeholder ="Email" name="provider_email" value="<?php if(isset($dataSearch['provider_email'])){echo $dataSearch['provider_email'];} ?>"/></div>
							</div>
							<div class="form-group">
								<label class="control-label">Tới ngày</label>
								<div><input type="text" class="form-control input-sm date" placeholder ="Ngày kết thúc" name="date_end" value="<?php echo $dataSearch['date_end'] ?>"/></div>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label class="control-label">&nbsp;</label>
								<div>
									<button class="btn btn-primary" name="submit" value="1">Tìm kiếm</button>
									<a href="<?php echo $base_url?>/them-nha-cung-cap.html" class="btn btn-warning">Thêm mới</a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="list-shop-show">
				<div class="title-table-shop-shop">Danh sách Nhà cung cấp</div>
				<div class="show-box-paging">
					<div class="total-rows"><b><?php echo t('Tổng số: ')?> <?php echo $totalItem ?></b></div>
					<div class="showListPage">
						<?php print render($pager); ?>
					</div>
				</div>
				
				<div class="showListItem">
					<table class="table taicon-adminble-bordered table-hover table-striped" width="100%" cellpadding="5" cellspacing="1" border="1">
						<thead>
						<tr>
							<th width="5%" class="td_list">STT</th>
							<th width="25%" class="td_list">[Mã] Tên nhà cung cấp</th>
							<th width="20%" class="td_list">Thông tin</th>
							<th width="20%" class="td_list">Địa chỉ</th>
							<th width="15%" class="td_list">Ghi chú về NCC</th>
							<th width="6%" class="td_list">Trạng thái</th>
							<th width="5%" class="td_list align_center" >Thao tác</th>
						</tr>
						</thead>
						<tbody>
							<?php foreach($result as $k=>$v) {?>
							<tr>
								<td>
									<?php
										echo ($k+1);
									?>
								</td>
								<td>
									<?php
										echo '['.$v->provider_id.']'.$v->provider_name;
										echo '<br/>Ngày tạo: '.date('d/m/Y h:i', $v->provider_time_creater);
									?>
								</td>
								<td>
									<?php
										echo 'Email: '.$v->provider_email;
										echo '<br/>Phone: '.$v->provider_phone;
									?>
								</td>
								<td>
									<?php
										echo $v->provider_address;
									?>
								</td>
								<td>
									<?php
										echo $v->provider_note;
									?>
								</td>
								<td class="align_center">
									<?php
										$status = '';
										if($v->provider_status == 1){
											$status ='<i class="icon-ok font-size-20 green "></i>';
										}else{
											$status ='<i class="icon-remove font-size-20 red "></i></a>';
										}
										echo $status;
									?>
								</td>
								<td class="align_center">
									<?php $linkEdit = $base_url.'/sua-nha-cung-cap/'.$v->provider_id.'/'.Stdio::pregReplaceStringAlias($v->provider_name).'.html' ?>
									<a href="<?php echo $linkEdit; ?>" title="sửa"><i class="icon-edit green font-size-20"></i></a>
								</td>
							</tr>
							<?php } ?>
						</tbody>
					</table>
				</div>
				
				<div class="show-box-paging">
					<div class="total-rows"><b><?php echo t('Tổng số: ')?> <?php echo $totalItem ?></b></div>
					<div class="showListPage">
						<?php print render($pager); ?>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	jQuery(document).ready(function($){
		jQuery('.date').datetimepicker({
			timepicker:false,
 			format:'d/m/Y',
 			lang:'vi'
		});
	});
</script>