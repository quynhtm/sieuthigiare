<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML+RDFa 1.0//EN" "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title><?php print t($head_title); ?></title>
  <?php print t($head); ?>
  <?php print $styles; ?>
  <?php print $scripts; ?>
</head>
<body id="<?php print strtolower($body_id); ?>" class="<?php print $classes; ?> body" <?php print $attributes;?>>
  <?php print $page_top; ?>
  <?php print $page; ?>
  <?php print $page_bottom; ?>
</body>
</html>