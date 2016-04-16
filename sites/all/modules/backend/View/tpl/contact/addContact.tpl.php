<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php echo (isset($item_id) && $item_id > 0) ? 'Thông tin '.$title: t('Thêm thông tin '.$title);?></h5>
		</div>
	</div>
	<div class="page-content-box paddingTop30">
		 <form class="form-horizontal" name="txtForm" action="" method="post" enctype="multipart/form-data">
		 	<div class="col-lg-4">
                <div class="col-lg-12">
                    <label class="control-label">Loại: <?php echo isset($arrReason[$contact->contact_reason])? $arrReason[$contact->contact_reason] : 'Shop liên hệ'; ?> </label>
                </div>
                <div class="col-lg-12 paddingTop10">
                    <label class="control-label">Tiêu đề liên hệ</label>
                    <div><input type="text" class="form-control input-sm" readonly name="contact_title" value="<?php if(isset($contact->contact_title)){ echo $contact->contact_title; } ?>"></div>
                </div>
                <div class="col-lg-12 paddingTop10">
                    <label class="control-label">Nội dung liên hệ</label>
                    <div style="border: 1px solid #ccc; height: 150px;overflow-x: hidden; overflow-y: scroll; padding: 5px"><?php if(isset($contact->contact_content)){ echo $contact->contact_content; } ?></div>
                </div>
                <div class="col-lg-12 paddingTop10">
                    <label class="control-label">Tên người gửi</label>
                    <div><input type="text" class="form-control input-sm" readonly name="contact_user_name_send" value="<?php if(isset($contact->contact_user_name_send)){ echo '['.$contact->contact_user_id_send.'] '.$contact->contact_user_name_send; } ?>"></div>
                    <div class="paddingTop5" ><input type="text" class="form-control input-sm" readonly name="contact_phone_send" placeholder ="Điện thoại"value="<?php if(isset($contact->contact_phone_send)){ echo $contact->contact_phone_send; } ?>"></div>
                    <div class="paddingTop5" ><input type="text" class="form-control input-sm" readonly name="contact_email_send" placeholder ="Email" value="<?php if(isset($contact->contact_email_send)){ echo $contact->contact_email_send; } ?>"></div>
                </div>
            </div>

             <div class="col-lg-8">
                 <div class="col-lg-6">
                    <label class="control-label">Trạng thái</label>
                    <div><select class="form-control input-sm" name="contact_status" style="width: 200px"><?php echo $optionStatus;?></select></div>
                 </div>

                 <?php if($contact->contact_reason == CONTACT_REASON_SHOP) { ?>
                     <div class="col-lg-12 paddingTop10">
                        <label class="control-label">Trả lời liên hệ</label>
                        <div>
                            <textarea id="contact_content_reply" name="contact_content_reply" class="form-control input-sm" cols="30" rows="10"><?php if(isset($contact->contact_content_reply)) { echo $contact->contact_content_reply; } ?></textarea>
                        </div>
                    </div>
                 <?php } ?>
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
    CKEDITOR.replace(
        'contact_content_reply',
        {
            toolbar: [
                { name: 'document',    items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
                { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
                { name: 'colors',      items : [ 'TextColor','BGColor' ] },
            ],
        },
        {height:400}
    );

</script>