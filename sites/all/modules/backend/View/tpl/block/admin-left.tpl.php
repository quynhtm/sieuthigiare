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
        <li <?php if($param[1]=='provice'){?> class="active" <?php } ?>>
            <a class="" title="" href="javascript:void(0)">Tỉnh/thành <i class="fa-arrow"></i></a>
            <ul class="sub">
                <li><a class="" title="" href="<?php echo $base_url ?>/admincp/provice"><i class="icon-circle-o"></i>Quản lý tỉnh/thành</a></li>
                <li><a class="" title="" href=""><i class="icon-circle-o"></i>Quản lý comment</a></li>
            </ul>
        </li>
        <li <?php if($param[1]=='supportonline'){?> class="active" <?php } ?>>
            <a class="" title="" href="javascript:void(0)">Nick support <i class="fa-arrow"></i></a>
            <ul class="sub">
                <li><a class="" title="" href="<?php echo $base_url ?>/admincp/supportonline"><i class="icon-circle-o"></i>Quản lý nick</a></li>
                <li><a class="" title="" href=""><i class="icon-circle-o"></i>Quản lý comment</a></li>
            </ul>

        </li>
		<li <?php if($param[1]=='configinfo'){?> class="active" <?php } ?>>
            <a class="" title="" href="<?php echo $base_url ?>/admincp/configinfo">Cấu hình chung</a>
        </li>
        <li <?php if($param[1]=='usershop'){?> class="active" <?php } ?>>
            <a class="" title="" href="<?php echo $base_url ?>/admincp/usershop">Quản trị User Shop</a>
        </li>
    </ul>
</div>