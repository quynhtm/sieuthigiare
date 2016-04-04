jQuery(document).ready(function($){
	check_valid_form.change_pass();
	check_valid_form.change_info();
	check_valid_form.post_product();
});
check_valid_form = {
	change_pass:function(){
		jQuery("#btnEditPass").click(function(){
			var name = jQuery('#frmEditPass input[name="user_shop_login"]'),
				pass = jQuery('#frmEditPass input[name="user_shop_password"]'),
				re_pass = jQuery('#frmEditPass input[name="user_shop_rep_password"]');

			if(name.val() == ''){
				alert("Tên đăng nhập không được trống!");
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
			}
			if(pass.val() == ''){
				alert("Mật khẩu không được trống!");
				pass.addClass('error').focus();
				return false;
			}else{
				if(pass != re_pass){
					pass.addClass('error');
					re_pass.addClass('error').focus();
					alert("Mật khẩu không khớp!");
					return false;
				}else{
					pass.removeClass('error');
					re_pass.removeClass('error');
				}
			}
		});
	},
	change_info:function(){
		jQuery("#btnChangeInfo").click(function(){
			var name = jQuery('#frmChangeInfo input[name="shop_name"]'),
				phone = jQuery('#frmChangeInfo input[name="shop_phone"]'),
				email = jQuery('#frmChangeInfo input[name="shop_email"]'),
				category = jQuery('#frmChangeInfo select[name="category_id"]'),
				province = jQuery('#frmChangeInfo select[name="shop_province"]');

			if(name.val() == ''){
				alert("Tên gian hàng không được trống!");
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
			}

			if(phone.val() == ''){
				alert("Điện thoại không được trống!");
				phone.addClass('error').focus();
				return false;
			}else{
				phone.removeClass('error');
			}

			if(email.val() == ''){
				alert("Email không được trống!");
				email.addClass('error').focus();
				return false;
			}else{
				var regex = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);
				var check_mail = regex.test(email.val());
				if(!check_mail){
					valid = false;
					alert("Email không đúng định dạng!");
					email.addClass('error').focus();
				}else{
					email.removeClass('error');
				}
			}

			if(category.val() <= 0){
				alert("Danh mục không được trống!");
				category.addClass('error').focus();
				return false;
			}else{
				category.removeClass('error');
			}

			if(province.val() <= 0){
				alert("Tỉnh/thành không được trống!");
				province.addClass('error').focus();
				return false;
			}else{
				province.removeClass('error');
			}
		});
	},
	post_product:function(){
		jQuery("#buttonFormShopSubmit").click(function(){
			var category = jQuery('#frmformShop select[name="category_id"]'),
				code = jQuery('#frmformShop input[name="product_code"]'),
				name = jQuery('#frmformShop input[name="product_name"]');
				content = CKEDITOR.instances.product_content.getData();

			if(category.val() <= 0){
				alert("Tên danh mục không được trống!");
				category.addClass('error').focus();
				return false;
			}else{
				category.removeClass('error');
			}
			
			if(code.val() == ''){
				alert("Mã sản phẩm không được trống!");
				code.addClass('error').focus();
				return false;
			}else{
				code.removeClass('error');
			}

			if(name.val() == ''){
				alert("Tên sản phẩm không được trống!");
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
			}

			if(content == ''){
				alert("Chi tiết sản phẩm không được trống");
				jQuery(".product_content").addClass('error');
				return false;
			}else{
				jQuery(".product_content").removeClass('error');
			}
		});
	}
}