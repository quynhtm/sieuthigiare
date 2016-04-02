<?php
/*
* QuynhTM
 * Quan ly danh sach cac Shop
*/
class UserShopController{

	private $arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
	
	public function __construct(){
			
        $files = array(
            'bootstrap/css/bootstrap.css',
            'css/font-awesome.css',
            'css/core.css',
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
		$dataSearch['province_name'] = FunctionLib::getParam('province_name','');
		$dataSearch['province_status'] = FunctionLib::getParam('province_status', -1);

		$result = UserShop::getSearchListItems($dataSearch,$limit,array());

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['province_status']);

		return $view = theme('indexUserShop',array(
			'title'=>'Danh sách tỉnh/thành',
			'result' => $result['data'],
			'dataSearch' => $dataSearch,
			'optionStatus' => $optionStatus,
			'base_url' => $base_url,
			'totalItem' =>$result['total'],
			'pager' =>$result['pager']));

	}

	function formUserShopAction(){
		global $base_url, $user;

		$Stdio = new Stdio();

		$param = arg();
		$id = 0;
		$arrOneItem = array();

		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$arrFields = array('shop_id', 'shop_name', 'user_shop', 'shop_phone', 'shop_email', 'shop_address', 'shop_status','number_limit_product', 'is_shop');
			$arrOneItem = UserShop::getItemById($arrFields, $param[3]);
			$id = $param[3];
		}

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){

			$data = array(
						'shop_name'=>array('value'=>FunctionLib::getParam('shop_name',''), 'require'=>1, 'messages'=>'Tiêu đề không được trống!'),
						'user_shop'=>array('value'=>FunctionLib::getParam('user_shop',''), 'require'=>0, 'messages'=>''),
						'shop_phone'=>array('value'=>FunctionLib::getParam('shop_phone',''), 'require'=>0, 'messages'=>''),
						'shop_email'=>array('value'=>FunctionLib::getParam('shop_email',''), 'require'=>0, 'messages'=>''),
						'shop_address'=>array('value'=>FunctionLib::getParam('shop_address',''), 'require'=>0, 'messages'=>''),
						'shop_status'=>array('value'=>FunctionLib::getParam('shop_status',''), 'require'=>0, 'messages'=>''),
						'number_limit_product'=>array('value'=>FunctionLib::getIntParam('number_limit_product',12), 'require'=>1, 'messages'=>'Nhập giới hạn sản phẩm ở gian hàng!'),
						'is_shop'=>array('value'=>FunctionLib::getIntParam('is_shop',0), 'require'=>0, 'messages'=>''),
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
				UserShop::save($data, $id);
				drupal_goto($base_url.'/admincp/usershop');
			}
			
		}
		return $view = theme('addUserShop',array('arrOneItem'=>$arrOneItem));
		
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
}