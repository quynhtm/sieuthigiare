<?php
/*
* QuynhTM
 * Function dùng common trong admin
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

		$viN = array("không", "m?t", "hai", "ba", "b?n", "n?m", "sáu", "b?y", "tám", "chín");
		$viRow = array("", "nghìn", "tri?u", "t?");

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
					$Str = "m?t" . " " . $Str;
				else {
					if ($donvi == 5 && $chuc > 0)
						$Str = "l?m" . " " . $Str;
					else if ($donvi > 0)
						$Str = $so[$donvi] . " " . $Str;
				}
				if ($chuc < 0)
					break;
				else
					if ($chuc == 0 && $donvi > 0)
						$Str = "l?" . " " . $Str;
				if ($chuc == 1)
					$Str = "m??i" . " " . $Str;
				if ($chuc > 1)
					$Str = $so[$chuc] . " " . "m??i" . " " . $Str;
				if ($tram < 0)
					break;
				else
					if ($tram > 0 || $chuc > 0 || $donvi > 0)
						$Str = $so[$tram] . " " . "tr?m" . " " . $Str;
			}
		}
		return strtoupper(substr($Str, 0, 1)) . substr($Str, 1, strlen($Str) - 1) . ($lang == 'vi' ? "??ng" : 'vnd');
	}

	static function getThumbImage($fname = '', $id = 0, $folder = FOLDER_DEFAULT,$thum_w = 0,$thum_h = 0,$cropratio = '') {
		global $base_url;
		if($fname != '' && $id > 0) {
			$directory  = self::getFolderByID($id, $folder);
			$string_crop = ($cropratio != '') ? '&cropratio='.$cropratio : '';
			$paths_image = $base_url.'/uploads/'.$directory.'/'.$fname;
			$url_image = $base_url."/thumb_img/image.php?width={$thum_w}&height={$thum_h}{$string_crop}&image=".$paths_image;
			return $url_image;
		}
		return false;
	}

	static function getFolderByID($id = 0, $folder = FOLDER_DEFAULT) {
		return  $folder . '/' . $id . '/';
	}
}
