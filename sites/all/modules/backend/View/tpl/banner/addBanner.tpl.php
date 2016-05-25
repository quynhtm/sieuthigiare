<?php global $base_url ?>
<div class="inner-box">
	<div class="page-title-box">
		<div class="wrapper">
			<h5 class="padding10"><?php echo (isset($item_id) && $item_id > 0) ? 'Sửa thông tin '.$title: t('Thêm thông tin '.$title);?></h5>
		</div>
	</div>
	<div class="page-content-box paddingTop10">
		 <form class="form-horizontal" name="txtForm" action="" method="post" enctype="multipart/form-data">
                 <div class="col-lg-6">
                    <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Tên quảng cáo<span>*</span></label>
                         <div><input type="text" class="form-control input-sm" name="banner_name" value="<?php if(isset($arrItem->banner_name)){ echo $arrItem->banner_name; } ?>"></div>
                    </div>
                    <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Link Url<span>*</span></label>
                         <div><input type="text" class="form-control input-sm" name="banner_link" value="<?php if(isset($arrItem->banner_link)){ echo $arrItem->banner_link; } ?>"></div>
                    </div>
                    <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Thứ tự hiển thị</label>
                         <div><input type="text" class="form-control input-sm" name="banner_order" value="<?php if(isset($arrItem->banner_order)){ echo $arrItem->banner_order; } ?>"></div>
                    </div>
                    <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Taget bank</label>
                         <select class="form-control input-sm" name="banner_is_target">
                             <?php echo $optionTarget;?>
                         </select>
                    </div>
                    <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Nofollow</label>
                         <select class="form-control input-sm" name="banner_is_rel">
                             <?php echo $optionRel;?>
                         </select>
                     </div>
                     <div class="col-lg-12 paddingTop10">
                         <a href="javascript:;"class="btn btn-primary" onclick="Common_admin.uploadBannerAdvanced(3);">Upload ảnh quảng cáo</a>
                         <div id="sys_show_image_banner">
                             <?php if(isset($arrItem->banner_image) && $arrItem->banner_image !=''){?>
                                 <img height='300' width='400' src='<?php echo FunctionLib::getThumbImage($arrItem->banner_image,$arrItem->banner_id,FOLDER_BANNER,400,300)?>'/>
                             <?php }?>
                         </div>
                         <input name="img" type="hidden" id="img" value="<?php if(isset($arrItem->banner_image)){ echo $arrItem->banner_image; } ?>">
                         <input name="img_old" type="hidden" id="img_old" value="<?php if(isset($arrItem->banner_image)){ echo $arrItem->banner_image; } ?>">
                     </div>


                 </div>

                 <div class="col-lg-6">
                     <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Loại quảng cáo</label>
                         <select class="form-control input-sm" name="banner_type">
                             <?php echo $optionTypeBanner;?>
                         </select>
                     </div>
                     <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Page quảng cáo</label>
                         <select class="form-control input-sm" name="banner_page">
                             <?php echo $optionPage;?>
                         </select>
                     </div>
                     <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Quảng cáo cho</label>
                         <select class="form-control input-sm" name="banner_is_shop">
                             <?php echo $optionIsShop;?>
                         </select>
                     </div>
                     <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Thời gian chạy quảng cáo</label>
                         <select class="form-control input-sm" name="banner_is_run_time">
                             <?php echo $optionRunTime;?>
                         </select>
                     </div>
                     <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Ngày bắt đầu</label>
                         <div><input type="text" class="form-control input-sm date" placeholder ="Ngày bắt đầu" name="banner_start_time" value="<?php if(isset($arrItem->banner_start_time) && $arrItem->banner_start_time > 0){ echo date('d-m-Y',$arrItem->banner_start_time); } ?>"/></div>
                     </div>
                     <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Ngày kết thúc</label>
                         <div><input type="text" class="form-control input-sm date" placeholder ="Ngày kết thúc" name="banner_end_time" value="<?php if(isset($arrItem->banner_end_time) && $arrItem->banner_end_time > 0){ echo date('d-m-Y',$arrItem->banner_end_time); } ?>"/></div>
                     </div>
                     <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Danh mục quảng cáo</label>
                         <select class="form-control input-sm" name="banner_category_id">
                             <?php echo $optionCategory;?>
                         </select>
                     </div>
                     <div class="col-lg-12 paddingTop10">
                         <label class="control-label">Trạng thái</label>
                         <select class="form-control input-sm" name="banner_status">
                             <?php echo $optionStatus;?>
                         </select>
                     </div>

                     <div class="col-lg-12 paddingTop10">
                         <input type="hidden" id="id_hiden" name="id" value="<?php if(isset($arrItem->banner_id)){ echo $arrItem->banner_id; } ?>"/>
                         <input type="hidden" value="txt-form-post" name="txt-form-post">
                         <button type="submit" name="txtSubmit" id="buttonSubmit" class="btn btn-primary">Lưu lại</button>
                         <button type="reset" class="btn">Bỏ qua</button>
                     </div>
                 </div>

		 </form>
	</div>
</div>

<!--Popup upload ảnh-->
<div class="modal fade" id="sys_PopupUploadImgOtherPro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Upload ảnh</h4>
            </div>
            <div class="modal-body">
                <form name="uploadImage" method="post" action="#" enctype="multipart/form-data">
                    <div class="form_group">
                        <div id="sys_show_button_upload">
                            <div id="sys_mulitplefileuploader" class="btn btn-primary">Upload ảnh</div>
                        </div>
                        <div id="status"></div>

                        <div class="clearfix"></div>
                        <div class="clearfix" style='margin: 5px 10px; width:100%;'>
                            <div id="div_image"></div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--Popup upload ảnh-->
<script type="text/javascript">
    jQuery(document).ready(function($){
        jQuery('.date').datetimepicker({
            timepicker:false,
            format:'d-m-Y',
            lang:'vi'
        });
    });
</script>