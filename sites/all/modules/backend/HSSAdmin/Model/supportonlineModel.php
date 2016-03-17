<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class _Supportonline extends Supportonline{
	static $table_action = 'hss_supportonline';
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

		//$listPage['arrItem'] = $arrItem;
		return $arrItem;
	}

	function listItemPost(&$totalItem){
		global $base_url;

		$_Category = new Category();

		$keyword = isset($_GET['keyword']) ? trim($_GET['keyword']) : '';
		$category = isset($_GET['category']) ? intval($_GET['category']) : 0;
		$status = isset($_GET['status']) ? $_GET['status'] : '';

		$header = array(
				array('data' => '<input type="checkbox" id="checkAll"/>'),
				array('field' => 'i.title','data' => t('Tiêu đề')),
				array('field' => 'i.mobile','data' => t('Mobile')),
				array('field' => 'i.skyper','data' => t('Skyper')),
				array('field' => 'i.yahoo','data' => t('Yahoo')),
				array('field' => 'i.created','data' => t('Ngày tạo')),
				array('field' => 'i.order_no','data' => t('Thư tự')),
				array('field' => 'i.status','data' => t('Trạng thái')),
				array('data' => t('Action'))
		);

		$sql = db_select($this->table, 'i')->extend('PagerDefault')->extend('TableSort');
		$sql->leftjoin($_Category->table, 'c', 'c.id = i.catid');

		$sql->addField('c', 'title', 'catname');
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
		if($category > 0){
			$sql->condition('i.catid', $category, '=');
		}

		if($status != ''){
			$sql->condition('i.status', $status, '=');
		}

		$db_or = db_or();
		$db_or->condition('i.title', '%'.$keyword.'%', 'LIKE');
		$db_or->condition('i.title_alias', '%'.$keyword.'%', 'LIKE');
		$sql->condition($db_or);
		/*end search*/

		if(isset($_GET['sort'])){
			$result = $sql->limit(SITE_RECORD_PER_PAGE)->orderByHeader($header)->execute();

		}else{
			$result = $sql->limit(SITE_RECORD_PER_PAGE)->orderBy('i.id', 'DESC')->execute();
		}
		$arrItem = $result->fetchAll();

		//total item
		$totalItem = count($arrItem);
		$rows = array();
		if($totalItem > 0){

			$i=1;
			foreach ($arrItem as $row){
				$row = (object)$row;

				if($row->status==1){
					$status='<span class="bg-status-show">'.t('Hiện').'</span>';
				}else{
					$status='<span class="bg-status-hidden">'.t('Ẩn').'</span>';
				}

				$created = date('d-m-Y h:i',$row->created);

				$rows[$i]['data']['checkbox'] = '<input type="checkbox" class="checkItem" name="checkItem[]" value="'.$row->id.'" />';
				$rows[$i]['data']['title'] = $row->title;
				$rows[$i]['data']['mobile'] = $row->mobile;
				$rows[$i]['data']['skyper'] = $row->skyper;
				$rows[$i]['data']['yahoo'] = $row->yahoo;
				$rows[$i]['data']['created'] = $created;
				$rows[$i]['data']['order_no'] =  $row->order_no;
				$rows[$i]['data']['status'] =  $status;
				$rows[$i]['data']['action'] = '<a class="icon huge" href="'.$base_url.'/admincp/supportonline/edit/'.$row->id.'"  title="Update Item">
											<i class="icon-pencil bgLeftIcon"></i>
										</a>
										<a class="icon huge" id="deleteOneItem" href="javascript:void(0)" title="Delete Item">
											<i class="icon-remove bgLeftIcon"></i>
										</a>';
				$i++;
			}
		}
		$listItem['table']['tablesort_table'] = array(
				'#theme' => 'table',
				'#header' => $header,
				'#rows' => $rows,
		);
		$listItem['pager'] = array('#theme' => 'pager','#quantity' => SITE_SCROLL_PAGE);

		return  $listItem;
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