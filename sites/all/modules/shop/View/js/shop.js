jQuery(document).ready(function($){
	check_valid_form.post_product();
});
check_valid_form = {
	post_product:function(){
		jQuery("#buttonFormShopSubmit").click(function(){
			
			var valid = true,
				category = jQuery('#frmformShop select[name="category_id"]'),
				code = jQuery('#frmformShop input[name="product_code"]'),
				name = jQuery('#frmformShop input[name="product_name"]');
				content = CKEDITOR.instances.product_content.getData();

			if(category.val() == '-1'){
				category.addClass('error')
				valid = false;
			}else{
				category.removeClass('error');
			}
			
			if(code.val() == ''){
				code.addClass('error')
				valid = false;
			}else{
				code.removeClass('error');
			}

			if(name.val() == ''){
				name.addClass('error')
				valid = false;
			}else{
				name.removeClass('error');
			}

			if(content == ''){
				jQuery(".product_content").addClass('error')
				valid = false;
			}else{
				jQuery(".product_content").removeClass('error');
			}

			if(valid == false){
				alert('Các trường có dấu (*) là bắt buộc!');
				jQuery(window).scrollTop(10);
				return false;
			}
			return valid;
			
		});
	}
}