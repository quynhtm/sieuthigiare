jQuery(document).ready(function($){
	BACK_TOP.init();
	HOVER_CATEGORY.init();
	AJAX_LOAD.product_new();
	jQuery('.provices_id, .category_id').fancySelect();
});

BACK_TOP={
	init:function(){
		 jQuery(window).scroll(function() {
            if(jQuery(window).scrollTop() > 0) {
				jQuery("#back-to-top").fadeIn();
			} else {
				jQuery("#back-to-top").fadeOut();
			}
		});
		jQuery("#back-to-top").click(function(){
			jQuery("html, body").animate({scrollTop: 0}, 1000);
			return false;
		});
	}
}
HOVER_CATEGORY = {
	init:function(){
		jQuery('.box-menu-hover').hover(
			function(){
				jQuery('body').append('<div class="bg-opacity"></div>');
				jQuery(this).addClass('act');
			},
			function(){
				jQuery('body').find('div.bg-opacity').remove();
				jQuery(this).removeClass('act');
			}
		);
	}
}
AJAX_LOAD = {
	product_new:function(){
		var check_page = jQuery('body #main-product-new').size();
		if(check_page > 0){
			jQuery(window).scroll(function() {
				if(jQuery(window).scrollTop() >= jQuery(document).height()/2){
					var currentPage = parseInt(jQuery('input#currentPage').val()),
						totalPage = parseInt(jQuery('input#totalPage').val()),
						url = BASEPARAMS.base_url + '/san-pham-moi.html';
				
					if(currentPage <= totalPage){
						jQuery('input#currentPage').val(currentPage + 1);
						jQuery.ajax({
							type: "POST",
							url: url,
							data: "currentPage="+encodeURI(currentPage),
							success: function(data){
								if(data != ''){
									jQuery('#main-product-new ul').append(data);
								}
								return false;
							}
						});
					}
	            }
			});
		}
	}
}