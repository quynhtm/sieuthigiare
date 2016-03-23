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
        	<a title="<?php echo t('Bảng điều khiển')?>" href="<?php echo $base_url?>/admincp"><i class="icon-focus icon-dashboard"></i>Bảng điều khiển</a>
        </li>
        <li <?php if($param[1]=='provice'){?> class="active" <?php } ?>>
            <a title="" href="javascript:void(0)"><i class="icon-focus icon-files-o"></i>Tỉnh/thành <i class="icon-focus fa-arrow"></i></a>
            <ul class="sub">
                <li><a class="" title="" href="<?php echo $base_url ?>/admincp/provice"><i class="icon-focus icon-circle-o"></i>Quản lý tỉnh/thành</a></li>
                <li><a class="" title="" href=""><i class="icon-focus icon-circle-o"></i>Quản lý comment</a></li>
            </ul>
        </li>
        <li <?php if($param[1]=='supportonline'){?> class="active" <?php } ?>>
            <a title="" href="javascript:void(0)"><i class="icon-focus icon-files-o"></i>Nick support <i class="icon-focus fa-arrow"></i></a>
            <ul class="sub">
                <li><a class="" title="" href="<?php echo $base_url ?>/admincp/supportonline"><i class="icon-focus icon-circle-o"></i>Quản lý nick</a></li>
                <li><a class="" title="" href=""><i class="icon-focus icon-circle-o"></i>Quản lý comment</a></li>
            </ul>

        </li>
		<li <?php if($param[1]=='configinfo'){?> class="active" <?php } ?>>
            <a title="" href="<?php echo $base_url ?>/admincp/configinfo"><i class="icon-focus icon-files-o"></i>Cấu hình chung</a>
        </li>
        <li <?php if($param[1]=='usershop'){?> class="active" <?php } ?>>
            <a title="" href="<?php echo $base_url ?>/admincp/usershop"><i class="icon-focus icon-files-o"></i>Quản trị User Shop</a>
        </li>
        <li <?php if($param[1]=='supplier'){?> class="active" <?php } ?>>
            <a title="" href="<?php echo $base_url ?>/admincp/supplier"><i class="icon-focus icon-files-o"></i>Quản trị NCC</a>
        </li>
    </ul>
</div>