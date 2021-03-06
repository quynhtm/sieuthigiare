jQuery(document).ready(function($){
	SHOP_CART.add();
	SHOP_CART.update();
	SHOP_CART.delOne();
	SHOP_CART.delAll();
	SHOP_CART.sendCart();
});
SHOP_CART = {
	add:function(){
		jQuery('#buttonFormBuySubmit').click(function(){
			var url = BASEPARAMS.base_url + '/them-vao-gio-hang.html';
			var pid = jQuery(this).attr('data-pid');
			var pnum = jQuery('#buy-num').val();
			jQuery('body').append('<div class="loading"></div>');
			if(pid>0){
				jQuery.ajax({
					type: "POST",
					url: url,
					data: "pid="+encodeURI(pid),
					data: "pid="+encodeURI(pid) + "&pnum="+encodeURI(pnum),
					success: function(data){
						jQuery('body').find('div.loading').remove();
						if(data == 'no'){
							jAlert('Không tồn tại sản phẩm!', 'Cảnh báo');
							return false;
						}else{
							window.location.href = BASEPARAMS.base_url + '/gio-hang.html';
						}
					}
				});
			}
		});
	},
	update:function(){
		jQuery('#txtFormShopCart select').change(function(){
			var updateCart = BASEPARAMS.base_url + '/gio-hang.html';
			jConfirm('Bạn có muốn cập nhật đơn hàng không [OK]:Đồng ý [Cancel]:Bỏ qua ?', 'Xác nhận', function(r) {
				if(r){
					jQuery('#txtFormShopCart').attr('action', updateCart).submit();
				}
			});
			return true;
		});
	},
	delOne:function(){
		jQuery('.delOneItemCart').click(function(){
			var url = BASEPARAMS.base_url + '/xoa-mot-phan-tu-trong-gio-hang.html';
			var id = jQuery(this).attr('data-id');
			jConfirm('Bạn có muốn xóa không [OK]:Đồng ý [Cancel]:Bỏ qua ?', 'Xác nhận', function(r) {
				if(r){
					jQuery.ajax({
						type: "POST",
						url: url,
						data: "id="+encodeURI(id),
						success: function(data){
							if(data != ''){
								window.location.reload();
							}
						}
					});	
				}
			});
			return true;	
		});	
	},
	delAll:function(){
		jQuery('#delAllCart').click(function(e){
			var url = BASEPARAMS.base_url + '/xoa-het-gio-hang.html';
			var delAll = jQuery(this).attr('data');
			jConfirm('Bạn có muốn xóa không [OK]:Đồng ý [Cancel]:Bỏ qua ?', 'Xác nhận', function(r) {
				if(r){
					jQuery.ajax({
						type: "POST",
						url: url,
						data: "delAll="+encodeURI(delAll),
						success: function(data){
							if(data != ''){
								window.location.reload();
							}
						}
					});	
				}
			});
			return true;
		});	
	},
	sendCart:function(){
		jQuery("#submitPaymentOrder").click(function(){

			var name = jQuery('#txtFormPaymentCart input[name="txtName"]'),
				phone = jQuery('#txtFormPaymentCart input[name="txtMobile"]'),
				address = jQuery('#txtFormPaymentCart input[name="txtAddress"]');
				
				if(name.val() == ''){
					jAlert('Họ và tên không được trống!', 'Cảnh báo');
					name.addClass('error').focus();
					return false;
				}else{
					name.removeClass('error');
				}
				if(phone.val() == ''){
					jAlert('Số điện thoại không được trống!', 'Cảnh báo');
					phone.addClass('error').focus();
					return false;
				}else{
					phone.removeClass('error');
				}

				if(address.val() == ''){
					jAlert('Địa chỉ không được trống!', 'Cảnh báo');
					address.addClass('error').focus();
					return false;
				}else{
					address.removeClass('error');
				}
		});
	}
}