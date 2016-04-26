jQuery(document).ready(function($){
	HISTORY_BACK.init();
	HIDDEN_MENU_ADMIN.init();
	HIDDEN_MENU_ADMIN.menu_left();
});

DELETE_ITEM={
	init:function(path_menu){
		jQuery('a#deleteMoreItem, a#deleteOneItem').click(function(){
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