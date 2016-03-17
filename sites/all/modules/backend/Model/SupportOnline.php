<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class SupportOnline extends DbBasic{
	static $table_action = TABLE_SUPPORT_ONLINE;
	public static function getSearchListItems($dataSearch = array(),$limit = SITE_RECORD_PER_PAGE, &$totalItem=0, &$pager=array()){

		//field get
		$sql = db_select(self::$table_action, 'i')->extend('PagerDefault');
		$sql->addField('i', 'catid', 'catid');
		$sql->addField('i', 'id', 'id');
		$sql->addField('i', 'title', 'title');
		$sql->addField('i', 'phone', 'phone');
		$sql->addField('i', 'mobile', 'mobile');
		$sql->addField('i', 'email', 'email');
		$sql->addField('i', 'yahoo', 'yahoo');
		$sql->addField('i', 'skyper', 'skyper');
		$sql->addField('i', 'created', 'created');
		$sql->addField('i', 'order_no', 'order_no');
		$sql->addField('i', 'status', 'status');

		/*search*/
		if($dataSearch['category'] > 0){
			$sql->condition('i.catid', $dataSearch['category'], '=');
		}

		if($dataSearch['status'] != ''){
			$sql->condition('i.status', $dataSearch['status'], '=');
		}

		if($dataSearch['keyword'] != ''){
			$db_or = db_or();
			$db_or->condition('i.title', '%'.$dataSearch['keyword'].'%', 'LIKE');
			$db_or->condition('i.title_alias', '%'.$dataSearch['keyword'].'%', 'LIKE');
			$sql->condition($db_or);
		}
		/*end search*/
		$result = $sql->limit($limit)->orderBy('i.id', 'DESC')->execute();
		$arrItem = (array)$result->fetchAll();
		$pager = array('#theme' => 'pager','#quantity' => 3);

		return $arrItem;
	}

	public static function getOneItem($arrFields=array(), $id=0){
		$arrItem = array();
		if(!empty($arrFields)){
			$sql = db_select(self::$table_action, 'i');
			foreach($arrFields as $field){
				$sql->addField('i', $field, $field);
			}
			if($id > 0){
				$sql->condition('i.id', (int)$id, '=');
			}
			$result = $sql->range(0, 1)->orderBy('i.id', 'DESC')->execute();
			$arrItem = (array)$result->fetchAll();
		}
		return $arrItem;
	}

	function listInputForm(){
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