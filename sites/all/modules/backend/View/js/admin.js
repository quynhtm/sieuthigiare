jQuery(document).ready(function($){
	CHECKALL_ITEM.init();
	HISTORY_BACK.init();
	HIDDEN_MENU_ADMIN.init();
	HIDDEN_MENU_ADMIN.menu_left();
	RESTORE_ITEM.init();
	jQuery('.table').cardtable();
});

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
			jQuery("input." + strs).click(function(){
				var checkedStatus = this.checked;
				jQuery("input.item_" + strs).each(function(){
					this.checked = checkedStatus;
				});
			});
		}
	},
}
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

RESTORE_ITEM = {
	init:function(){
		
		jQuery('a#btnRestore').click(function(){
			var total = jQuery( "input:checked" ).length;
			if(total==0){
				alert('Vui lòng chọn ít nhất 1 bản ghi để khôi phục!');
				return false;
			}else{
				if (confirm('Bạn muốn khôi phục [OK]:Đồng ý [Cancel]:Bỏ qua?)')){
					jQuery('form#formListItem').attr("action", BASEPARAMS.base_url+"/admincp/recyclebin/restore");
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