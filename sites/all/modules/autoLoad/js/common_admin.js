jQuery(document).ready(function($) {
    CHECKALL_ITEM.init();
    //hover view anh
    jQuery(".imge_hover").mouseover(function() {
        var id = jQuery(this).attr('id');
        jQuery("#div_hover_" + id).show();
    });
    jQuery(".imge_hover").mouseout(function() {
        var id = jQuery(this).attr('id');
        jQuery("#div_hover_" + id).hide();
    });


});

var Common_admin = {
    //function common
     filter: function(v) {
        var str;
        if(v == '' || v == ' ') return;
        v = v.toLowerCase();
        jQuery('.rowItems').each(function(){
            str = jQuery(this).attr('name').toLowerCase();
            if(str.search(''+v+'') == -1) {
                jQuery(this).attr('style','display:none');
            }
            else {
                jQuery(this).attr('style','display:""');
            }
        });
     },
     checkFormEdit: function(type,submit){
        var boolCheck = true;
        var form=document.EditForm;
         if(type == 1){
             var title_news = jQuery("#title_news").val();
             if(title_news == '' && title_news !='undefined'){
                 alert('Vui lòng nhập vào tên');
                 boolCheck = false;
                 form.title_news.focus();
             }
         }else if(type == 2){
             //giá bán
             var price = jQuery('#price').val();
             if (price == '' && price !='undefined') {
                 alert('Vui lòng nhập giá bán');
                 boolCheck = false;
                 form.price.focus();
             }else if(price != ''){
                 jQuery("#price_hide").val(jQuery("#price").autoNumeric("get"));
             }

             //giá nhập
             var price_input = jQuery('#price_input').val();
             if (price_input == '' && price_input !='undefined') {
                 alert('Vui lòng nhập giá nhập');
                 boolCheck = false;
                 form.price_input.focus();
             }else if(price_input != ''){
                 jQuery("#price_input_hide").val(jQuery("#price_input").autoNumeric("get"));
             }

             //giá thị trường
             var price_market = jQuery('#price_market').val();
             if (price_market == '' && price_market !='undefined') {
                 alert('Vui lòng nhập giá thị trường');
                 boolCheck = false;
                 form.price_market.focus();
             }else if(price_market != ''){
                 jQuery("#price_market_hide").val(jQuery("#price_market").autoNumeric("get"));
             }
         }
        if(boolCheck){
            if(submit == 1){
                form.act.value='apply';
            }else{
                form.act.value='save';
            }

            form.submit();
        }
    },
    checkform: function() {
        var form = document.ListForm;
        if (form.boxchecked.value == 0) {
            alert('Vui lòng chọn một thành phần');
        }
        else {
            form.submit();
        }
    },
    confirmRemoveAll: function() {
        if (confirm("Bạn có thực sự muốn xóa những item đã chọn không ?")) {
            var form = document.ListForm;
            document.ListForm.act.value = 'remove';
            Common_admin.checkform();
        }
    },
    confirmDelete: function() {
        if (confirm("Bạn có thực sự muốn xóa item này không ?")) {
            var form = document.ListForm;
            document.ListForm.act.value = 'delete';
            form.submit();
        }
    },
    isCheckedList: function(isitchecked, all) {
        if (all == 0) {
            if (isitchecked == true) {
                document.ListForm.boxchecked.value++;
            }
            else {
                document.ListForm.boxchecked.value--;
            }
        } else {
            if (isitchecked == true) {
                document.ListForm.boxchecked.value = all;
            }
            else {
                document.ListForm.boxchecked.value = 0;
            }
        }
    },
     selectAllCheckbox: function(form,name,status, select_color, unselect_color){
        for (var i = 0; i < form.elements.length; i++) {
            //alert(form.elements[i].name);
            if (form.elements[i].name == 'selected_ids[]') {
                if(status==-1){
                    form.elements[i].checked = !form.elements[i].checked;
                }
                else{
                    form.elements[i].checked = status;
                }
                if(select_color){
                    jQuery('#'+name+'_tr_'+form.elements[i].value).css('backgroundColor',form.elements[i].checked?select_color:unselect_color);
                }
            }
        }
    },
    select_checkbox: function(form, name, checkbox, select_color, unselect_color){
        tr_color = checkbox.checked?select_color:unselect_color;
        if(typeof(event)=='undefined' || !event.shiftKey){
            jQuery('#'+name+'_all_checkbox').attr('lastSelected',checkbox);
            if(select_color){
                jQuery('#'+name+'_tr_'+checkbox.value).css('backgroundColor',checkbox.checked?select_color:unselect_color);
            }
            Common_admin.update_all_checkbox_status(form, name);
            return;
        }
        var active = typeof(jQuery('#'+name+'_all_checkbox').attr('lastSelected'))=='undefined'?true:false;
        for (var i = 0; i < form.elements.length; i++) {
            if (!active && form.elements[i]==jQuery('#'+name+'_all_checkbox').attr('lastSelected')){
                active = 1;
            }
            if (!active && form.elements[i]==checkbox){
                active = 2;
            }
            if (active && form.elements[i].id == name+'_checkbox') {
                form.elements[i].checked = checkbox.checked;
                jQuery('#'+name+'_tr_'+form.elements[i].value).css('backgroundColor',checkbox.checked?select_color:unselect_color);
            }

            if(active && (form.elements[i]==checkbox && active==1) || (form.elements[i]==jQuery('#'+name+'_all_checkbox').attr('lastSelected') && active==2)){
                break;
            }
        }
        Common_admin.update_all_checkbox_status(form, name);
    },
    update_all_checkbox_status: function(form, name){
        var status = true;
        for (var i = 0; i < form.elements.length; i++) {
            if (form.elements[i].name == 'selected_ids[]' && !form.elements[i].checked) {
                status = false;
                break;
            }
        }
        jQuery('#'+name+'_all_checkbox').attr('checked',status);
    },

    uploadMultipleImages: function(type) {
        jQuery('#sys_PopupUploadImgOtherPro').modal('show');
        jQuery('.ajax-upload-dragdrop').remove();
        var urlAjaxUpload = BASEPARAMS.base_url+'/ajax?act=upload_image&code=upload_image';
        var id_hiden = document.getElementById('id_hiden').value;

        var settings = {
            url: urlAjaxUpload,
            method: "POST",
            allowedTypes:"jpg,png,jpeg",
            fileName: "multipleFile",
            formData: {id: id_hiden,type: type},
            multiple: (id_hiden==0)? false: true,
            onSubmit:function(){
                jQuery( "#sys_show_button_upload").hide();
                jQuery("#status").html("<font color='green'>Đang upload...</font>");
            },
            onSuccess:function(files,xhr,data){
                dataResult = JSON.parse(xhr);
                if(dataResult.intIsOK === 1){
                    //gan lai id item cho id hiden: dung cho them moi, sua item
                    jQuery('#id_hiden').val(dataResult.id_item);
                    jQuery( "#sys_show_button_upload").show();

                    //add vao list sản sản phẩm khác
                    var checked_img_pro = "<div class='clear'></div><input type='radio' id='chẹcked_image_"+dataResult.info.id_key+"' name='chẹcked_image' value='"+dataResult.info.id_key+"' onclick='Common_admin.checkedImage(\""+dataResult.info.name_img+"\",\"" + dataResult.info.id_key + "\")'><label for='chẹcked_image_"+dataResult.info.id_key+"' style='font-weight:normal'>Ảnh đại diện</label><br/>";
                    if( type == 2){
                        var checked_img_pro = checked_img_pro + "<input type='radio' id='chẹcked_image_hover"+dataResult.info.id_key+"' name='chẹcked_image_hover' value='"+dataResult.info.id_key+"' onclick='Common_admin.checkedImageHover(\""+dataResult.info.name_img+"\",\"" + dataResult.info.id_key + "\")'><label for='chẹcked_image_hover"+dataResult.info.id_key+"' style='font-weight:normal'>Ảnh hover</label><br/>";
                    }
                    var delete_img = "<a href='javascript:void(0);' id='sys_delete_img_other_" + dataResult.info.id_key + "' onclick='Common_admin.removeImage(\""+dataResult.info.id_key+"\",\""+dataResult.id_item+"\",\""+dataResult.info.name_img+"\",\""+type+"\")' >Xóa ảnh</a>";
                    var html= "<li id='sys_div_img_other_" + dataResult.info.id_key + "'>";
                    html += "<div class='div_img_upload' >";
                    html += "<img height='80' width='80' src='" + dataResult.info.src + "'/>";
                    html += "<input type='hidden' id='sys_img_other_" + dataResult.info.id_key + "' class='sys_img_other' name='img_other[]' value='" + dataResult.info.name_img + "'/>";
                    html += checked_img_pro;
                    html += delete_img;
                    html +="</div></li>";
                    jQuery('#sys_drag_sort').append(html);
                    
                    jQuery('#sys_PopupImgOtherInsertContent #div_image').html('');
                    Common_admin.getInsertImageContent(type);
                    
                    //thanh cong
                    jQuery("#status").html("<font color='green'>Upload is success</font>");
                    setTimeout( "jQuery('.ajax-file-upload-statusbar').hide();",2000 );
                    setTimeout( "jQuery('#status').hide();",2000 );
                    setTimeout( "jQuery('#sys_PopupUploadImgOtherPro').modal('hide');",2500 );

                }
            },
            onError: function(files,status,errMsg){
                jQuery("#status").html("<font color='red'>Upload is Failed</font>");
            }
        }
        jQuery("#sys_mulitplefileuploader").uploadFile(settings);
    },

    /**
     * Upload banner quảng cáo
     */
    uploadBannerAdvanced: function(type) {
        jQuery('#sys_PopupUploadImgOtherPro').modal('show');
        jQuery('.ajax-upload-dragdrop').remove();
        var urlAjaxUpload = BASEPARAMS.base_url+'/ajax?act=upload_image&code=upload_image';
        var id_hiden = document.getElementById('id_hiden').value;

        var settings = {
            url: urlAjaxUpload,
            method: "POST",
            allowedTypes:"jpg,png,jpeg",
            fileName: "multipleFile",
            formData: {id: id_hiden,type: type},
            multiple: false,
            onSubmit:function(){
                jQuery( "#sys_show_button_upload").hide();
                jQuery("#status").html("<font color='green'>Đang upload...</font>");
            },
            onSuccess:function(files,xhr,data){
                dataResult = JSON.parse(xhr);
                if(dataResult.intIsOK === 1){
                    //gan lai id item cho id hiden: dung cho them moi, sua item
                    jQuery('#id_hiden').val(dataResult.id_item);
                    jQuery( "#sys_show_button_upload").show();

                    //show ảnh
                    var html = "<img height='300' width='400' src='" + dataResult.info.src + "'/>";
                    jQuery('#banner_image').val(dataResult.info.name_img);
                    jQuery('#sys_show_image_banner').html(html);

                    var img_new = dataResult.info.name_img;
                    if(img_new != ''){
                        jQuery("#img").attr('value', img_new);
                    }
                    //thanh cong
                    jQuery("#status").html("<font color='green'>Upload is success</font>");
                    setTimeout( "jQuery('.ajax-file-upload-statusbar').hide();",2000 );
                    setTimeout( "jQuery('#status').hide();",2000 );
                    setTimeout( "jQuery('#sys_PopupUploadImgOtherPro').modal('hide');",2500 );
                }
            },
            onError: function(files,status,errMsg){
                jQuery("#status").html("<font color='red'>Upload is Failed</font>");
            }
        }
        jQuery("#sys_mulitplefileuploader").uploadFile(settings);
    },

    checkedImage: function(nameImage,key){
        if (confirm('Bạn có muốn chọn ảnh này làm ảnh đại diện?')) {
            jQuery('#image_primary').val(nameImage);
            jQuery('#sys_delete_img_other_'+key).hide();

            //luu lại key anh chính
            var key_pri = document.getElementById('sys_key_image_primary').value;
            jQuery('#sys_delete_img_other_'+key_pri).show();
            jQuery('#sys_key_image_primary').val(key);

        }
    },

    checkedImageHover: function(nameImage,key){
        jQuery('#image_primary_hover').val(nameImage);
    },

    removeImage: function(key,id,nameImage,type){
        //product
        if(jQuery("#image_primary_hover").length ){
            var img_hover = jQuery("#image_primary_hover").val();
            if(img_hover == nameImage){
                jQuery("#image_primary_hover").val('');
            }
        }

        if (confirm('Bạn có chắc xóa ảnh này?')) {
            var urlAjaxUpload = BASEPARAMS.base_url+'/ajax?act=upload_image&code=remove_image';
            jQuery.ajax({
                type: "POST",
                url: urlAjaxUpload,
                data: {id : id, nameImage : nameImage, type: type},
                responseType: 'json',
                success: function(data) {
                    dataResult = JSON.parse(data);
                    if(dataResult.intIsOK === 1){
                        jQuery('#sys_div_img_other_'+key).hide();
                        jQuery('#sys_img_other_'+key).val('');
                        jQuery('#sys_new_img_'+key).hide();
                    }else{
                        jQuery('#sys_msg_return').html(data.msg);
                    }
                }
            });
        }
        jQuery('#sys_PopupImgOtherInsertContent #div_image').html('');
        Common_admin.getInsertImageContent(type);
    },
    insertImageContent: function(type) {
        jQuery('#sys_PopupImgOtherInsertContent').modal('show');
        jQuery('.ajax-upload-dragdrop').remove();
        
        var urlAjaxUpload = BASEPARAMS.base_url+'/ajax?act=upload_image&code=upload_image_insert_content';
        var id_hiden = document.getElementById('id_hiden').value;
        var settings = {
            url: urlAjaxUpload,
            method: "POST",
            allowedTypes:"jpg,png,jpeg",
            fileName: "multipleFile",
            formData: {id: id_hiden,type: type},
            multiple: (id_hiden==0)? false: true,
            onSuccess:function(files,xhr,data){
                dataResult = JSON.parse(xhr);
                if(dataResult.intIsOK === 1){
                    var imagePopup = "<span class='float_left image_insert_content'>";
                    var insert_img = "<a class='img_item' href='javascript:void(0);' onclick='insertImgContent(\""+dataResult.info.src_700+"\")' >";
                    imagePopup += insert_img;
                    imagePopup += "<img width='80' height=80 src='" + dataResult.info.src + "'/> </a>";
                    jQuery('#div_image').append(imagePopup);

                    //jQuery('#sys_PopupImgOtherInsertContent').modal('hide');
                    //thanh cong
                    jQuery("#status").html("<font color='green'>Upload is success</font>");
                    setTimeout( "jQuery('.ajax-file-upload-statusbar').hide();",5000 );
                    setTimeout( "jQuery('#status').hide();",5000 );
                }
            },
            onError: function(files,status,errMsg){
                jQuery("#status").html("<font color='red'>Upload is Failed</font>");
            }
        }
        jQuery("#sys_mulitplefileuploader_insertContent").uploadFile(settings);
    },
    actionImportProduct: function(key,id,nameImage,type){
        if (confirm('Bạn có chắc xóa ảnh này?')) {
            var urlAjaxUpload = BASEPARAMS.base_url+'/ajax?act=upload_image&code=remove_image';
            jQuery.ajax({
                type: "POST",
                url: urlAjaxUpload,
                data: {id : id, nameImage : nameImage, type: type},
                responseType: 'json',
                success: function(data) {
                    dataResult = JSON.parse(data);
                    if(dataResult.intIsOK === 1){
                        jQuery('#sys_div_img_other_'+key).hide();
                        jQuery('#sys_img_other_'+key).val('');
                        jQuery('#sys_new_img_'+key).hide();
                    }else{
                        jQuery('#sys_msg_return').html(data.msg);
                    }
                }
            });
        }
    },
    getInsertImageContent: function(type) {
        var urlAjaxUpload = BASEPARAMS.base_url+'/ajax?act=upload_image&code=get_image_insert_content';
        var id_hiden = document.getElementById('id_hiden').value;
        
        jQuery.ajax({
            type: "POST",
            url: urlAjaxUpload,
            data: "id_hiden=" + encodeURI(id_hiden) + "&type=" + encodeURI(type),
            success: function(data){
                dataResult = JSON.parse(data);
                if(dataResult.intIsOK === 1){
                    var imagePopup = '';
                    for(var i = 0; i < dataResult['item'].length; i++) {
                        imagePopup += "<span class='float_left image_insert_content'>";
                        var insert_img = "<a class='img_item' href='javascript:void(0);' onclick='insertImgContent(\""+dataResult['item'][i]+"\")' >";
                        imagePopup += insert_img;
                        imagePopup += "<img width='80' height=80 src='" + dataResult['item'][i] + "'/> </a>";
                    }
                    jQuery('#sys_PopupImgOtherInsertContent #div_image').append(imagePopup);
                }
            }
        });
    },
    showImagesProduct: function(product_id) {
        jQuery('#sys_PopupShowImagesProductId_'+product_id).modal('show');
    }
};//class

CHECKALL_ITEM = {
    init:function(){
        jQuery("input#checkAll").click(function(){
            var checkedStatus = this.checked;
            jQuery("input.checkItem").each(function(){
                this.checked = checkedStatus;
            });
        });
    },
    check_all:function(strs){
        if(strs != ''){
            jQuery("input.all_" + strs).click(function(){
                var checkedStatus = this.checked;
                jQuery("input.item_" + strs).each(function(){
                    this.checked = checkedStatus;
                });
            });
        }
    },
}