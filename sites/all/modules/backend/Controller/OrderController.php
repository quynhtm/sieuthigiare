<?php
/*
* QuynhTM
*/
class OrderController{
	//1: liên hệ mới, 2: đã xác nhận,3: đã xử lý
	private $arrStatus = array(-1 => '--Trạng thái đơn hàng--',
		ORDER_STATUS_NEW => 'Đơn hàng mới',
		ORDER_STATUS_CHECKED => 'Đã xác nhận',
		ORDER_STATUS_SUCCESS => 'Đơn hàng thành công',
		ORDER_STATUS_CANCEL => 'Đơn hàng hủy');

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

	function indexOrder(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['order_product_id'] = FunctionLib::getParam('order_product_id',0);
		$dataSearch['order_product_name'] = trim(FunctionLib::getParam('order_product_name',''));
		$dataSearch['order_customer_name'] = trim(FunctionLib::getParam('order_customer_name',''));
		$dataSearch['order_customer_phone'] = trim(FunctionLib::getParam('order_customer_phone',''));
		$dataSearch['order_customer_email'] = trim(FunctionLib::getParam('order_customer_email',''));
		$dataSearch['order_status'] = FunctionLib::getParam('order_status', -1);
		$dataSearch['date_start'] = FunctionLib::getParam('date_start', '');
		$dataSearch['date_end'] = FunctionLib::getParam('date_end', '');

		$getFields = array();
		$result = Order::getSearchListItems($dataSearch,$limit,$getFields);
		//FunctionLib::Debug($result);

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['order_status']);
		return $view = theme('indexOrder',array(
									'title'=>'Danh sách đơn hàng của các Shop',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'arrStatus' => $this->arrStatus,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));

	}
}