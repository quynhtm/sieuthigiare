jQuery(document).ready(function($){
	SHOP_CART.add();
});
SHOP_CART = {
	add:function(){
		jQuery('#buttonFormBuySubmit').click(function(){
			var url = BASEPARAMS.base_url + '/them-vao-gio-hang.html';
			var pid = jQuery(this).attr('data-pid');
			var pnum = jQuery('#buy-num').val();

			if(pid>0){
				jQuery.ajax({
					type: "POST",
					url: url,
					data: "pid="+encodeURI(pid),
					data: "pid="+encodeURI(pid) + "&pnum="+encodeURI(pnum),
					success: function(data){
						if(data == 'no'){
							jAlert('Không tồn tại sản phẩm!', 'Cảnh báo');
							return false;
						}else{
							jAlert('Đã thêm vào giỏ hàng!', 'Thông báo');
							window.location.reload();
						}
					}
				});
			}
		});
	},

}