<?php 
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0 
*/
class Stdio{

    function __construct(){
        //init here
    }
   
    //function replace a string to alias string
    function pregReplaceStringAlias($str=''){
        if(!$str) return '';
        if($str !=''){
            $str = str_replace(array('^', '$', '\\', '/', '(', ')', '|', '?', '+', '_', '*', '[', ']', '{', '}', ',', '.', '%', '<', '>', '=', '"', '“', '”', '!', ':', ';', '&', '~', '#', '`', "'", '@' ), array(''), html_entity_decode(trim($str)));

            $unicode = array(
                'a'=>'á|à|ả|ã|ạ|ă|ắ|ặ|ằ|ẳ|ẵ|â|ấ|ầ|ẩ|ẫ|ậ',
                'd'=>'đ',
                'e'=>'é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ',
                'i'=>'í|ì|ỉ|ĩ|ị',
                'o'=>'ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ',
                'u'=>'ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự',
                'y'=>'ý|ỳ|ỷ|ỹ|ỵ',
                'A'=>'Á|À|Ả|Ã|Ạ|Ă|Ắ|Ặ|Ằ|Ẳ|Ẵ|Â|Ấ|Ầ|Ẩ|Ẫ|Ậ',
                'D'=>'Đ',
                'E'=>'É|È|Ẻ|Ẽ|Ẹ|Ê|Ế|Ề|Ể|Ễ|Ệ',
                'I'=>'Í|Ì|Ỉ|Ĩ|Ị',
                'O'=>'Ó|Ò|Ỏ|Õ|Ọ|Ô|Ố|Ồ|Ổ|Ỗ|Ộ|Ơ|Ớ|Ờ|Ở|Ỡ|Ợ',
                'U'=>'Ú|Ù|Ủ|Ũ|Ụ|Ư|Ứ|Ừ|Ử|Ữ|Ự',
                'Y'=>'Ý|Ỳ|Ỷ|Ỹ|Ỵ',
            );
            foreach($unicode as $nonUnicode=>$uni){
                $str = preg_replace("/($uni)/i", $nonUnicode, $str);
            }

            $str = preg_replace("/\s+/","-",$str);
            $str = preg_replace("/\-+/","-",$str);

            return strtolower($str);
        }
    }

	//replace ->"<- to ->'<-
	function chage_text($str=''){
		if($str=='') return '';
        if($str !=''){
            $str = preg_replace('/"/',"'",$str);
            return $str;
		}	
	}
}