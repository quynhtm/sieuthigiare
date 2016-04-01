<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/

/*
<form name="frmUpload" method="post" enctype="multipart/form-data">
	<input type="file" name="image"/>
	<input type="submit" value="upload" />
</form>

if(isset($_POST)){
	$HSSUpload = new HSSUpload();
	echo $HSSUpload->upload($_name='image', $_file_ext='rar,flv,mp4', $_max_file_size=150*1024*1024, $_module='news',  $type_json=1);
}
*/
class AjaxUpload{
	static $primary_key_news = 'news_id';
	function playme(){
		$code = FunctionLib::getIntParam('code', '');
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
		global $display;
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
                $aryData = $this->uploadImageToFolder($dataImg, $id_hiden, TABLE_NEWS, 'news');
                break;
            case 2 ://img product
                $aryData = $this->uploadImageToFolder($dataImg, $id_hiden, TABLE_PRODUCT, 'product');
                break;
            default:
                break;
        }
		echo json_encode($aryData);
		exit();
	}

	function uploadImageToFolder($dataImg, $id_hiden, $table_action, $folder){
        global $base_url;
        $aryData = array();
        $aryData['intIsOK'] = -1;
        $aryData['msg'] = "Data not exists!";

        if (!empty($dataImg)) {
            if($id_hiden == 0){
                $new_row['news_create'] = TIME_NOW;
                $new_row['news_status'] = 13;
                $id = DB::insertOneItem($table_action, $new_row);
            }elseif($id_hiden > 0){
                $id = $id_hiden;
            }
            $aryError = $tmpImg = array();
            $old_file = '';
            
            $file_name = Upload::uploadFile('multipleFile', 
	                           $_file_ext = 'jpg,jpeg,png,gif', 
	                           $_max_file_size = 10*1024*1024, 
	                           $_folder = $folder, 
	                           $type_json=0
                           );
             
            if ($file_name != '' && empty($aryError)) {
                $tmpImg['name_img'] = $file_name;
                $tmpImg['id_key'] = rand(10000, 99999);
              
                $tmpImg['src'] = $base_url.'/uploads/product/'.$file_name;
                
                $listImageTempOther = DB::getItemById($table_action, self::$primary_key_news, array('news_image_other'), $id);
                
                if(!empty($listImageTempOther)){
                	$aryTempImages = ($listImageTempOther[0]->news_image_other !='')? unserialize($listImageTempOther[0]->news_image_other): array();
               	}
                $aryTempImages[] = $file_name;
                $new_row['news_image_other'] = serialize($aryTempImages);
                DB::updateId($table_action, self::$primary_key_news, $new_row, $id);
            }
            $aryData['intIsOK'] = 1;
            $aryData['id_item'] = $id;
            $aryData['info'] = $tmpImg;
        }
        return $aryData;
    }
}