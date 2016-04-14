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
								<label class="control-label">&nbsp;</label>
								<div>
									<a href="<?php echo $base_url?>/gui-lien-he.html" class="btn btn-warning">Gửi liên hệ</a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="list-shop-show">
				<div class="title-table-shop-shop">Danh sách liên hệ đã gửi cho quản trị site</div>
				<div class="show-box-paging">
					<div class="total-rows"><b><?php echo t('Tổng số: ')?> <?php echo $totalItem ?></b></div>
					<div class="showListPage">
						<?php print render($pager); ?>
					</div>
				</div>
				<form id="formListItem" method="post" action='<?php echo $base_url?>/xoa-san-pham'>
					<div class="showListItem">
						<table class="table" width="100%" cellpadding="5" cellspacing="1" border="1">
							<thead>
							<tr>
								<th width="5%">STT</th>
								<th width="">Tiêu đề liên hệ</th>
								<th width="">Nội dung liên hệ</th>
								<th width="">Trạng thái</th>
								<th width="">Ngày gửi</th>
							</tr>
							</thead>
							<tbody>
								<?php
								if(!empty($result)){
									foreach($result as $k=>$v) {?>
									<tr>
										<td><?php echo $v->contact_title ?></td>
										<td><?php echo $v->contact_content ?></td>
										<td><?php echo isset($arrStatus[$v->contact_status])?$arrStatus[$v->contact_status]:'Đang gửi' ?></td>
										<td><?php echo date('d-m-Y',$v->contact_time_creater)?></td>
									</tr>
								<?php } } ?>
							</tbody>
						</table>
					</div>
				</form>
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
