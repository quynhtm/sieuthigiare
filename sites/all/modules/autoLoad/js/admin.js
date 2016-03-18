jQuery(document).ready(function($){
	CHECKALL_ITEM.init();
	HISTORY_BACK.init();
	HIDDEN_MENU_ADMIN.init();
	RESTORE_ITEM.init();
	INPUT_TIME.config();
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

FORMAT_NUMBER={
	init:function(nStr){
		nStr += '';
	    var x = nStr.split('.');
	    var x1 = x[0];
	    var x2 = x.length > 1 ? '.' + x[1] : '';
	    var rgx = /(\d+)(\d{3})/;
	    while (rgx.test(x1)) {
	        x1 = x1.replace(rgx, '$1' + ',' + '$2');
	    }
	    return x1 + x2;
	}
}

HIDDEN_MENU_ADMIN = {
	init:function(){
		jQuery("#box-menu-click").click(function(){
			jQuery('.pageWrapper').toggleClass('act');
		});
	},
}

INPUT_TIME = {
	config:function(){
		//config datepicker
		jQuery.datepicker.regional['vi'] = {
					closeText: 'Đóng',
					prevText: '&#x3c;Trước',
					nextText: 'Tiếp&#x3e;',
					currentText: 'Hôm nay',
					monthNames: ['Tháng Một', 'Tháng Hai', 'Tháng Ba', 'Tháng Tư', 'Tháng Năm', 'Tháng Sáu',
					'Tháng Bảy', 'Tháng Tám', 'Tháng Chín', 'Tháng Mười', 'Tháng Mười Một', 'Tháng Mười Hai'],
					monthNamesShort: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6',
					'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
					dayNames: ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'],
					dayNamesShort: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
					dayNamesMin: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
					weekHeader: 'Tu',
					dateFormat: 'dd/mm/yy',
					firstDay: 0,
					isRTL: false,
					showMonthAfterYear: false,
					yearSuffix: ''
		};
		jQuery.datepicker.setDefaults(jQuery.datepicker.regional['vi']); 
	},
	showDatepicker:function(tagClick){
		if(tagClick != ''){
			jQuery(tagClick).datepicker();
		}
	},
}