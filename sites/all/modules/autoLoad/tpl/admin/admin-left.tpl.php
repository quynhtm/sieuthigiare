<?php
	global $base_url;
	$param = arg();
	$dashboard = 'class="active"';
	if(count($param)>=2){
		$dashboard='';
	}else{
		$param[1] = '';
	}
?>
<div class="navigation">
	<ul>
        <li <?php echo $dashboard ?>>
        	<a class="" title="<?php echo t('Bảng điều khiển')?>" href="<?php echo $base_url?>/admincp">Bảng điều khiển</a>
        </li>
        <li <?php if($param[1]=='supportonline'){?> class="active" <?php } ?>>
            <a class="" title="" href="<?php echo $base_url ?>/admincp/supportonline">Nick support</a>
        </li>
    </ul>
</div>