jQuery(document).ready(function($){
	check_valid_form.check_login();
	check_valid_form.check_reg_shop();
	check_valid_form.change_pass();
	check_valid_form.change_info();
	check_valid_form.post_product();
});
check_valid_form = {
	check_login:function(){
		jQuery("#submitLogin").click(function(){
			var name = jQuery('.formSendLogin input[name="user_shop_login"]'),
				pass = jQuery('.formSendLogin input[name="password_shop_login"]');

			if(name.val() == ''){
				jAlert('Tên đăng nhập không được trống!', 'Cảnh báo');
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
			}
			if(pass.val() == ''){
				jAlert('Mật khẩu không được trống!', 'Cảnh báo');
				pass.addClass('error').focus();
				return false;
			}else{
				pass.removeClass('error');
			}
		});
	},
	check_reg_shop:function(){

		jQuery("#submitRegister").click(function(){
			var name = jQuery('.formSendRegister input[name="user_shop"]'),
				pass = jQuery('.formSendRegister input[name="user_password"]'),
				re_pass = jQuery('.formSendRegister input[name="rep_user_password"]'),
				phone = jQuery('.formSendRegister input[name="shop_phone"]'),
				email = jQuery('.formSendRegister input[name="shop_email"]'),
				province = jQuery('.formSendRegister select[name="shop_province"]'),
				agree = jQuery('.formSendRegister input[name="agree"]');

			if(name.val() == ''){
				jAlert('Tên đăng nhập không được trống!', 'Cảnh báo');
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
			}

			if(pass.val() == ''){
				jAlert('Mật khẩu không được trống!', 'Cảnh báo');
				pass.addClass('error').focus();
				return false;
			}else{
				if(pass.val() != re_pass.val()){
					pass.addClass('error');
					re_pass.addClass('error').focus();
					jAlert('Mật khẩu không khớp!', 'Cảnh báo');
					return false;
				}else{
					pass.removeClass('error');
					re_pass.removeClass('error');
				}
			}

			if(phone.val() == ''){
				jAlert('Điện thoại không được trống!', 'Cảnh báo');
				phone.addClass('error').focus();
				return false;
			}else{
				phone.removeClass('error');
			}

			if(email.val() == ''){
				jAlert('Email không được trống!', 'Cảnh báo');
				email.addClass('error').focus();
				return false;
			}else{
				var regex = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);
				var check_mail = regex.test(email.val());
				if(!check_mail){
					valid = false;
					jAlert('Email không đúng định dạng!', 'Cảnh báo');
					email.addClass('error').focus();
				}else{
					email.removeClass('error');
				}
			}

			if(province.val() <= 0){
				jAlert('Tỉnh/thành không được trống!', 'Cảnh báo');
				province.addClass('error').focus();
				return false;
			}else{
				province.removeClass('error');
			}

			if(agree.is(':checked')){
				agree.removeClass('error');
			}else{
				jAlert('Bạn chưa đồng ý với chính sách của chúng tôi!', 'Cảnh báo');
				agree.addClass('error').focus();
				return false;
			}
		});
	},
	change_pass:function(){
		jQuery("#btnEditPass").click(function(){
			var name = jQuery('#frmEditPass input[name="user_shop_login"]'),
				pass = jQuery('#frmEditPass input[name="user_shop_password"]'),
				re_pass = jQuery('#frmEditPass input[name="user_shop_rep_password"]');

			if(name.val() == ''){
				jAlert('Tên đăng nhập không được trống!', 'Cảnh báo');
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
			}
			if(pass.val() == ''){
				jAlert('Mật khẩu không được trống!', 'Cảnh báo');
				pass.addClass('error').focus();
				return false;
			}else{
				if(pass.val() != re_pass.val()){
					pass.addClass('error');
					re_pass.addClass('error').focus();
					jAlert('Mật khẩu không khớp!', 'Cảnh báo');
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
				jAlert('Tên gian hàng không được trống!', 'Cảnh báo');
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
			}

			if(phone.val() == ''){
				jAlert('Điện thoại không được trống!', 'Cảnh báo');
				phone.addClass('error').focus();
				return false;
			}else{
				phone.removeClass('error');
			}

			if(email.val() == ''){
				jAlert('Email không được trống!', 'Cảnh báo');
				email.addClass('error').focus();
				return false;
			}else{
				var regex = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);
				var check_mail = regex.test(email.val());
				if(!check_mail){
					valid = false;
					jAlert('Email không đúng định dạng!', 'Cảnh báo');
					email.addClass('error').focus();
				}else{
					email.removeClass('error');
				}
			}

			if(category.val() <= 0){
				jAlert('Danh mục không được trống!', 'Cảnh báo');
				category.addClass('error').focus();
				return false;
			}else{
				category.removeClass('error');
			}

			if(province.val() <= 0){
				jAlert('Tỉnh/thành không được trống!', 'Cảnh báo');
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
				jAlert('Danh mục không được trống!', 'Cảnh báo');
				category.addClass('error').focus();
				return false;
			}else{
				category.removeClass('error');
			}
			
			if(code.val() == ''){
				jAlert('Mã sản phẩm không được trống!', 'Cảnh báo');
				code.addClass('error').focus();
				return false;
			}else{
				code.removeClass('error');
			}

			if(name.val() == ''){
				jAlert('Tên sản phẩm không được trống!', 'Cảnh báo');
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
			}

			if(content == ''){
				jAlert('Chi tiết sản phẩm không được trống!', 'Cảnh báo');
				jQuery(".product_content").addClass('error');
				return false;
			}else{
				jQuery(".product_content").removeClass('error');
			}
		});
	},
	ajax_check_shop_reg_exist:function(user_shop, shop_phone, shop_email){
		var url = BASEPARAMS.base_url+'/ajax-check-user-reg-exist';
		jQuery.ajax({
			type: "POST",
			url: url,
			data: "user_shop="+encodeURI(user_shop) + "&shop_phone="+encodeURI(shop_phone)+ "&shop_email="+encodeURI(shop_email),
			success: function(data){
				if(data != ''){
					var obj = jQuery.parseJSON(data);
					if(typeof obj.check_name != 'undefined') {
  						jQuery('.formSendRegister input[name="user_shop"]').addClass('error').after('<span class="show-error">'+obj.check_name+'</span>');

					}else{
						jQuery('.formSendRegister input[name="user_shop"]').removeClass('error').nextAll('span.show-error').remove();
					}
					if(typeof obj.check_phone != 'undefined') {
  						jQuery('.formSendRegister input[name="shop_phone"]').addClass('error').after('<span class="show-error">'+obj.check_phone+'</span>');

					}else{
						jQuery('.formSendRegister input[name="shop_phone"]').removeClass('error').nextAll('span.show-error').remove();
					}
					if(typeof obj.check_mail != 'undefined') {
  						jQuery('.formSendRegister input[name="shop_email"]').addClass('error').after('<span class="show-error">'+obj.check_mail+'</span>');

					}else{
						jQuery('.formSendRegister input[name="shop_email"]').removeClass('error').nextAll('span.show-error').remove();
					}
				}
			}
		});
	}
}