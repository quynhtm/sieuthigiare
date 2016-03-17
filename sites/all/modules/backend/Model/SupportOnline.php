<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class SupportOnline extends DbBasic{
	
	public static function listInputForm(){
		$arr_fields = array(
				'id'=>array('type'=>'hidden', 'label'=>'', 'value'=>'0','require'=>'', 'attr'=>''),
				'title'=>array('type'=>'text', 'label'=>'Name', 'value'=>'','require'=>'require', 'attr'=>''),
				'yahoo'=>array('type'=>'text', 'label'=>'Yahoo', 'value'=>'','require'=>'', 'attr'=>''),
				'skyper'=>array('type'=>'text', 'label'=>'Skyper', 'value'=>'','require'=>'', 'attr'=>''),
				'mobile'=>array('type'=>'text', 'label'=>'Mobile', 'value'=>'','require'=>'', 'attr'=>''),
				'email'=>array('type'=>'text', 'label'=>'Email', 'value'=>'','require'=>'', 'attr'=>''),
				'order_no'=>array('type'=>'text', 'label'=>'Số thứ tự', 'value'=>'1','require'=>'', 'attr'=>''),
				'status'=>array('type'=>'option', 'label'=>'Trạng thái', 'value'=>'1', 'require'=>'' ,'attr'=>'','list_option'=>array('0'=>t('Ẩn'),'1'=>t('Hiện'))),
		);
		return $arr_fields;
	}
}