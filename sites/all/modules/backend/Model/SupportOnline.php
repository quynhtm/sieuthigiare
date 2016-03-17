<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class SupportOnline{
	static $table_action = TABLE_SUPPORT_ONLINE;

	public static function getSearch($dataSearch, $arrFields, $limit, &$totalItem, &$pager){
		$result = DB::getSearchListItemsAndPage(self::$table_action,$dataSearch, $arrFields, $limit);

		$totalItem = 0;
		$pager = $data = array();
		if(!empty($result)){
			if(isset($result['pager'])){
				$pager = $result['pager'];
			}
			if(isset($result['total'])){
				$totalItem = $result['total'];
			}
			if(isset($result['data'])){
				$data = $result['data'];
			}
		}
		return $data;
	}

	public static function getOne($arrFields, $id = 0){
		if($id > 0){
			return DB::getOneItem(self::$table_action,$arrFields, $id);
		}
		return array();
	}

	public static function updateId($dataUpdate, $id = 0){
		if($id > 0 && !empty($dataUpdate)){
			return DB::updateOneItem(self::$table_action, $dataUpdate, $id);
		}
		return false;
	}

	public static function insert($dataInsert){
		if(!empty($dataInsert)){
			return DB::insertOneItem(self::$table_action, $dataInsert);	
		}
		return false;
	}

	public static function deleteId($id){
		if($id > 0){
			return DB::deleteOneItem(self::$table_action, $id);
		}
		return false;
	}
	
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