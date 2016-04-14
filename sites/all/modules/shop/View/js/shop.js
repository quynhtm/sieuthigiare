jQuery(document).ready(function($){
	check_valid_form.check_login();
	check_valid_form.check_reg_shop();
	check_valid_form.change_pass();
	check_valid_form.change_info();
	check_valid_form.post_product();

	tab_select.detail_tab();
	hover_img.change_img();
	hover_img.change_img_detail();
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
			//check_valid_form.ajax_check_shop_reg_exist(name.val(), phone.val(), email.val());
			//return false;
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
			var category = jQuery('#category_id'),
				product_type_price = jQuery('#product_type_price'),
				product_price_sell = jQuery('#product_price_sell'),
				product_price_market = jQuery('#product_price_market'),
				product_price_input = jQuery('#product_price_input'),
				name = jQuery('#frmformShop input[name="product_name"]');
				var product_content = CKEDITOR.instances.product_content.getData();
				var product_sort_desc = CKEDITOR.instances.product_sort_desc.getData();

			if(parseInt(product_type_price.val()) == 1) {
				//giá bán
				if (parseInt(product_price_sell.val()) <= 0) {
					jAlert('Giá bán không được bỏ trống, phải lớn hơn 0!', 'Cảnh báo');
					product_price_sell.addClass('error').focus();
					return false;
				} else {
					product_price_sell.removeClass('error');
					jQuery("#product_price_sell_hide").val(jQuery("#product_price_sell").autoNumeric("get"));
				}

				//giá thị trường
				if (parseInt(product_price_market.val()) > 0) {
					jQuery("#product_price_market_hide").val(jQuery("#product_price_market").autoNumeric("get"));
					jQuery("#product_price_sell_hide").val(jQuery("#product_price_sell").autoNumeric("get"));

					var price_sell = jQuery('#product_price_sell_hide').val(),
						price_market = jQuery('#product_price_market_hide').val();

					if (price_market < price_sell) {
						jAlert('Giá thị trường phải LỚN hơn giá bán', 'Cảnh báo');
						product_price_market.addClass('error').focus();
						return false;
					} else {
						product_price_market.removeClass('error');
					}
				}
				//giá nhập
				if (parseInt(product_price_input.val()) > 0) {
					jQuery("#product_price_input_hide").val(jQuery("#product_price_input").autoNumeric("get"));
				}
			}

			if(category.val() <= 0){
				jAlert('Danh mục không được trống!', 'Cảnh báo');
				category.addClass('error').focus();
				return false;
			}else{
				category.removeClass('error');

			}

			if(name.val() == ''){
				jAlert('Tên sản phẩm không được trống!', 'Cảnh báo');
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
			}

			if(product_content == ''){
				jAlert('Chi tiết sản phẩm không được trống!', 'Cảnh báo');
				jQuery(".product_content").addClass('error');
				return false;
			}else{
				jQuery(".product_content").removeClass('error');
			}
			if(product_sort_desc == ''){
				jAlert('Mô tả ngắn của sản phẩm không được trống!', 'Cảnh báo');
				jQuery(".product_sort_desc").addClass('error');
				return false;
			}else{
				jQuery(".product_sort_desc").removeClass('error');
			}
		});
	},
	ajax_check_shop_reg_exist:function(user_shop, shop_phone, shop_email){
		jQuery('span.show-error').remove();
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

tab_select= {
	detail_tab:function(){
		jQuery(".left-bottom-content-view .tab li").click(function(){
			jQuery(".left-bottom-content-view .tab li").removeClass("act");
			jQuery(this).addClass('act');
			var datatab = jQuery(this).attr('data-tab');
			jQuery('.left-bottom-content-view .show-tab').removeClass('act');
			jQuery('.left-bottom-content-view .show-tab-'+datatab).addClass('act');
		});
	}
}

hover_img = {
	change_img:function(){
		jQuery(".item").hover(function(){
			var img = jQuery(this).find('.post-thumb img').attr('src');
			var img_hover = jQuery(this).find('.post-thumb img').attr('data-other-src');
			jQuery(this).find('.post-thumb img').attr('src', img_hover);
			jQuery(this).find('.post-thumb img').attr('data-other-src', img);
		});
	},
	change_img_detail:function(){
		jQuery(".list-thumb-img a").click(function(){
			jQuery('.list-thumb-img a').removeClass('act');
			jQuery(this).addClass('act');
			var img_change = jQuery(this).attr('data-zoom');
			jQuery('.left-slider-img .max-thumb-img img').attr('src', img_change);
		});
	}
}