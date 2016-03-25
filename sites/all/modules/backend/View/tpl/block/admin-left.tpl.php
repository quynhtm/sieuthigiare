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
        	<a title="<?php echo t('Bảng điều khiển')?>" href="<?php echo $base_url?>/admincp"><i class="icon-dashboard"></i>Trang chủ Admin</a>
        </li>
        <li <?php if($param[1]=='province' || $param[1]=='configinfo'|| $param[1]=='supportonline'|| $param[1]=='supplier'){?> class="active" <?php } ?>>
            <a title="" href="javascript:void(0)"><i class="icon-folder-open"></i> Quản lý Ứng dụng<i class="icon-arrow"></i></a>
            <ul class="sub">
                <li <?php if($param[1]=='configinfo'){?> class="active" <?php } ?>><a class="" title="" href="<?php echo $base_url ?>/admincp/configinfo"><i class="icon-minus"></i> Cấu hình chung</a></li>
                <li <?php if($param[1]=='province'){?> class="active" <?php } ?>><a class="" title="" href="<?php echo $base_url ?>/admincp/province"><i class="icon-minus"></i> Quản lý tỉnh/thành</a></li>
                <li <?php if($param[1]=='supportonline'){?> class="active" <?php } ?>><a class="" title="" href="<?php echo $base_url ?>/admincp/supportonline"><i class="icon-minus"></i> Nick support</a></li>
                <li <?php if($param[1]=='supplier'){?> class="active" <?php } ?>><a class="" title="" href="<?php echo $base_url ?>/admincp/supplier"><i class="icon-minus"></i> Danh sách NCC</a></li>
            </ul>
        </li>

        <li <?php if($param[1]=='product' || $param[1]=='product_category' || $param[1]=='product_comment'){?> class="active" <?php } ?>>
            <a title="" href="javascript:void(0)"><i class="icon-cogs"></i> Quản lý Sản phẩm<i class="icon-arrow"></i></a>
            <ul class="sub">
                <li <?php if($param[1]=='product'){?> class="active" <?php } ?>><a class="" title="" href="<?php echo $base_url ?>/admincp/product"><i class="icon-minus"></i> Sản phẩm</a></li>
                <li <?php if($param[1]=='product_category'){?> class="active" <?php } ?>><a class="" title="" href="<?php echo $base_url ?>/admincp/product_category"><i class="icon-minus"></i> Danh mục sản phẩm</a></li>
                <li <?php if($param[1]=='product_comment'){?> class="active" <?php } ?>><a class="" title="" href="<?php echo $base_url ?>/admincp/product_comment"><i class="icon-minus"></i> QL Bình luận</a></li>
            </ul>
        </li>

        <li <?php if($param[1]=='usershop'){?> class="active" <?php } ?>>
            <a title="" href="<?php echo $base_url ?>/admincp/usershop"><i class="icon-home"></i> Quản trị User Shop</a>
        </li>
    </ul>
</div>