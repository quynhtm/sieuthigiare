<div class="search-box">
	<div class="wrapp-search-box">
		<div class="search-box-title">Thông tin tìm kiếm</div>
		<form action="" method="GET" id="frmSearch" class="frmSearch" name="frmSearch">
			<div class="col-lg-3">
				<label class="control-label">Tiêu đề bài viết</label>
				<div><input type="text" class="form-control input-sm" placeholder ="Tiêu đề bài viết" id="news_title" class="keyword" name="news_title" value="<?php echo $dataSearch['news_title'] ?>"/></div>
			</div>

			<div class="col-lg-3">
				<label class="control-label">Danh mục</label>
				<div><select class="form-control input-sm" name="news_category"><?php echo $optionCategory;?></select></div>
			</div>
			<div class="col-lg-3">
				<label class="control-label">Loại tin</label>
				<div><select class="form-control input-sm" name="news_type"><?php echo $optionType;?></select></div>
			</div>
			<div class="col-lg-3">
				<label class="control-label">Trạng thái</label>
				<div><select class="form-control input-sm" name="news_status"><?php echo $optionStatus;?></select></div>
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
				<a href="<?php echo $base_url; ?>/admincp/news/add" title="Thêm mới" class="icon-plus icon-admin green"></a>
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
						<th width="5%" class="td_list">Ảnh</th>
						<th width="60%" class="td_list">Tên bài viết</th>
						<th width="10%" class="td_list">Thuộc danh mục</th>
						<th width="10%" class="td_list">Loại tin</th>
						<th width="5%" class="td_list">Status</th>
						<th width="5%" class="td_list">Action</th>
					</tr>
					</thead>
					<tbody>
					<?php if(!empty($result)) {?>
						<?php foreach ($result as $key => $item) {?>
						<tr>
							<td><?php echo $key+1 ?></td>
							<td><input type="checkbox" class="checkItem" name="checkItem[]" value="<?php echo $item->news_id ?>" /></td>
							<td>
								<?php if( isset($item->url_image) && isset($item->url_image_hover)) {?>
								<div style="position: relative;">
									<div style="position: relative; z-index: 10">
										<img src="<?php echo $item->url_image ?>" class='imge_hover' id='<?php echo $item->news_id ?>'/>
									</div>
									<div id='div_hover_<?php echo $item->news_id ?>'style="position: absolute; bottom: 30px; left: 40px; border: 2px solid #ccc; padding: 5px; background: #F4F9FF; z-index: 1000; display: none">
										<img src="<?php echo $item->url_image_hover ?>"/>
									</div>
								</div>
								<?php } else{?>
									<img src="<?php echo IMAGE_DEFAULT ?>" width="60px"/>
								<?php }?>
							</td>
							<td>
								<a target="_blank" href="<?php echo FunctionLib::buildLinkNewsDetail($item->news_category_alias, $item->news_id, $item->news_title) ?>"><?php echo $item->news_title ?></a>
							</td>
							<td><?php echo isset($arrCategoryNew[$item->news_category])?$arrCategoryNew[$item->news_category]:'Chưa rõ'; ?></td>
							<td><?php echo isset($arrTypeNew[$item->news_type])?$arrTypeNew[$item->news_type]:'Chưa rõ';?></td>
							<td>
								<?php echo ($item->news_status == 1)? '<i class="icon-ok icon-admin green"></i>': '<i class="icon-remove icon-admin red"></i>'; ?>
							</td>
							<td>
								<?php $linkEdit = $base_url.'/admincp/news/edit/'.$item->news_id; ?>
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
		DELETE_ITEM.init('admincp/news');
	});
</script>
