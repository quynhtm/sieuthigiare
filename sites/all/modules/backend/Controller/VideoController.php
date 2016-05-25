<?php
/*
* QuynhTM
*/
class VideoController{
	private $arrStatus = array(-1 => '--Chọn trạng thái--', STASTUS_SHOW => 'Hiển thị', STASTUS_HIDE => 'Ẩn');
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

	function indexVideo(){
		global $base_url;
		$limit = SITE_RECORD_PER_PAGE;
		//search


		$dataSearch['video_id'] = FunctionLib::getParam('video_id', -1);
		$dataSearch['video_name'] = FunctionLib::getParam('video_name', '');
		$dataSearch['video_status'] = FunctionLib::getIntParam('video_status', -1);

		$result = Video::getSearchListItems($dataSearch,$limit,array());
		if(isset($result['data']) && !empty($result['data'])){
			foreach($result['data'] as $k => &$value){
				if( isset($value->video_img) && trim($value->video_img) != ''){
					$value->url_image = FunctionLib::getThumbImage($value->video_img,$value->video_id,FOLDER_VIDEO,80,80);
					$value->url_image_hover = FunctionLib::getThumbImage($value->video_img,$value->video_id,FOLDER_VIDEO,450,200);
				}
			}
		}
		//build option
		$optionStatus = FunctionLib::getOption($this->arrStatus, $dataSearch['video_status']);
		return $view = theme('indexVideo',array(
									'title'=>'Video',
									'result' => $result['data'],
									'dataSearch' => $dataSearch,
									'optionStatus' => $optionStatus,
									'arrProductStatus' => $this->arrStatus,
									'base_url' => $base_url,
									'totalItem' =>$result['total'],
									'pager' =>$result['pager']));
	}

	function formVideoAction(){
		global $base_url;

		$files = array(
			'bootstrap/lib/upload/cssUpload.css',
			'bootstrap/js/bootstrap.min.js',
			'bootstrap/lib/upload/jquery.uploadfile.js',
			'js/common_admin.js',

			'bootstrap/lib/datetimepicker/datetimepicker.css',
			'bootstrap/lib/datetimepicker/jquery.datetimepicker.js',
		);
		Loader::load('Core', $files);

		
		$param = arg();
		$arrItem = $arrImageOther = array();
		$item_id = 0;
		if(isset($param[2]) && isset($param[3]) && $param[2]=='edit' && $param[3]>0){
			$item_id = (int)$param[3];
			$arrItem = Video::getItemById(array(), $item_id);
		}
		if(!empty($_POST) && $_POST['txt-form-post']=='txt-form-post'){
			$item_id = FunctionLib::getParam('id', 0);
			$video_img = trim(FunctionLib::getParam('img', ''));
			$video_img_old = trim(FunctionLib::getParam('img_old', ''));
			$dataInput = array(
				'video_name'=>array('value'=>FunctionLib::getParam('video_name',''), 'require'=>1, 'messages'=>'Tên Video không được bỏ trống!'),
				'video_link'=>array('value'=>FunctionLib::getParam('video_link',''), 'require'=>1, 'messages'=>'Link video không được bỏ trống!'),
				'video_img'=>array('value'=>$video_img, 'require'=>0),
				'video_status'=>array('value'=>FunctionLib::getParam('video_status',STASTUS_SHOW)),
				'video_sort_desc'=>array('value'=>FunctionLib::getParam('video_sort_desc','')),
				'video_content'=>array('value'=>FunctionLib::getParam('video_content','')),
				'video_time_update'=>array('value'=>time()),
			);
			$errors = ValidForm::validInputData($dataInput);
			if($errors != ''){
				drupal_set_message($errors, 'error');
				if($item_id > 0){
					drupal_goto($base_url.'/admincp/video/edit/'.$item_id);
				}else{
					drupal_goto($base_url.'/admincp/video/add');
				}
			}else{
				if($item_id == 0) {
					$dataInput['video_time_creater']['value'] = time();
				}
				//so sánh ảnh cũ và mơi, nếu khác nhau thì xóa ảnh cũ đi
				if($video_img_old !== '' && $video_img !== '' && strcmp ( $video_img_old , $video_img ) != 0 && $item_id > 0){
					//xoa anh cũ
					$path = PATH_UPLOAD.'/'.FOLDER_VIDEO.'/'.$item_id;
					if(is_file($path.'/'.$video_img_old)){
						@unlink($path.'/'.$video_img_old);
					}
					FunctionLib::delteImageCacheItem(FOLDER_VIDEO, $item_id);
				}

				//FunctionLib::Debug($dataInput);
				Video::save($dataInput, $item_id);
				if(Cache::CACHE_ON){
					$key_cache = Cache::VERSION_CACHE.Cache::CACHE_VIDEO_ID.$item_id;
					$cache = new Cache();
					$cache->do_remove($key_cache);
				}
				drupal_goto($base_url.'/admincp/video');
			}
		}
		$optionStatus = FunctionLib::getOption($this->arrStatus, isset($arrItem->video_status) ? $arrItem->video_status: STASTUS_SHOW);
		return $view = theme('addVideo',
			array('arrItem'=>$arrItem,
				'item_id'=>$item_id,
				'title'=>'Video giải trí',
				'optionStatus'=>$optionStatus));
	}

	function deleteVideoAction(){
		global $base_url;
		if(isset($_POST) && $_POST['txtFormName']=='txtFormName'){
			$listId = FunctionLib::getParam('checkItem',array());
			if(!empty($listId)){
				foreach($listId as $id){
					if($id > 0){
						Video::deleteOne($id);
					}
				}
				drupal_set_message('Xóa bài viết thành công.');
			}
		}
		drupal_goto($base_url.'/admincp/video');
	}
}