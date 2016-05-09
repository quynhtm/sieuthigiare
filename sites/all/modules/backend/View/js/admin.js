jQuery(document).ready(function($){
	HISTORY_BACK.init();
	HIDDEN_MENU_ADMIN.init();
	HIDDEN_MENU_ADMIN.menu_left();
	check_valid_form.post_product();
	SEND_MAIL_SUPPLIER.send_mail();
});

DELETE_ITEM={
	init:function(path_menu){
		jQuery('a#deleteMoreItem').click(function(){
			var total = jQuery( "input:checked" ).length;
			if(total==0){
				alert('Vui lòng chọn ít nhất 1 bản ghi để xóa!');
				return false;
			}else{
				if (confirm('Bạn muốn xóa [OK]:Đồng ý [Cancel]:Bỏ qua?)')){
					jQuery('form#formListItem').attr("action", BASEPARAMS.base_url+"/"+path_menu+"/delete");
					jQuery('form#formListItem').submit();
					return true;
				}
				return false;
			}
		});
	}
}
DELETE_CACHE_IMAGE_PRODUCT={
	init:function(path_menu){
		jQuery('a#deleteCacheImageProductMoreItem').click(function(){
			var total = jQuery( "input:checked" ).length;
			if(total==0){
				alert('Vui lòng chọn ít nhất 1 bản ghi để xóa cache ảnh!');
				return false;
			}else{
				if (confirm('Bạn muốn xóa [OK]:Đồng ý [Cancel]:Bỏ qua?)')){
					jQuery('form#formListItem').attr("action", BASEPARAMS.base_url+"/"+path_menu+"/deleteCacheImage");
					jQuery('form#formListItem').submit();
					return true;
				}
				return false;
			}
		});
	}
}
/**
 * danh cho USER_SHOP
 * @type {{init: Function}}
 */
BLOCK_USER_SHOP={
	init:function(path_menu){
		jQuery('a#blockUserMoreItem').click(function(){
			var total = jQuery( "input:checked" ).length;
			if(total==0){
				alert('Vui lòng chọn ít nhất 1 bản ghi để Khóa!');
				return false;
			}else{
				if (confirm('Bạn muốn Khóa [OK]:Đồng ý [Cancel]:Bỏ qua?)')){
					jQuery('form#formListItem').attr("action", BASEPARAMS.base_url+"/"+path_menu+"/block");
					jQuery('form#formListItem').submit();
					return true;
				}
				return false;
			}
		});
	}
}
SHOW_USER_SHOP={
	init:function(path_menu){
		jQuery('a#showUserMoreItem').click(function(){
			var total = jQuery( "input:checked" ).length;
			if(total==0){
				alert('Vui lòng chọn ít nhất 1 bản ghi để Mở!');
				return false;
			}else{
				if (confirm('Bạn muốn Mở [OK]:Đồng ý [Cancel]:Bỏ qua?)')){
					jQuery('form#formListItem').attr("action", BASEPARAMS.base_url+"/"+path_menu+"/show");
					jQuery('form#formListItem').submit();
					return true;
				}
				return false;
			}
		});
	}
}
HIDE_USER_SHOP={
	init:function(path_menu){
		jQuery('a#hideUserMoreItem').click(function(){
			var total = jQuery( "input:checked" ).length;
			if(total==0){
				alert('Vui lòng chọn ít nhất 1 bản ghi để Ẩn!');
				return false;
			}else{
				if (confirm('Bạn muốn ẨN [OK]:Đồng ý [Cancel]:Bỏ qua?)')){
					jQuery('form#formListItem').attr("action", BASEPARAMS.base_url+"/"+path_menu+"/hide");
					jQuery('form#formListItem').submit();
					return true;
				}
				return false;
			}
		});
	}
}

HISTORY_BACK = {
	init:function(){
		jQuery("button[type=reset]").click(function(){
	   		window.history.back();
	   });
	}
}

HIDDEN_MENU_ADMIN = {
	init:function(){
		jQuery("#box-menu-click").click(function(){
			jQuery('.pageWrapper').toggleClass('act');
		});
	},
	menu_left:function(){
		jQuery(".navigation>ul>li.active ul").slideDown();
		jQuery(".navigation>ul>li").click(function(event){
			jQuery('.navigation>ul>li').not(this).removeClass('active');
			if(jQuery(this).hasClass('active')){
				jQuery(this).removeClass('active');
				jQuery(".navigation>ul>li>ul").slideUp();
				jQuery(this).find('ul').slideUp();
			}else{
				jQuery(this).addClass('active');
				jQuery(".navigation>ul>li>ul").slideUp();
				jQuery(this).find('ul').slideDown();
			}
		});
	}
}

check_valid_form = {
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
}

SEND_MAIL_SUPPLIER = {
	send_mail:function(){
		jQuery('a#sendMailSupplier').click(function(){
			var total = jQuery( "input:checked" ).length;
			if(total==0){
				alert('Vui lòng chọn ít nhất 1 bản ghi để gửi mail!');
				return false;
			}else{
				if (confirm('Bạn muốn gửi mail [OK]:Đồng ý [Cancel]:Bỏ qua?)')){
					jQuery('form#formListItem').attr("action", BASEPARAMS.base_url+"/admincp/supplier/sendmail");
					jQuery('form#formListItem').submit();
					return true;
				}
				return false;
			}
		});
	}
}