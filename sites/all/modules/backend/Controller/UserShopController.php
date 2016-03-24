<?php
/*
* QuynhTM
 * Quan ly danh sach cac Shop
*/
class UserShopController{
	function indexUserShop(){
		global $base_url;

		$limit = SITE_RECORD_PER_PAGE;
		
		$dataSearch['title'] = FunctionLib::getParam('title','');
		$dataSearch['status'] = FunctionLib::getParam('status', '');
		$arrFields = array('id', 'name_shop', 'user_name', 'phone', 'address', 'email', 'provice', 'about', 'is_shop', 'is_login', 'time_access', 'status', 'created');

		$result = UserShop::getSearchListItems($dataSearch, $arrFields, $limit);
		
		$view = theme('indexUserShop',array(
									'title'=>'Danh sách nick hỗ trợ trực tuyến',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));
		return $view;
	}

	function formUserShopAction(){
		global $base_url, $user;

		$Stdio = new Stdio();

		$param = arg();
		$arrOneItem = array();

		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$arrFields = array('id', 'name_shop', 'user_name', 'phone', 'address', 'email', 'provice', 'about', 'is_shop', 'is_login', 'time_access', 'status', 'created');
			$arrOneItem = UserShop::getOne($arrFields, $param[3]);
		}

		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){

			$name_shop 	= isset($_POST['name_shop']) ? trim($_POST['name_shop']) : '';
			$user_name 	= isset($_POST['user_name']) ? trim($_POST['user_name']) : '';
			$phone = isset($_POST['phone']) ? trim($_POST['phone']) : '';
			$email = isset($_POST['email']) ? trim($_POST['email']) : '';
			$address = isset($_POST['address']) ? trim($_POST['address']) : '';
			$created = time();
			$status		= isset($_POST['status']) ? intval($_POST['status']) : 0;

			$uid		= $user->uid;
			$created	= time();

			$errors = '';
			if($title==''){
				$errors .= 'Tiêu đề ko được trống!<br/>';
			}
			if($keyword==''){
				$errors .= 'Từ khóa ko được trống!<br/>';
			}
			if($errors != ''){
				drupal_set_message($errors, 'error');
				if(isset($param[3]) && $param[3] > 0){
					drupal_goto($base_url.'/admincp/usershop/edit/'.$param[3]);
				}else{
					drupal_goto($base_url.'/admincp/usershop/add');
				}
			}

			$data_post = array(
						'name_shop'=>$name_shop,
						'user_name'=>$user_name,
						'phone'=>$phone,
						'email'=>$email,
						'status'=>$status,
						'address'=>$address,
						'created'=>$created,
					);

			if(isset($param[3]) && $param[3] > 0){
				unset($data_post['created']);
				UserShop::updateId($data_post, $param[3]);
				drupal_set_message('Sửa bài viết thành công.');
				drupal_goto($base_url.'/admincp/usershop');
			}else{
				$query = UserShop::insert($data_post);
				if($query){
					drupal_set_message('Thêm bài viết thành công.');
					drupal_goto($base_url.'/admincp/usershop');
				}
			}
		}

		$data = array(
					'arrOneItem'=>$arrOneItem,				
				);

		$view = theme('addUserShop',$data);
		return $view;
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
			drupal_set_message('Xóa bài viết thành công.');
		}
		drupal_goto($base_url.'/admincp/usershop');
	}

	function updateOnOffUserShopAction(){
		echo "Vao db lay du lieu";die;
	}
}