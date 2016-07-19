<?php
/*
* QuỳnhTM
*/
class ProviderShopController{
	
	public $shop_id = 0;
	public $category_id = 0;
	public $user_shop = array();
	private $arrStatus = array(-1 => '--Chọn trạng thái--', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE => 'Ẩn');

	public function providerShop(){
		global $base_url, $user_shop;

		if($user_shop->shop_id == 0){
			drupal_goto($base_url.'/dang-nhap.html');
		}
		// khong phai shop vip ko cho vao
		if($user_shop->is_shop != SHOP_VIP){
			drupal_goto($base_url.'/quan-ly-gian-hang.html');
		}
		//check full infomation
		if($user_shop->shop_name == '' || $user_shop->shop_phone == '' || $user_shop->shop_email == '' || $user_shop->shop_category =='' || $user_shop->shop_province <= 0){
			drupal_set_message('Bạn vui lòng nhập đầy đủ thông tin. Các trường có dấu (*) là bắt buộc!');
			drupal_goto($base_url.'/sua-thong-tin-gian-hang.html');
		}

		$files = array(
			'bootstrap/lib/datetimepicker/datetimepicker.css',
			'bootstrap/lib/datetimepicker/jquery.datetimepicker.js',
		);
		Loader::load('Core', $files);
		$files = array(
			'bootstrap/css/bootstrap.css',
			'css/font-awesome.css',
			'css/core.css',
			'bootstrap/js/bootstrap.min.js',
		);
		Loader::load('Core', $files);
		$files = array(
			'View/css/admin.css',
			'View/js/admin.js',
		);
		Loader::load('Admin', $files);

		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['provider_name'] = trim(FunctionLib::getParam('provider_name',''));
		$dataSearch['provider_phone'] = trim(FunctionLib::getParam('provider_phone',''));
		$dataSearch['provider_email'] = trim(FunctionLib::getParam('provider_email',''));
		$dataSearch['provider_status'] = FunctionLib::getParam('provider_status', -1);
		$dataSearch['date_start'] = FunctionLib::getParam('date_start', '');
		$dataSearch['date_end'] = FunctionLib::getParam('date_end', '');
		
		$arrFields = array('provider_id', 'provider_name', 'provider_phone','provider_address',
			'provider_email', 'provider_shop_id', 'provider_shop_name', 'provider_status', 'provider_note', 'provider_time_creater');
		$result = ProviderShop::getSearchListItems($dataSearch, $limit, $arrFields);

		$optionStatus = FunctionLib::getOption(array(-1=>'Chọn trạng thái') + $this->arrStatus, $dataSearch['provider_status']);
		return theme('providerShop',array(
									'title'=>'Quản lý NCC',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager'],
									'optionStatus' =>$optionStatus));
	}
	public function providerFormShop(){
		global $base_url, $user_shop;
		if($user_shop->shop_id == 0){
			drupal_goto($base_url.'/dang-nhap.html');
		}
		// khong phai shop vip ko cho vao
		if($user_shop->is_shop != SHOP_VIP){
			drupal_goto($base_url.'/quan-ly-gian-hang.html');
		}
		//check full infomation
		if($user_shop->shop_name == '' || $user_shop->shop_phone == '' || $user_shop->shop_email == '' || $user_shop->shop_category <=0 || $user_shop->shop_province <= 0){
			drupal_set_message('Bạn vui lòng nhập đầy đủ thông tin. Các trường có dấu (*) là bắt buộc!');
			drupal_goto($base_url.'/sua-thong-tin-gian-hang.html');
		}

		$param = arg();
		$arrItem = array();
		$id = 0;
		$title = 'Thêm mới sản phẩm';
		$arrImageOther  = array();
		if(isset($param[0]) && isset($param[1]) && isset($param[2]) && $param[0] == 'sua-nha-cung-cap' && $param[1] > 0 && $param[2] != ''){
			$id = intval($param[1]);
			$fields = '';
			$cond = 'provider_id='.$id.' AND provider_shop_id='.$user_shop->shop_id;
			$arrItem = ProviderShop::getItembyCond($fields, $cond);
			if(empty($arrItem)){
				drupal_set_message('Bạn không có quyền truy cập. Đây không phải NCC của bạn!', 'error');
				drupal_goto($base_url.'/quan-ly-gian-hang.html');
			}
			$title = 'Sửa thông tin NCC';
		}
		
		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$id = FunctionLib::getParam('id', 0);
			$data = array(
					'provider_name'=>array('value'=>FunctionLib::getParam('provider_name',''), 'require'=>1, 'messages'=>'Tên NCC không được trống!'),
					'provider_phone'=>array('value'=>FunctionLib::getParam('provider_phone',''), 'require'=>0, 'messages'=>''),
					'provider_address'=>array('value'=>FunctionLib::getParam('provider_address',''), 'require'=>0, 'messages'=>''),
					'provider_email'=>array('value'=>FunctionLib::getParam('provider_email',''), 'require'=>0, 'messages'=>''),
					'provider_note'=>array('value'=>FunctionLib::getParam('provider_note',''), 'require'=>0, 'messages'=>''),
					'provider_time_creater'=>array('value'=>time(), 'require'=>0, 'messages'=>''),

					'provider_status'=>array('value'=>FunctionLib::getIntParam('provider_status',STASTUS_SHOW), 'require'=>0),
					'provider_shop_id'=>array('value'=>$user_shop->shop_id, 'require'=>0),
					'provider_shop_name'=>array('value'=>$user_shop->shop_name, 'require'=>0),
				);
			//FunctionLib::Debug($data);
			$errors = ValidForm::validInputData($data);
			if($errors != ''){
				if(!empty($arrItem)){
					drupal_set_message($errors, 'error');
					drupal_goto($base_url.'/sua-nha-cung-cap/'.$id.'/'.Stdio::pregReplaceStringAlias($arrItem->product_name).'.html');
				}else{
					drupal_set_message($errors, 'error');
					drupal_goto($base_url.'/quan-ly-nha-cung-cap.html');
				}
			}else{

				if(!empty($arrItem)){
					if($arrItem->provider_id != $id){
						drupal_set_message('Bạn không có quyền sửa NCC này!', 'error');
						drupal_goto($base_url.'/quan-ly-gian-hang.html');
					}
				}

				ProviderShop::save($data, $id);
				if(Cache::CACHE_ON){
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_PROVIDER_ID.$id;
					$cache = new Cache();
					$cache->do_remove($key_cache);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_PROVIDER_WITH_SHOP_ID.$user_shop->shop_id);
				}
				drupal_goto($base_url.'/quan-ly-nha-cung-cap.html');
			}
		}
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->provider_status)? $arrItem->provider_status : -1);
		return theme('providerFormShop',
			array(
				'optionStatus'=>$optionStatus,
				'arrItem'=>$arrItem,
				'title'=>$title,));
	}
}
