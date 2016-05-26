<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Thông tin tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<div class="col-lg-3">
				<label class="control-label">Id video</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Id video" id="video_id" name="video_id" value="<?php if(isset($dataSearch['video_id']) && $dataSearch['video_id'] > 0){echo $dataSearch['video_id'];}?>"/></div>
			</div>
			<div class="col-lg-3">
				<label class="control-label">Tên Video</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Tên video" id="video_name" name="video_name" value="<?php if(isset($dataSearch['video_name'])){echo $dataSearch['video_name'];}?>"/></div>
			</div>

			<div class="col-lg-3">
				<label class="control-label">Trạng thái</label>
				<div><select class="form-control input-sm" name="video_status"><?php echo $optionStatus;?></select></div>
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
			<h5 class="padding10"><?php echo (isset($title)) ? $title: t('Quản lý sản phẩm');?></h5>
			<span class="menu_tools">
				<a href="<?php echo $base_url; ?>/admincp/video/add" title="Thêm mới" class="icon-plus icon-admin green"></a>
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
						<th width="2%"class="td_list">STT <input type="checkbox" id="checkAll"/></th>
						<th width="6%" class="td_list">Ảnh</th>
						<th width="20%" class="td_list">Tên Video</th>
						<th width="30%" class="td_list">Link video</th>
						<th width="10%" class="td_list">Lượt view</th>
						<th width="20%" class="td_list">Ngày tạo</th>
						<th width="6%" class="td_list">Action</th>
					</tr>
					</thead>
					<tbody>
					<?php if(!empty($result)) {?>
						<?php foreach ($result as $key => $item) {?>
						<tr style="padding: 3px">
							<td>
								<?php echo $key+1 ?><br/>
								<input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->video_id ?>" />
							</td>
							<td>
								<?php if( isset($item->url_image)) {?>
								<div style="position: relative;">
									<div style="position: relative; z-index: 10">
										<img src="<?php echo $item->url_image ?>" class='imge_hover' id='<?php echo $item->video_id ?>' height="80" width="80" style="margin: 10px 0;"/>
									</div>
									<div id='div_hover_<?php echo $item->video_id ?>'style="position: absolute; bottom: 30px; left: 40px; border: 2px solid #ccc; padding: 5px; background: #F4F9FF; z-index: 1000; display: none">
										<img src="<?php echo $item->url_image_hover ?>"/>
									</div>
								</div>
								<?php } else{?>
									<img src="<?php echo IMAGE_DEFAULT ?>" width="60px"/>
								<?php }?>
							</td>

							<td>
								<?php
									echo '<b>Video: </b>['.$item->video_id.'] '.$item->video_name.'<br/>';
								?>
							</td>
							<td>
								<?php
									echo $item->video_link;
								?>
							</td>
							<td>
								<?php
									echo $item->video_view;
								?>
							</td>
							<td>
								<?php
								if($item->video_time_creater > 0){
									echo 'Ngày tạo: '.date('d-m-Y h:i:s',$item->video_time_creater);
								}
								if($item->video_time_update > 0){
									echo '<br/>Ngày edit: '.date('d-m-Y h:i:s',$item->video_time_update);
								}
								?>
							</td>
							<td>
								<?php
									echo ($item->video_status == STASTUS_SHOW)? '<i class="icon-ok icon-admin green"></i>' : '<i class="icon-minus-sign icon-admin red"></i>';
								?>
								<br/>
								<?php $linkEdit = $base_url.'/admincp/video/edit/'.$item->video_id; ?>
								<a href="<?php echo $linkEdit; ?>" title="Update Item"><i class="icon-edit icon-admin green "></i></a>
							</td>
						</tr>

						<?php }?>
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
		//hover view anh
		jQuery(".imge_hover").mouseover(function() {
			var id = jQuery(this).attr('id');
			jQuery("#div_hover_" + id).show();
		});
		jQuery(".imge_hover").mouseout(function() {
			var id = jQuery(this).attr('id');
			jQuery("#div_hover_" + id).hide();
		});
		DELETE_ITEM.init('admincp/video');
	});
</script>

