<?php
/*
* QuynhTM
 * Function dùng common trong admin
*/

class FunctionLib{
	/**
	 * @param $data
	 */
	static function FunctionDebug($data){
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
			return trim($_POST[$name]);
		}
		elseif(isset($_GET[$name])){
			return trim($_GET[$name]);
		}
		elseif (isset($_REQUEST[$name])){
			return trim($_REQUEST[$name]);
		}
		elseif(isset($_COOKIE[$name])){
			return trim($_COOKIE[$name]);
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
}
