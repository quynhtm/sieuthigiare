<?php global $base_url;?>
<script type="text/javascript" src="<?php echo $base_url?>/sites/all/modules/autoLoad/js/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="<?php echo $base_url?>/sites/all/modules/autoLoad/js/ckeditor/config.js"></script>
<div class="pageWrapper">
    <?php if ($page['header']){ ?>
    <div class="headerRegion">
        <?php echo render($page['header']); ?>
    </div>
    <?php } ?>
    <div class="contentRegion">
        <?php if ($page['left']){ ?>
            <div class="leftRegion">
               <?php echo render($page['left']); ?>
            </div>
        <?php } ?>
        <?php if ($page['right']){ ?>
        <div class="rightRegion">
            <?php echo render($page['right']); ?>
        </div>
        <?php } ?>
        <?php if ($page['content']){ ?>
        <div class="rightRegion">
            <?php if(!isset($messages)) $messages = ''; echo $messages; ?>
            <?php  unset($page['content']['system_main']['default_message']); ?>
            <?php echo render($page['content']); ?>
        </div>
        <?php } ?>
    </div>
    <?php if ($page['footer']){ ?>
        <div class="footerRegion">
            <?php echo render($page['footer']); ?>
        </div>
    <?php } ?>
</div>