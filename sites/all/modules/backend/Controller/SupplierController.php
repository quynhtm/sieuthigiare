<?php
/*
* QuynhTM
 * Quan ly danh sach cac Shop
*/
class SupplierController{

	private $arrStatus = array(-1 => 'Tất cả', 1 => 'Hiển thị', 0 => 'Ẩn');
	
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
	}

	function indexSupplier(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['supplier_name'] = FunctionLib::getParam('supplier_name','');
		$dataSearch['supplier_phone'] = FunctionLib::getParam('supplier_phone','');
		$dataSearch['supplier_email'] = FunctionLib::getParam('supplier_email','');
		$dataSearch['supplier_status'] = FunctionLib::getParam('supplier_status',-1);

		$result = Supplier::getSearchListItems($dataSearch,$limit,array());

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['supplier_status']);
		return $view = theme('indexSupplier',array(
			'title'=>'Danh sách NCC',
			'result' => $result['data'],
			'dataSearch' => $dataSearch,
			'optionStatus' => $optionStatus,
			'base_url' => $base_url,
			'totalItem' =>$result['total'],
			'pager' =>$result['pager']));
	}

	function deleteSupplierAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = isset($_POST['checkItem'])? $_POST['checkItem'] : 0;
			foreach($listId as $item){
				if($item > 0){
					Supplier::deleteId($item);
				}
			}
			drupal_set_message('Xóa Item thành công.');
		}
		drupal_goto($base_url.'/admincp/supplier');
	}

	function sendmailSupplierAction(){
		global $base_url;
		
		$listId = FunctionLib::getParam('checkItem',array());
		if(!empty($listId)){
			$arrFields = array('supplier_name', 'supplier_email');
			foreach($listId as $v){
				if($v > 0){
					$result = Supplier::getItemById($arrFields, $v);
					if(!empty($result)){
						$supplier_name = $result->supplier_name;
						$supplier_email = $result->supplier_email;
						
						$check_valid_mail = ValidForm::checkRegexEmail($supplier_email);
						$errors = '';
						if($check_valid_mail){
							//Send mail
							$contentEmail = 'Chào: '.$supplier_name.'<br/>';
		    				$contentEmail .= '- Bạn có <b>sản phẩm để bán?</b><br/>';
		    				$contentEmail .= '- Bạn đã có <b>cửa hàng để trưng bày sản phẩm</b>?<br/>';
		    				$contentEmail .= '- Bạn có <b>một máy tính kết nối internet</b>, mạng xã hội?<br/>';
		    				$contentEmail .= '- Nhưng bạn chưa có <b style="color:#ff0000">Website để giới thiệu sản phẩm</b> tới người tiêu dùng..?<br/><br/>';

		    				$contentEmail .= 'Shopcuatui.com.vn sẽ đáp ứng yêu cầu đó:<br/>';
		    				$contentEmail .= '- <b>Quản lý shop</b><br/>';
		    				$contentEmail .= '- <b>Quản lý sản phẩm online</b><br/>';
		    				$contentEmail .= '- <b>Quản lý đơn hàng online</b><br/>';
		    				$contentEmail .= '- <b>Tiếp cận tới nhiều người tiêu dùng</b><br/>';
		    				$contentEmail .= '- <b>Chức năng đơn giản, tiện dụng, dễ sử dụng</b><br/>';
		    				$contentEmail .= '- Quan trọng hơn là <b style="color:#ff0000">Miễn Phí tạo account và up nhiều sản phẩm</b> ngay khi đăng ký<br/><br/>';

		    				$contentEmail .= 'Link demo: http://shopcuatui.com.vn/gian-hang/15/Thoi-trang-nu.html<br/>';

		    				$subject = 'Chào: '.$supplier_name;
							auto_send_mail('Admin', $contentEmail, $supplier_email, $subject);
						}
					}
				}
			}
			drupal_set_message('Gửi mail thành công!');
			drupal_goto($base_url.'/admincp/supplier');
		}

	}
}