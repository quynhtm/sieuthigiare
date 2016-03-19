jQuery(document).ready(function($){
  BACK_TOP.init();
});

BACK_TOP={
	init:function(){
		 jQuery(window).scroll(function() {
            if(jQuery(window).scrollTop() > 0) {
				jQuery("div#back-top-wrapper").fadeIn();
			} else {
				jQuery("div#back-top-wrapper").fadeOut();
			}
		});
		jQuery("div#back-top-wrapper, .gotop").click(function(){
			jQuery("html, body").animate({scrollTop: 0}, 1000);
			return false;
		});
	}
}