jQuery(document).ready(function($){
	check_valid_form.check_login();
	check_valid_form.check_reg_shop();
	check_valid_form.change_pass();
	check_valid_form.change_info();
	check_valid_form.forgot_pass();
	check_valid_form.post_product();
	add_input_form.add_item_input();
	tab_select.detail_tab();
	tab_select.click_show_form_comment();
	hover_img.change_img();
	hover_img.change_img_detail();
	order_update_status.update();
	check_height_item_element.desc_view();
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
			check_valid_form.ajax_check_shop_reg_exist();
			return false;
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
				category = jQuery('#frmChangeInfo select[name="category_id"]'),
				province = jQuery('#frmChangeInfo select[name="shop_province"]');

			if(name.val() == ''){
				jAlert('Tên gian hàng không được trống!', 'Cảnh báo');
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
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
	forgot_pass:function(){
		jQuery("#submitForgotPass").click(function(){
			var name = jQuery('.formForgotPass input[name="user_shop"]'),
				mail = jQuery('.formForgotPass input[name="email_shop"]');
			if(name.val() == ''){
				jAlert('Tên đăng nhập không được trống!', 'Cảnh báo');
				name.addClass('error').focus();
				return false;
			}else{
				name.removeClass('error');
			}

			if(mail.val() == ''){
				jAlert('Email không được trống!', 'Cảnh báo');
				mail.addClass('error').focus();
				return false;
			}else{
				var regex = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);
				var check_mail = regex.test(mail.val());
				if(!check_mail){
					jAlert('Email không đúng định dạng!', 'Cảnh báo');
					mail.addClass('error').focus();
					return false;
				}else{
					mail.removeClass('error');
				}
			}
		});
	},
	post_product:function(){
		jQuery(".buttonFormShopSubmit").click(function(){
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
		});
	},
	ajax_check_shop_reg_exist:function(){
		jQuery('span.show-error').remove();
		var url = BASEPARAMS.base_url+'/ajax-check-user-reg-exist';
		
		var name = jQuery('.formSendRegister input[name="user_shop"]'),
			pass = jQuery('.formSendRegister input[name="user_password"]'),
			re_pass = jQuery('.formSendRegister input[name="rep_user_password"]'),
			province = jQuery('.formSendRegister select[name="shop_province"]'),
			agree = jQuery('.formSendRegister input[name="agree"]'),

			user_shop 	= name.val(),
			user_pass 	= pass.val();

		//begin check null
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
		//end check null
		jQuery('.formSendRegister').append('<div class="loading"></div>');
		jQuery.ajax({
			type: "POST",
			url: url,
			data: "user_shop="+encodeURI(user_shop) + "&user_pass="+encodeURI(user_pass)/* + "&shop_phone="+encodeURI(shop_phone)+ "&shop_email="+encodeURI(shop_email)*/,
			success: function(data){
				jQuery('.formSendRegister').find('.loading').remove();
				if(data != ''){
					var obj = jQuery.parseJSON(data);
					if(typeof obj.check_name != 'undefined') {
  						jQuery('.formSendRegister input[name="user_shop"]').addClass('error').after('<span class="show-error">'+obj.check_name+'</span>');
					}else{
						jQuery('.formSendRegister input[name="user_shop"]').removeClass('error').nextAll('span.show-error').remove();
					}
					if(typeof obj.check_pass != 'undefined') {
  						jQuery('.formSendRegister input[name="user_password"]').addClass('error').after('<span class="show-error">'+obj.check_pass+'</span>');
					}else{
						jQuery('.formSendRegister input[name="user_password"]').removeClass('error').nextAll('span.show-error').remove();
					}

					var num_error = jQuery('.show-error').size();
					if(num_error > 0){
						return false;
					}
				}
				jQuery('form.formSendRegister').submit();
				return false;
			}
		});
	}
}
add_input_form = {
	remove_parent:function(_icon, _parent){
		jQuery(_icon).click(function(){
			jQuery(this).parent(_parent).remove();
		});
	},
	add_item_input:function(){
		jQuery('.form-group.shop-phone .add-phone').click(function(){
			jQuery('.form-group.shop-phone').append('<div><input type="text" class="form-control input-sm" placeholder ="Số điện thoại" name="shop_phone[]"  maxlength="255"/><i class="icon-remove"></i></div>');
			add_input_form.remove_parent('.form-group.shop-phone .icon-remove', 'div');
		});
		add_input_form.remove_parent('.form-group.shop-phone .icon-remove', 'div');

		jQuery('.form-group.shop-mail .add-email').click(function(){
			jQuery('.form-group.shop-mail').append('<div><input type="text" class="form-control input-sm" placeholder ="Email" name="shop_email[]"  maxlength="255"/><i class="icon-remove"></i></div>');
			add_input_form.remove_parent('.form-group.shop-mail .icon-remove', 'div');
		});
		add_input_form.remove_parent('.form-group.shop-mail .icon-remove', 'div');
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
	},

	click_show_form_comment:function(){
		jQuery('#clickFormCommentSubmit').click(function(){
			if(jQuery('.form-comment-post .wrapp-form-comment-post').hasClass('act')){
				jQuery('.form-comment-post .wrapp-form-comment-post').removeClass('act');
				jQuery('.form-comment-post .wrapp-form-comment-post').fadeOut();
			}else{
				jQuery('.form-comment-post .wrapp-form-comment-post').addClass('act');
				jQuery('.form-comment-post .wrapp-form-comment-post').fadeIn();
			}
		});
	},

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

order_update_status = {
	update:function(){
		jQuery('select.order-update-status').change(function(){
			var order_id = jQuery(this).attr('data-id'),
				order_status = jQuery(this).val(),
				act = 'action_order_update_status',
				url = BASEPARAMS.base_url+'/ajax-action';

			jQuery('.showListItemOrder').append('<div class="loading"></div>');
			jQuery.ajax({
				type: "POST",
				url: url,
				data: "order_id="+encodeURI(order_id) + "&order_status="+encodeURI(order_status) + "&act="+encodeURI(act),
				success: function(data){
					jQuery('.showListItemOrder').find('.loading').remove();
					return false;
				}
			});
		});
	},
}

check_height_item_element = {
	desc_view:function(){
		var _height = jQuery('.features-point .des-point').height();
		if(_height > 300){
			 jQuery('.features-point').append('<div class="view-full">Xem thêm</div>');
		}
		jQuery('.features-point .view-full').click(function(){
			jQuery('.features-point').toggleClass('act');
			if(jQuery('.features-point').hasClass('act')){
				jQuery('.view-full').text('Thu gọn');
			}else{
				jQuery('.view-full').text('Xem thêm');
			}
		});
	}
}