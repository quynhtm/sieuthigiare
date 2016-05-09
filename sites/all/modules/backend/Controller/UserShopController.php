<?php
/*
* QuynhTM
 * Quan ly danh sach cac Shop
*/
class UserShopController{

	private $arrStatus = array(-2 => 'Tất cả', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE => 'Ẩn', STASTUS_BLOCK => 'Khóa');
	private $arrIsShop = array(-1 => 'Tất cả', SHOP_FREE => 'Shop Free', SHOP_NOMAL => 'Shop thường', SHOP_VIP => 'Shop Vip');
	private $arrNumberLimitProduct = array(-1 => 'Tất cả',
		SHOP_NUMBER_PRODUCT_FREE => 'Lượt đăng Shop Free (20)',
		SHOP_NUMBER_PRODUCT_NOMAL => 'Lượt đăng Shop thường (100)',
		SHOP_NUMBER_PRODUCT_VIP => 'Lượt đăng Shop Vip (1000)');

	public function __construct(){
		$files = array(
			'bootstrap/lib/ckeditor/ckeditor.js',
			'bootstrap/lib/ckeditor/config.js',
		);
		Loader::loadJSExt('Core', $files);
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
	}

	function indexUserShop(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['user_shop'] = FunctionLib::getParam('user_shop','');
		$dataSearch['user_shop'] = FunctionLib::getParam('user_shop','');
		$dataSearch['shop_name'] = FunctionLib::getParam('shop_name','');
		$dataSearch['shop_phone'] = FunctionLib::getParam('shop_phone','');
		$dataSearch['shop_email'] = FunctionLib::getParam('shop_email','');
		$dataSearch['shop_status'] = FunctionLib::getParam('shop_status', -2);
		$dataSearch['shop_category'] = FunctionLib::getParam('shop_category', -1);
		$dataSearch['is_shop'] = FunctionLib::getParam('is_shop', -1);
		$dataSearch['number_limit_product'] = FunctionLib::getParam('number_limit_product', -1);
		$result = UserShop::getSearchListItems($dataSearch,$limit,array());

		//build option
		$arrCategoryParent = DataCommon::getListCategoryParent();
		$optionCategroy = FunctionLib::getOption(array(-1=>'Chọn danh mục cha') + $arrCategoryParent, $dataSearch['shop_category']);
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['shop_status']);
		$optionIsShop = FunctionLib::getOption($this->arrIsShop, $dataSearch['is_shop']);
		$optionNumberLimitProduct = FunctionLib::getOption($this->arrNumberLimitProduct, $dataSearch['number_limit_product']);
		return $view = theme('indexUserShop',array(
			'title'=>'Danh sách User Shop',
			'result' => $result['data'],
			'dataSearch' => $dataSearch,
			'optionStatus' => $optionStatus,
			'optionCategroy' => $optionCategroy,
			'optionIsShop' => $optionIsShop,
			'optionNumberLimitProduct' => $optionNumberLimitProduct,
			'arrIsShop' => $this->arrIsShop,
			'arrStatus' => $this->arrStatus,
			'base_url' => $base_url,
			'totalItem' =>$result['total'],
			'pager' =>$result['pager']));
	}

	function formUserShopAction(){
		global $base_url;
		$param = arg();
		$id = 0;
		$user_shop = array();
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$arrFields = UserShop::$arrFields;
			$user_shop = UserShop::getItemById($arrFields, $param[3]);
			$id = $param[3];
		}

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$user_password = FunctionLib::getParam('user_password','');
			$selectCateParent = FunctionLib::getParam('shop_category',array());
			$arrCateParent = (count($selectCateParent) > 2)? array_rand($selectCateParent,2): $selectCateParent;//lay 2 danh muc cha
			$shop_category = !empty($arrCateParent)? implode(',',$arrCateParent): '';
			$data = array(
						'shop_name'=>array('value'=>FunctionLib::getParam('shop_name',''), 'require'=>1, 'messages'=>'Tiêu đề không được trống!'),
						'user_shop'=>array('value'=>FunctionLib::getParam('user_shop',''), 'require'=>0, 'messages'=>''),
						'shop_phone'=>array('value'=>FunctionLib::getParam('shop_phone',''), 'require'=>0, 'messages'=>''),
						'shop_email'=>array('value'=>FunctionLib::getParam('shop_email',''), 'require'=>0, 'messages'=>''),
						'shop_address'=>array('value'=>FunctionLib::getParam('shop_address',''), 'require'=>0, 'messages'=>''),
						'shop_category'=>array('value'=>$shop_category, 'require'=>0, 'messages'=>''),
						'number_limit_product'=>array('value'=>FunctionLib::getIntParam('number_limit_product',SHOP_NUMBER_PRODUCT_FREE), 'require'=>1, 'messages'=>'Nhập giới hạn sản phẩm ở gian hàng!'),
						'is_shop'=>array('value'=>FunctionLib::getIntParam('is_shop',SHOP_FREE), 'require'=>0, 'messages'=>''),
					);
			$errors = ValidForm::validInputData($data);
			if($data['shop_email']['value'] != ''){
				$check_email = ValidForm::checkRegexEmail($data['shop_email']['value']);
				if(!$check_email){
					$errors .= 'Email sai cấu trúc!<br/>';
				}
			}
			if($errors != ''){
				drupal_set_message($errors, 'error');
				if($id > 0){
					drupal_goto($base_url.'/admincp/usershop/edit/'.$id);
				}else{
					drupal_goto($base_url.'/admincp/usershop/add');
				}
			}else{
				//doi mat khau neu co
				if(trim($user_password) !==''){
					require_once DRUPAL_ROOT . '/' . variable_get('password_inc', 'includes/password.inc');
					$data['user_shop_password']['value'] = user_hash_password($user_password);
				}
				//FunctionLib::Debug($data);
				UserShop::save($data, $id);
				if(Cache::CACHE_ON){
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_USER_SHOP_ID.$id;
					$cache = new Cache();
					$cache->do_remove($key_cache);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_LIST_USER_SHOP);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_TREE_MENU_CATEGORY_USER_SHOP_ID.$id);
				}
				drupal_goto($base_url.'/admincp/usershop');
			}
		}
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($user_shop->shop_status)? $user_shop->shop_status : -2);
		$optionIsShop = FunctionLib::getOption($this->arrIsShop, isset($user_shop->is_shop)? $user_shop->is_shop : SHOP_FREE);
		$optionNumberLimitProduct = FunctionLib::getOption($this->arrNumberLimitProduct, isset($user_shop->number_limit_product)? $user_shop->number_limit_product : SHOP_NUMBER_PRODUCT_FREE);

		$arrCategoryParent = DataCommon::getListCategoryParent();
		$arrShopCate = ($user_shop->shop_category != '')? explode(',',$user_shop->shop_category): array();

		return $view = theme('addUserShop',array('user_shop'=>$user_shop,
			'optionStatus'=>$optionStatus,
			'optionIsShop'=>$optionIsShop,
			'arrShopCate'=>$arrShopCate,
			'arrCategoryParent'=>$arrCategoryParent,
			'optionNumberLimitProduct'=>$optionNumberLimitProduct));
	}

	function deleteUserShopAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : 0;
			foreach($listId as $item){
				if($item > 0){
					UserShop::deleteId($item);
				}
			}
			drupal_set_message('Xóa Item thành công.');
		}
		drupal_goto($base_url.'/admincp/usershop');
	}

	function blockUserShopAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : 0;
			$cache = new Cache();
			foreach($listId as $shop_id){
				if($shop_id > 0){

					//cap nhat khoa shop
					$data['shop_status']['value'] = STASTUS_BLOCK;
					UserShop::save($data, $shop_id);
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_USER_SHOP_ID.$shop_id;
					$cache->do_remove($key_cache);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_LIST_USER_SHOP);

					//lấy các sản phẩm của nó và khóa lại
					DataCommon::updateInforProductByShopId($shop_id,PRODUCT_BLOCK);
				}
			}
		}
		drupal_goto($base_url.'/admincp/usershop');
	}
	function showUserShopAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : 0;
			$cache = new Cache();
			foreach($listId as $shop_id){
				if($shop_id > 0){

					//cap nhat khoa shop
					$data['shop_status']['value'] = STASTUS_SHOW;
					UserShop::save($data, $shop_id);
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_USER_SHOP_ID.$shop_id;
					$cache->do_remove($key_cache);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_LIST_USER_SHOP);

					//lấy các sản phẩm của nó và khóa lại
					DataCommon::updateInforProductByShopId($shop_id,PRODUCT_NOT_BLOCK);
				}
			}
		}
		drupal_goto($base_url.'/admincp/usershop');
	}
	function hideUserShopAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : 0;
			$cache = new Cache();
			foreach($listId as $shop_id){
				if($shop_id > 0){

					//cap nhat khoa shop
					$data['shop_status']['value'] = STASTUS_HIDE;
					UserShop::save($data, $shop_id);
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_USER_SHOP_ID.$shop_id;
					$cache->do_remove($key_cache);
					$cache->do_remove(Cache::VERSION_CACHE.Cache::CACHE_LIST_USER_SHOP);

					//lấy các sản phẩm của nó và khóa lại
					DataCommon::updateInforProductByShopId($shop_id,PRODUCT_BLOCK);
				}
			}
		}
		drupal_goto($base_url.'/admincp/usershop');
	}
}