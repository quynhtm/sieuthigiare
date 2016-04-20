<?php
/*
* QuynhTM
*/
class BuildSqlController{
	//1: liên hệ mới, 2: đã xác nhận,3: đã xử lý
	private $arrStatus = array(-1 => 'Tất cả', CONTACT_NEW => 'Liên hệ mới', CONTACT_OK => 'Đã xác nhận', CONTACT_SUCCESS => 'Đã xử lý');
	private $arrReason = array(-1 => 'Tất cả', CONTACT_REASON_CUSTOMER => 'Khách hàng gửi', CONTACT_REASON_SHOP => 'Shop gửi');

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
        );
        Loader::load('Core', $files);

        $files = array(
        	'View/css/admin.css',
            'View/js/admin.js',
        );
        Loader::load('Admin', $files);
	}

	function indexBuildSql(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search
		$dataSearch['build_sql_content'] = FunctionLib::getParam('build_sql_content','');
		$dataSearch['build_sql_user_name_action'] = FunctionLib::getParam('build_sql_user_name_action','');

		$getFields = array();
		$result = BuildSql::getSearchListItems($dataSearch,$limit,$getFields);

		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, 0);
		$optionReason = FunctionLib::getOption($this->arrReason, 0);

		return $view = theme('indexBuildSql',array(
									'title'=>'Danh sách thực hiện SQL',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'optionReason' => $optionReason,
									'arrStatus' => $this->arrStatus,
									'arrReason' => $this->arrReason,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));

	}

	function formBuildSqlAction(){
		global $user;
		$password_action = '';
		$build_sql_content = '';
		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$password_action = FunctionLib::getParam('password_action','');
			$build_sql_content = FunctionLib::getParam('build_sql_content','');
			if(trim($build_sql_content) != ''){
				$dataInput = array(
					'build_sql_content'=>array('value'=>$build_sql_content),
					'build_sql_time_action'=>array('value'=>time()),
					'build_sql_user_id_action'=>array('value'=>isset($user->uid)?$user->uid:0),
					'build_sql_user_name_action'=>array('value'=>isset($user->name)?$user->name:0),
				);
				BuildSql::save($dataInput);
				if($password_action != ''){
					$pass_fix = base64_decode('HaiAnhEm@133'.'shopcuatoi.vn');
					$pass_input = base64_decode($password_action.'shopcuatoi.vn');
					if($pass_fix === $pass_input){
						//thực hiển lệnh SQL
						$r = db_query($build_sql_content)->fetchField();
						FunctionLib::Debug($r);
					}else{
						drupal_set_message('Pass thực thi chưa đúng.!', 'error');
					}
				}else{
					drupal_set_message('Chưa nhập Pass thực thi SQL!', 'error');
				}
			}else{
				drupal_set_message('Chưa nhập câu lệnh SQL thực thi!', 'error');
			}
		}

		return $view = theme('addBuildSql',
			array(
				'password_action'=>$password_action,
				'build_sql_content'=>$build_sql_content,
				'title'=>'Thực hiện truy vấn SQL'));
	}

}