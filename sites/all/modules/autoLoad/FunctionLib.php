<?php
/*
* QuynhTM
 * Function dÃ¹ng common trong admin
*/

class FunctionLib{

	/**
	 * @param $data
	 */
	static function Debug($data){
		echo '<pre>';
			print_r($data);
		echo '</pre>';
		die();
	}

	/**
	 * @param $name
	 * @param string $default
	 * @return string
	 */
	static function getParam($name, $default = ''){
		if (isset($_POST[$name])){
			return $_POST[$name];
		}
		elseif(isset($_GET[$name])){
			return $_GET[$name];
		}
		elseif (isset($_REQUEST[$name])){
			return $_REQUEST[$name];
		}
		elseif(isset($_COOKIE[$name])){
			return $_COOKIE[$name];
		}
		else{
			return $default;
		}
	}

	/**
	 * @param $name
	 * @param int $default
	 * @return int
	 */
	static function getIntParam($name, $default = 0){
		if (isset($_POST[$name])){
			return (int)trim($_POST[$name]);
		}
		elseif(isset($_GET[$name])){
			return (int)trim($_GET[$name]);
		}
		elseif (isset($_REQUEST[$name])){
			return (int)trim($_REQUEST[$name]);
		}
		elseif(isset($_COOKIE[$name])){
			return (int)trim($_COOKIE[$name]);
		}
		else{
			return $default;
		}
	}
	/**
	 * build html select option
	 *
	 * @param array $options_array
	 * @param int $selected
	 * @param array $disabled
	 */
	static function getOption($options_array, $selected, $disabled = array()) {
		$input = '';
		if ($options_array)
			foreach ($options_array as $key => $text) {
				$input .= '<option value="' . $key . '"';
				if (!in_array($selected, $disabled)) {
					if ($key === '' && $selected === '') {
						$input .= ' selected';
					} else
						if ($selected !== '' && $key == $selected) {
							$input .= ' selected';
						}
				}
				if (!empty($disabled)) {
					if (in_array($key, $disabled)) {
						$input .= ' disabled';
					}
				}
				$input .= '>' . $text . '</option>';
			}
		return $input;
	}

	/**
	 * build html select option mutil
	 *
	 * @param array $options_array
	 * @param array $arrSelected
	 */
	static function getOptionMultil($options_array, $arrSelected) {
		$input = '';
		if ($options_array)
			foreach ($options_array as $key => $text) {
				$input .= '<option value="' . $key . '"';
				if ($key === '' && empty($arrSelected)) {
					$input .= ' selected';
				} else
					if (!empty($arrSelected) && in_array($key, $arrSelected)) {
						$input .= ' selected';
					}
				$input .= '>' . $text . '</option>';
			}
		return $input;
	}

	static function numberFormat($number = 0) {
		if ($number >= 1000) {
			return number_format($number, 0, ',', '.');
		}
		return $number;
	}

	static function post_db_parse_html($t=""){
		if ( $t == "" ){
			return $t;
		}
		$t = str_replace( "&#39;"   , "'", $t );
		$t = str_replace( "&#33;"   , "!", $t );
		$t = str_replace( "&#036;"   , "$", $t );
		$t = str_replace( "&#124;"  , "|", $t );
		$t = str_replace( "&amp;"   , "&", $t );
		$t = str_replace( "&gt;"    , ">", $t );
		$t = str_replace( "&lt;"    , "<", $t );
		$t = str_replace( "&quot;"  , '"', $t );

		//-----------------------------------------
		// Take a crack at parsing some of the nasties
		// NOTE: THIS IS NOT DESIGNED AS A FOOLPROOF METHOD
		// AND SHOULD NOT BE RELIED UPON!
		//-----------------------------------------

		$t = preg_replace( "/javascript/i" , "j&#097;v&#097;script", $t );
		$t = preg_replace( "/alert/i"      , "&#097;lert"          , $t );
		$t = preg_replace( "/about:/i"     , "&#097;bout:"         , $t );
		$t = preg_replace( "/onmouseover/i", "&#111;nmouseover"    , $t );
		$t = preg_replace( "/onmouseout/i", "&#111;nmouseout"    , $t );
		$t = preg_replace( "/onclick/i"    , "&#111;nclick"        , $t );
		$t = preg_replace( "/onload/i"     , "&#111;nload"         , $t );
		$t = preg_replace( "/onsubmit/i"   , "&#111;nsubmit"       , $t );
		$t = preg_replace( "/object/i"   , "&#111;bject"       , $t );
		$t = preg_replace( "/frame/i"   , "fr&#097;me"       , $t );
		$t = preg_replace( "/applet/i"   , "&#097;pplet"       , $t );
		$t = preg_replace( "/meta/i"   , "met&#097;"       , $t );

		return $t;
	}

	static function stripUnicode($str){
		if(!$str) return false;
		$marTViet = array("à", "á", "ạ", "ả", "ã", "â", "ầ", "ấ", "ậ", "ẩ", "ẫ", "ă",
            "ằ", "ắ", "ặ", "ẳ", "ẵ", "è", "é", "ẹ", "ẻ", "ẽ", "ê", "ề", "ế", "ệ", "ể", "ễ",
            "ì", "í", "ị", "ỉ", "ĩ",
            "ò", "ó", "ọ", "ỏ", "õ", "ô", "ồ", "ố", "ộ", "ổ", "ỗ", "ơ", "ờ", "ớ", "ợ", "ở", "ỡ",
            "ù", "ú", "ụ", "ủ", "ũ", "ư", "ừ", "ứ", "ự", "ử", "ữ",
            "ỳ", "ý", "ỵ", "ỷ", "ỹ",
            "đ",
            "À", "Á", "Ạ", "Ả", "Ã", "Â", "Ầ", "Ấ", "Ậ", "Ẩ", "Ẫ", "Ă", "Ằ", "Ắ", "Ặ", "Ẳ", "Ẵ",
            "È", "É", "Ẹ", "Ẻ", "Ẽ", "Ê", "Ề", "Ế", "Ệ", "Ể", "Ễ",
            "Ì", "Í", "Ị", "Ỉ", "Ĩ",
            "Ò", "Ó", "Ọ", "Ỏ", "Õ", "Ô", "Ồ", "Ố", "Ộ", "Ổ", "Ỗ", "Ơ"
            , "Ờ", "Ớ", "Ợ", "Ở", "Ỡ",
            "Ù", "Ú", "Ụ", "Ủ", "Ũ", "Ư", "Ừ", "Ứ", "Ự", "Ử", "Ữ",
            "Ỳ", "Ý", "Ỵ", "Ỷ", "Ỹ",
            "Đ");

		$marKoDau=array("a","a","a","a","a","a","a","a","a","a","a"
		,"a","a","a","a","a","a",
		"e","e","e","e","e","e","e","e","e","e","e",
		"i","i","i","i","i",
		"o","o","o","o","o","o","o","o","o","o","o","o"
		,"o","o","o","o","o",
		"u","u","u","u","u","u","u","u","u","u","u",
		"y","y","y","y","y",
		"d",
		"A","A","A","A","A","A","A","A","A","A","A","A"
		,"A","A","A","A","A",
		"E","E","E","E","E","E","E","E","E","E","E",
		"I","I","I","I","I",
		"O","O","O","O","O","O","O","O","O","O","O","O"
		,"O","O","O","O","O",
		"U","U","U","U","U","U","U","U","U","U","U",
		"Y","Y","Y","Y","Y",
		"D");

		$str = str_replace($marTViet,$marKoDau,$str);
		return $str;
	}
	static function _name_cleaner($name,$replace_string="_"){
		return preg_replace( "/[^a-zA-Z0-9\-\_]/", $replace_string , $name );
	}

	//cac-ky-sap-xep-gan-nhau
	static function safe_title($text) {
		$text = FunctionLib::post_db_parse_html($text);
		$text = FunctionLib::stripUnicode($text);
		$text = self::_name_cleaner($text, "-");
		$text = str_replace("----", "-", $text);
		$text = str_replace("---", "-", $text);
		$text = str_replace("--", "-", $text);
		$text = trim($text, '-');

		if ($text) {
			return $text;
		} else {
			return "shop";
		}
	}

	//cackysapxepgannhau
	static function stringtitle($text) {
		$text = FunctionLib::post_db_parse_html($text);
		$text = FunctionLib::stripUnicode($text);
		$text = self::_name_cleaner($text, "-");
		$text = str_replace("----", "-", $text);
		$text = str_replace("---", "-", $text);
		$text = str_replace("--", "-", $text);
		$text = str_replace("-", "", $text);
		$text = trim($text);

		if ($text) {
			return $text;
		} else {
			return "shop";
		}
	}

	static function strip_html_tags($string){
		return preg_replace(array('/\<(script)(.+)>/i', '/\<(.+)(script)>/i', '/\<(style)(.+)>/i', '/\<(.+)(style)>/i'), '', $string);
	}

	static function cutString($str, $num) {
		$arr_str = explode(' ', $str);
		$count = count($arr_str);
		$arr_str = array_slice($arr_str, 0, $num);
		$res = implode(' ', $arr_str);
		if ($count > $num) {
			$res .= ' ...';
		}
		return $res;
	}

	static function cutString2($str, $num) {
		$arr_str = explode(' ', $str);
		$count = count($arr_str);
		$arr_str = array_slice($arr_str, 0, $num);
		$res = implode(' ', $arr_str);
		return $res;
	}

	public  static function numberToWord($s, $lang = 'vi') {
		$ds = 0;
        $so = $hang = array();

        $viN = array("không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín");
        $viRow = array("", "nghìn", "triệu", "tỷ");

        $enN = array("zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine");
        $enRow = array("", "thousand", "million", "billion");

        if ($lang == 'vi') {
            $so = $viN;
            $hang = $viRow;
        } else {
            $so = $enN;
            $hang = $enRow;
        }

        $s = str_replace(",", "", $s);
        $ds = (int) $s;
        if ($ds == 0) {
            return "không ";
        }

        $i = $j = $donvi = $chuc = $tram = 0;
        $i = strlen($s);

        $Str = "";
        if ($i == 0)
            $Str = "";
        else {
            $j = 0;
            while ($i > 0) {
                $donvi = substr($s, $i - 1, 1);
                $i = $i - 1;
                if ($i > 0) {
                    $chuc = substr($s, $i - 1, 1);
                } else {
                    $chuc = -1;
                }
                $i = $i - 1;
                if ($i > 0) {
                    $tram = substr($s, $i - 1, 1);
                } else {
                    $tram = -1;
                }
                $i = $i - 1;
                if ($donvi > 0 || $chuc > 0 || $tram > 0 || $j == 3)
                    $Str = $hang[$j] . " " . $Str;
                $j = $j + 1;
                if ($j > 3)
                    $j = 1;
                if ($donvi == 1 && $chuc > 1)
                    $Str = "mốt" . " " . $Str;
                else {
                    if ($donvi == 5 && $chuc > 0)
                        $Str = "lăm" . " " . $Str;
                    else if ($donvi > 0)
                        $Str = $so[$donvi] . " " . $Str;
                }
                if ($chuc < 0)
                    break;
                else
                if ($chuc == 0 && $donvi > 0)
                    $Str = "lẻ" . " " . $Str;
                if ($chuc == 1)
                    $Str = "mười" . " " . $Str;
                if ($chuc > 1)
                    $Str = $so[$chuc] . " " . "mươi" . " " . $Str;
                if ($tram < 0)
                    break;
                else
                if ($tram > 0 || $chuc > 0 || $donvi > 0)
                    $Str = $so[$tram] . " " . "trăm" . " " . $Str;
            }
        }
        return strtoupper(substr($Str, 0, 1)) . substr($Str, 1, strlen($Str) - 1) . ($lang == 'vi' ? "đồng" : 'vnd');
	}

	static function getThumbImage($fname = '', $id = 0, $folder = FOLDER_DEFAULT,$thum_w = 0,$thum_h = 0,$cropratio = '') {
		global $base_url;
		if($fname != '' && $id > 0) {
			$directory  = self::getFolderByID($id, $folder);
			$string_crop = ($cropratio != '') ? '&cropratio='.$cropratio : '';
			$paths_image = $base_url.'/uploads/'.$directory.'/'.$fname;
			$url_image = $base_url.'/image.php?type_dir='.$folder.'&id='.$id."&width={$thum_w}&height={$thum_h}{$string_crop}&image=".$paths_image;
			return $url_image;
		}
		return false;
	}

	static function getFolderByID($id = 0, $folder = FOLDER_DEFAULT) {
		return  $folder . '/' . $id;
	}

	static function delteImageCacheItem($folder=FOLDER_DEFAULT, $id=0){
		if($id>0){
			$path = PATH_UPLOAD.'/'.$folder.'/'.$id.'/imagecache/';
			if (is_dir($path)) {
				if ($dh = opendir($path)) {
					while (($file = readdir($dh)) !== false) {
						if ($file != '.' && $file != '..') {
							unlink(realpath($path . $file));
						}
					}
					closedir($dh);
				}
				if(is_dir($path)) {
	                @rmdir($path);
	            }
			}
			
		}
	}

	/*
		DuyNx base 64 string
		$start_add_str: so ky tu dau them vao
		$end_add_str: so ky tu cuoi them vao
	*/
	public static function base64EncodeStr($str='', $start_add_str='', $end_add_str=''){
		if($str != ''){
			if($start_add_str != ''){
				$str .= $start_add_str;
			}
			if($end_add_str != ''){
				$str .= $end_add_str;
			}
			return base64_encode($str);
		}
		return '';
	}
	/*
		DuyNx base 64 string
		$start_cut_str: so ky tu dau cat bo
		$end_add_str: so ky tu cuoi cat bo
	*/
	public static function base64DecodeStr($str='', $start_cut_str=0, $end_cut_str=0){
		if($str != ''){
			$str = base64_decode($str);
			if($start_cut_str > 0){
				$str = substr($str, $start_cut_str);
			}
			if($end_cut_str < 0 && strlen($str) > abs($end_cut_str)){
				$str = substr($str, 0, $end_cut_str);
			}
			return intval($str);
		}
		return '';
	}

	static function getOptionTreeCategory($options_array, $selected, $disabled = array()) {
		$input = '<option value="0">-- Chọn danh mục  --</option>';
		if ($options_array)
			foreach ($options_array as $k => $val) {
				$key = $val['category_id'];
				$input .= '<option value="' . $key . '"';
				if (!in_array($selected, $disabled)) {
					if ($key === '' && $selected === '') {
						$input .= ' selected';
					} else
						if ($selected !== '' && $key == $selected) {
							$input .= ' selected';
						}
				}
				if (!empty($disabled)) {
					if (in_array($key, $disabled)) {
						$input .= ' disabled';
					}
				}
				$input .= '>' . $val['padding_left'] . $val['category_name'] . '</option>';
			}
		return $input;
	}
	/*
	* DuyNx cut string
	* $start_cut_str: so ky tu dau cat bo
	* $end_add_str: so ky tu cuoi cat bo
	*/
	public static function cutStr($str='', $start_cut_str=0, $end_cut_str=0){
		if($str != ''){
			if($start_cut_str > 0){
				$str = substr($str, $start_cut_str);
			}
			if($end_cut_str < 0 && strlen($str) > abs($end_cut_str)){
				$str = substr($str, 0, $end_cut_str);
			}
			return intval($str);
		}
		return '';
	}

	public static function buildLinkCategory($shop_id = 0, $shop_name = 'shop', $category_id = 0, $category_name = 'danh muc'){
		global $base_url;
		
		$url = '';
		if($shop_id > 0 && $category_id > 0 && $category_name !=''){
			$url = $base_url.'/gian-hang/'.$shop_id.'/c'.$category_id.'/'.self::safe_title($category_name).'.html';
		}
		elseif($shop_id > 0 && $shop_name !=''){
			$url = $base_url.'/gian-hang/'.$shop_id.'/'.self::safe_title($shop_name).'.html';
		}elseif($category_id > 0 && $category_name !=''){
			$url = $base_url.'/danh-muc/c'.$category_id.'/'.self::safe_title($category_name).'.html';
		}
		return $url;
	}

	public static function buildLinkDetail($product_id = 0, $product_name = ''){
		global $base_url;
		$url = '';
		if($product_id > 0 && $product_name !=''){
			$url = $base_url.'/san-pham/p'.$product_id.'/'.self::safe_title($product_name).'.html';
		}
		return $url;
	}

	public static function buildLinkNewsDetail($cat_alias='', $news_id = 0, $news_title = ''){
		global $base_url;
		$url = '';
		if($cat_alias !='' && $news_id > 0 && $news_title !=''){
			$url = $base_url.'/'.$cat_alias.'/t'.$news_id.'/'.self::safe_title($news_title).'.html';
		}
		return $url;
	}

	public static function buildLinkVideoDetail($cat_alias='', $video_id = 0, $video_name = ''){
		global $base_url;
		$url = '';
		if($cat_alias !='' && $video_id > 0 && $video_name !=''){
			$url = $base_url.'/'.$cat_alias.'/v'.$video_id.'/'.self::safe_title($video_name).'.html';
		}
		return $url;
	}
}
