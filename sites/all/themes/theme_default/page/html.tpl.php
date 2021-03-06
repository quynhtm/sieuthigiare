<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML+RDFa 1.0//EN" "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title><?php print t($head_title); ?></title>
  <?php print t($head); ?>
  <?php print $styles; ?>
  <?php print $scripts; ?>
  <?php 
    if(IS_DEV){
  ?>
  <meta name="google-site-verification" content="lJpAlY8qAQ365SzwbRN9_UEySpftXGaB4zgKeZgwKyk" />
  <script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

	  ga('create', 'UA-76848213-1', 'auto');
	  ga('send', 'pageview');

  </script>
  <?php } ?>
</head>
<body id="<?php print strtolower($body_id); ?>" class="<?php print $classes; ?> body" <?php print $attributes;?>>
  <?php print $page_top; ?>
  <?php print $page; ?>
  <?php print $page_bottom; ?>
</body>
</html>