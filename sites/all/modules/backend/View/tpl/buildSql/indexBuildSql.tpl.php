<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Thông tin tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<div class="paddingTop20">
				<div class="col-lg-3">
					<label class="control-label">Tiêu đề liên hệ</label>
					<div><input type="text" class="form-control input-sm" placeholder ="Tiêu đề liên hệ" id="contact_title" name="contact_title" value="<?php echo isset($dataSearch['contact_title']) ?$dataSearch['contact_title']:''; ?>"/></div>
				</div>
				<div class="col-lg-3">
					<label class="control-label">Người gửi liên hệ</label>
					<div><input type="text" class="form-control input-sm" placeholder ="Người gửi" id="contact_user_name_send" name="contact_user_name_send" value="<?php echo isset($dataSearch['contact_user_name_send']) ?$dataSearch['contact_user_name_send']:''; ?>"/></div>
				</div>
				<div class="col-lg-3">
					<label class="control-label">Email gửi liên hệ</label>
					<div><input type="text" class="form-control input-sm" placeholder ="Email người gửi" id="contact_email_send" name="contact_email_send" value="<?php echo isset($dataSearch['contact_email_send']) ?$dataSearch['contact_email_send']:''; ?>"/></div>
				</div>
				<div class="col-lg-3">
					<label class="control-label">Phone gửi liên hệ</label>
					<div><input type="text" class="form-control input-sm" placeholder ="Phone người gửi" id="contact_phone_send" name="contact_phone_send" value="<?php echo isset($dataSearch['contact_phone_send']) ?$dataSearch['contact_phone_send']:''; ?>"/></div>
				</div>
			</div>
			<div class="clear"></div>
			<div class="paddingTop10">
				<div class="col-lg-3">
					<label class="control-label">Loại gửi</label>
					<div><select class="form-control input-sm" name="contact_reason"><?php echo $optionReason;?></select></div>
				</div>
				<div class="col-lg-3">
					<label class="control-label">Trạng thái</label>
					<div><select class="form-control input-sm" name="contact_status"><?php echo $optionStatus;?></select></div>
				</div>
				<div class="col-lg-6">
					<label class="control-label">&nbsp;</label>
					<div>
						<button class="btn btn-primary" name="submit" value="1">Tìm kiếm</button>
						<a href="<?php echo $base_url; ?>/admincp/buildsql/add" title="Thực hiện truy vấn" class="btn btn-warning">Thực hiện truy vấn</a>
					</div>

				</div>
			</div>
		</form>
	</div>
</div>

<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php echo (isset($title)) ? $title: t('Quản lý bài viết');?></h5>
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
						<th width="5%">ID</th>
						<th width="50%">Nội dung liên hệ</th>
						<th width="20%">Người gửi</th>
						<th width="8%">Ngày gửi</th>
						<th width="8%">Kiểu gửi</th>
						<th width="8%">Status</th>
						<th width="10%">Action</th>
					</tr>
					</thead>
					<tbody>
					<?php
					if(!empty($result)){


					foreach ($result as $key => $item) {?>
					<tr>
						<td><?php echo $key+1 ?></td>
						<td><?php echo $item->contact_id ?></td>
						<td>
							<?php
								echo '<b>Tiêu đề: </b>'.$item->contact_title;
								echo '<br/><b>Nội dung: </b>'.$item->contact_content;
								if($item->contact_content_reply != ''){
									echo '<b>Trả lời: </b>'.date('d-m-Y h:i:s',$item->contact_time_update).$item->contact_content_reply;
									//echo '<b>User: </b>'.$item->contact_user_name_update;
								}
							?>
						</td>
						<td>
							<?php
							echo ($item->contact_user_id_send > 0)?'<b>Shop: </b>['.$item->contact_user_id_send.'] '.$item->contact_user_name_send: $item->contact_user_name_send;
							echo ($item->contact_phone_send != '' )? '<br/>'.$item->contact_phone_send: '';
							echo ($item->contact_email_send != '' )? '<br/>'.$item->contact_email_send: '';
							?>
						</td>
						<td>
							<?php
								echo date('d-m-Y h:i:s',$item->contact_time_creater);
								echo '<br/>'.date('d-m-Y h:i:s',$item->contact_time_update);
							?>
						</td>
						<td>
							<?php echo isset($arrReason[$item->contact_reason])? $arrReason[$item->contact_reason] : 'Shop liên hệ'; ?>
						</td>
						<td>
							<?php echo isset($arrStatus[$item->contact_status])? $arrStatus[$item->contact_status] : 'Liên hệ mới'; ?>
						</td>
						<td>
							<?php $linkEdit = $base_url.'/admincp/contact/edit/'.$item->contact_id; ?>
							<a href="<?php echo $linkEdit; ?>" title="Update Item"><i class="icon-edit icon-admin green "></i></a>
						</td>
					</tr>
					<?php } }?>
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
		DELETE_ITEM.init('admincp/contact');
	});
</script>
