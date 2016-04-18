<?php
/*
* QuynhTM
*/
class BannerController{
	private $arrStatus = array(-1 => '--Chọn trạng thái--', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE => 'Ẩn');
	private $arrTarget = array(-1 => '--Chọn target link--', BANNER_NOT_TARGET_BLANK => 'Link trên site', BANNER_TARGET_BLANK => 'Mở tab mới');
	private $arrRunTime = array(-1 => '--Chọn thời gian chạy--', BANNER_NOT_RUN_TIME => 'Chạy mãi mãi', BANNER_IS_RUN_TIME => 'Chạy theo thời gian');
	private $arrIsShop = array(-1 => '--Tất cả--', BANNER_NOT_SHOP => 'Banner của site', BANNER_IS_SHOP => 'Banner của shop');
	private $arrTypeBanner = array(-1 => '---Chọn loại Banner--',
		BANNER_TYPE_HOME_BIG => 'Banner home to',
		BANNER_TYPE_HOME_SMALL => 'Banner home nhỏ',
		BANNER_TYPE_HOME_LEFT => 'Banner trái',
		BANNER_TYPE_HOME_LEFT => 'Banner phải');

	private $arrPage = array(-1 => '--Chọn page--',
		BANNER_PAGE_HOME => 'Page trang chủ',
		BANNER_PAGE_LIST => 'Page danh sách',
		BANNER_PAGE_DETAIL=> 'Page chi tiết',
		BANNER_PAGE_CATEGORY => 'Page danh mục');

	private $arrCategoryParent = array();
	public function __construct(){
		$files = array(
			'bootstrap/css/bootstrap.css',
			'css/font-awesome.css',
			'css/core.css',
			'js/common_admin.js',
		);
		Loader::load('Core', $files);
		$files = array(
			'View/css/admin.css',
			'View/js/admin.js',
		);
		Loader::load('Admin', $files);

		$this->arrCategoryParent = DataCommon::getListCategoryParent();
	}

	function indexBanner(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['banner_status'] = FunctionLib::getParam('banner_status', -1);
		$dataSearch['banner_id'] = FunctionLib::getParam('banner_id', -1);

		$result = Banner::getSearchListItems($dataSearch,$limit,array());
		if(isset($result['data']) && !empty($result['data'])){
			foreach($result['data'] as $k => &$value){
				if( isset($value->banner_image) && trim($value->banner_image) != ''){
					$value->url_image = FunctionLib::getThumbImage($value->banner_image,$value->banner_id,FOLDER_BANNER,80,80);
					$value->url_image_hover = FunctionLib::getThumbImage($value->banner_image,$value->banner_id,FOLDER_BANNER,450,200);
				}
			}
		}
		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['banner_status']);
		return $view = theme('indexBanner',array(
									'title'=>'Banner quảng cáo',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'arrProductStatus' => $this->arrStatus,
									'arrIsShop' => $this->arrIsShop,
									'arrIsBlock' => $this->arrIsBlock,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));
	}

	function formBannerAction(){
		$files = array(
			'bootstrap/lib/upload/cssUpload.css',
			'bootstrap/js/bootstrap.min.js',
			'bootstrap/lib/upload/jquery.uploadfile.js',
			'js/common_admin.js',

			'bootstrap/lib/datetimepicker/datetimepicker.css',
			'bootstrap/lib/datetimepicker/jquery.datetimepicker.js',
		);
		Loader::load('Core', $files);

		global $base_url;
		$param = arg();
		$arrItem = $arrImageOther = array();
		$item_id = 0;
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$item_id = (int)$param[3];
			$arrItem = Banner::getItemById(array(), $item_id);
		}
		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$item_id = FunctionLib::getParam('id', 0);
			$dataInput = array(
				'banner_name'=>array('value'=>FunctionLib::getParam('banner_name',''), 'require'=>1, 'messages'=>'Tên banner không được bỏ trống!'),
				'banner_link'=>array('value'=>FunctionLib::getParam('banner_link',''), 'require'=>1, 'messages'=>'Link banner không được bỏ trống!'),
				'banner_image'=>array('value'=>FunctionLib::getParam('banner_image',''), 'require'=>1, 'messages'=>'Chưa nhập ảnh cho banner quảng cáo!'),

				'banner_order'=>array('value'=>FunctionLib::getParam('banner_order',1)),
				'banner_is_target'=>array('value'=>FunctionLib::getParam('banner_is_target',BANNER_NOT_TARGET_BLANK)),
				'banner_type'=>array('value'=>FunctionLib::getParam('banner_type',0)),
				'banner_page'=>array('value'=>FunctionLib::getParam('banner_page',0)),
				'banner_category_id'=>array('value'=>FunctionLib::getParam('banner_category_id',0)),
				'banner_status'=>array('value'=>FunctionLib::getParam('banner_status',STASTUS_HIDE)),
				'banner_is_run_time'=>array('value'=>FunctionLib::getParam('banner_is_run_time',BANNER_NOT_RUN_TIME)),
				'banner_start_time'=>array('value'=>FunctionLib::getParam('banner_start_time',0)),
				'banner_end_time'=>array('value'=>FunctionLib::getParam('banner_end_time',0)),
				'banner_shop_id'=>array('value'=>FunctionLib::getParam('banner_shop_id',0)),
				'banner_is_shop'=>array('value'=>FunctionLib::getParam('banner_is_shop',BANNER_NOT_SHOP)),
				'banner_create_time'=>array('value'=>FunctionLib::getParam('banner_create_time',0)),
				'banner_update_time'=>array('value'=>FunctionLib::getParam('banner_update_time',0)),
			);
			$errors = ValidForm::validInputData($dataInput);
			if($errors != ''){
				drupal_set_message($errors, 'error');
				if($item_id > 0){
					drupal_goto($base_url.'/admincp/banner/edit/'.$item_id);
				}else{
					drupal_goto($base_url.'/admincp/banner/add');
				}
			}else{
				//FunctionLib::Debug($dataInput);
				if($item_id > 0) {
					$dataInput['banner_update_time']['value'] = time();
				}else{
					$dataInput['banner_create_time']['value'] = time();
				}
				Banner::save($dataInput, $item_id);
				drupal_goto($base_url.'/admincp/banner');
			}
		}
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->banner_status) ? $arrItem->banner_status: STASTUS_HIDE);
		$optionRunTime = FunctionLib::getOption($this->arrRunTime, isset($arrItem->banner_is_run_time) ? $arrItem->banner_is_run_time: BANNER_NOT_RUN_TIME);
		$optionIsShop = FunctionLib::getOption($this->arrIsShop, isset($arrItem->banner_is_shop) ? $arrItem->banner_is_shop: BANNER_NOT_SHOP);
		$optionTypeBanner = FunctionLib::getOption($this->arrTypeBanner, isset($arrItem->banner_type) ? $arrItem->banner_type: -1);
		$optionPage = FunctionLib::getOption($this->arrPage, isset($arrItem->banner_page) ? $arrItem->banner_page: -1);
		$optionTarget = FunctionLib::getOption($this->arrTarget, isset($arrItem->banner_is_target) ? $arrItem->banner_is_target: BANNER_TARGET_BLANK);
		$optionCategory = FunctionLib::getOption(array(0=>'Chọn danh mục quảng cáo')+$this->arrCategoryParent, isset($arrItem->banner_category_id) ? $arrItem->banner_category_id: 0);
		return $view = theme('addBanner',
			array('arrItem'=>$arrItem,
				'item_id'=>$item_id,
				'title'=>'banner quảng cáo',
				'optionCategory'=>$optionCategory,
				'optionTarget'=>$optionTarget,
				'optionIsShop'=>$optionIsShop,
				'optionPage'=>$optionPage,
				'optionTypeBanner'=>$optionTypeBanner,
				'optionRunTime'=>$optionRunTime,
				'optionStatus'=>$optionStatus));
	}

	function deleteBannerAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = FunctionLib::getParam('checkItem',array());
			if(!empty($listId)){
				foreach($listId as $id){
					if($id > 0){
						Banner::deleteOne($id);
					}
				}
				drupal_set_message('Xóa bài viết thành công.');
			}
		}
		drupal_goto($base_url.'/admincp/banner');
	}
}