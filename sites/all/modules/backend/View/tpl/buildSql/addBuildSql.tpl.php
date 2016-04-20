<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php echo (isset($item_id) && $item_id > 0) ? 'Thông tin '.$title: t('Thêm thông tin '.$title);?></h5>
		</div>
	</div>
	<div class="page-content-box paddingTop30">
		 <form class="form-horizontal" name="txtForm" action="" method="post" enctype="multipart/form-data">
             <div class="col-lg-8">
                 <div class="col-lg-6">
                    <label class="control-label">Pass thực thi<span>*</span></label>
                     <div><input type="password" class="form-control input-sm" name="password_action" value=""></div>
                 </div>
                 <div class="col-lg-12 paddingTop10">
                    <label class="control-label">Câu lệnh SQL thực thi</label>
                    <div>
                        <textarea id="build_sql_content" name="build_sql_content" class="form-control input-sm" cols="30" rows="10"><?php if(isset($build_sql_content)) {echo $build_sql_content; }?></textarea>
                    </div>
                </div>
                <div class="col-lg-12 paddingTop10">
                    <input type="hidden" value="txt-form-post" name="txt-form-post">
                    <button type="submit" name="txtSubmit" id="buttonSubmit" class="btn btn-primary">Cập nhật</button>
                    <button type="reset" class="btn">Bỏ qua</button>
                </div>
            </div>
		 </form>
	</div>
</div>
<script type="text/javascript">

</script>