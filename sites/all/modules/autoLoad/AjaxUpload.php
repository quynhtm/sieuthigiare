<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class AjaxUpload{
	static $primary_key_news = 'news_id';
    static $primary_key_project = 'id';

	function playme(){
		$code = FunctionLib::getParam('code', '');

		switch( $code ){
            case 'upload_image' :
				$this->upload_image();
				break;
            //up anh chen vao noi dung mo ta
            case 'upload_image_insert_content' :
				$this->upload_image_insert_content();
				break;
            case 'remove_image' :
				$this->remove_image();
				break;
			default:
				$this->home();
				break;
		}
	}
	function home(){
		die("Nothing to do...");
	}

	function upload_image() {
        $id_hiden = FunctionLib::getIntParam('id', 0);
        $type = FunctionLib::getIntParam('type', 1);
        $dataImg = $_FILES["multipleFile"];
        $aryData = array();
        $aryData['intIsOK'] = -1;
        $aryData['msg'] = "Data not exists!";
        
        switch( $type ){
            case 1://img news
                $aryData = $this->uploadImageToFolder($dataImg, $id_hiden, TABLE_NEWS, FOLDER_NEWS, 'news_image_other', self::$primary_key_news);
                break;
            case 2 ://img product
                $aryData = $this->uploadImageToFolder($dataImg, $id_hiden, TABLE_PRODUCT, FOLDER_PRODUCT, 'product_image_other', self::$primary_key_project);
                break;
            default:
                break;
        }
		echo json_encode($aryData);
		exit();
	}

	function uploadImageToFolder($dataImg, $id_hiden, $table_action, $folder, $field_img_other='', $primary_key){
        global $base_url;
        $aryData = array();
        $aryData['intIsOK'] = -1;
        $aryData['msg'] = "Upload Img!";
        $item_id = 0; // id doi tuong dang upload

        if (!empty($dataImg)) {
            if($id_hiden == 0){
                if($field_img_other == 'news_image_other'){
                    $new_row['news_create'] = time();
                    $new_row['news_status'] = 0;
                }elseif($field_img_other == 'product_image_other'){
                    $new_row['time_created'] = time();
                    $new_row['status'] = 0;
                }
                $item_id = DB::insertOneItem($table_action, $new_row);
            }elseif($id_hiden > 0){
                $item_id = $id_hiden;
            }

            $aryError = $tmpImg = array();
            $old_file = '';
            
            $file_name = Upload::uploadFile('multipleFile', 
	                           $_file_ext = 'jpg,jpeg,png,gif', 
	                           $_max_file_size = 10*1024*1024, 
	                           $_folder = $folder.'/'.$item_id,
	                           $type_json=0
                           );
            
            if ($file_name != '' && empty($aryError)) {
                $tmpImg['name_img'] = $file_name;
                $tmpImg['id_key'] = rand(10000, 99999);
               
                $tmpImg['src'] = $base_url.'/uploads/'.$folder.'/'.$item_id.'/'.$file_name;
                if($field_img_other != ''){
                    $listImageTempOther = DB::getItemById($table_action, $primary_key, array($field_img_other), $item_id);
                    if(!empty($listImageTempOther)){
                    	$aryTempImages = ($listImageTempOther[0]->$field_img_other !='')? unserialize($listImageTempOther[0]->$field_img_other): array();
                   	}
                    $aryTempImages[] = $file_name;
                    $new_row[$field_img_other] = serialize($aryTempImages);
                    DB::updateId($table_action, $primary_key, $new_row, $item_id);
                }
            }
            $aryData['intIsOK'] = 1;
            $aryData['id_item'] = $item_id;
            $aryData['info'] = $tmpImg;
        }
        return $aryData;
    }
    function remove_image(){
        
        $id = FunctionLib::getIntParam('id', 0);
        $nameImage = FunctionLib::getParam('nameImage', '');
        $type = FunctionLib::getIntParam('type', 1);

        $aryData = array();
        $aryData['intIsOK'] = -1;
        $aryData['msg'] = "Remove Img!";
        $aryData['nameImage'] = $nameImage;
        switch( $type ){
            case 1://anh tin tuc
                $folder_image = 'uploads/'.FOLDER_NEWS;
                $table_action = TABLE_NEWS;
                if($id > 0 && $nameImage != '' && $folder_image != ''){
                    $delete_action = $this->delete_image_item($table_action, self::$primary_key_news, $id, 'news_image_other', $nameImage, $folder_image);
                    if($delete_action == 1){
                        $aryData['intIsOK'] = 1;
                        $aryData['msg'] = "Remove Img!";
                    }
                }
                break;
            case 1://anh san pham
                $folder_image = 'uploads/'.FOLDER_PRODUCT;
                $table_action = TABLE_PRODUCT;
                if($id > 0 && $nameImage != '' && $folder_image != ''){
                    $delete_action = $this->delete_image_item($table_action, self::$primary_key_project, $id, 'product_image_other', $nameImage, $folder_image);
                    if($delete_action == 1){
                        $aryData['intIsOK'] = 1;
                    }
                }
                break;
            default:
                $folder_image = '';
                break;
        }
        echo json_encode($aryData);
        exit();
    }

    function delete_image_item($table_action, $primary_key, $id, $field = '', $nameImage, $folder_image){
        $delete_action = 0;
        $aryImages  = array();
        //get img in DB and remove it
        if($field != ''){
            $listImageOther = DB::getItemById($table_action, $primary_key, array($field), $id);
            $aryImages = unserialize($listImageOther[0]->$field);
        }
        if(is_array($aryImages) && count($aryImages) > 0) {
            foreach ($aryImages as $k => $v) {
                if($v === $nameImage){
                    $this->unlinkFileAndFolder($nameImage, $id, $folder_image, true);
                    unset($aryImages[$k]);
                    if(!empty($aryImages)){
                        $aryImages = serialize($aryImages);
                    }else{
                        $aryImages = '';
                    }
                    DB::updateId($table_action, $primary_key, array($field=>$aryImages), $id);
                    $delete_action = 1;
                    break;
                }
            }
        }
        //xoa khi chua update vao db, anh moi up load
        if($delete_action == 0){
            $this->unlinkFileAndFolder($nameImage, $id, $folder_image, true);
            $delete_action = 1;
        }
        return $delete_action;
    }

    function unlinkFileAndFolder($file_name = '', $id = 0, $folder = '', $is_delDir = 0){
       
        if($file_name != '') {
            //Xoa anh goc
            $paths = '';
            if($folder != '' && $id >0){
                $path = DRUPAL_ROOT.'/'.$folder.'/'.$id;
            }

            if($file_name != ''){
                if($path != ''){
                    if(is_file($path.'/'.$file_name)){
                        @unlink($path.'/'.$file_name);
                    }
                }
            }
            //Xoa thu muc
            if($is_delDir) {
                if($path != ''){
                    if(is_dir($path)) {
                        @rmdir($path);
                    }
                }  
            }
        }
    }
}