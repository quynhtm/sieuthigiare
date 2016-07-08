<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2016
* @Version	 : 1.0
*/

require_once __DIR__.'/libs/PHPThumb/PHPThumb.php';
require_once __DIR__.'/libs/PHPThumb/GD.php';

if(!class_exists('ThumbImg') ){
	   
	class ThumbImg{
		private $__name = 'Thumbs img';
		
		public static function makeDir($folder = '', $id = 0, $path = ''){
			$folders = explode('/', ($path));
			$tmppath =  DRUPAL_ROOT.'/uploads/thumbs/'.$folder.'/'.$id.'/';

			if(!file_exists($tmppath)){
				mkdir($tmppath, 0777, true);
			};

			for($i = 0; $i < count($folders) - 1; $i++) {
				if(!file_exists($tmppath . $folders[$i]) && ! mkdir($tmppath . $folders [$i], 0777)){
					return false;
				}
				$tmppath = $tmppath . $folders [$i] . '/';
			}
			return true;
		}

		public static function thumbBaseNormal($folder='', $id=0, $path='', $width=100, $height=100, $alt='', $isThumb=true, $returnPath=false){
			
			if(!preg_match("/.jpg|.jpeg|.JPEG|.JPG|.png|.gif/",strtolower($path))) return ' ';
			
			$domain = 'http://'.$_SERVER['HTTP_HOST'].$GLOBALS['base_path'];
			$url_img = '';

			if($isThumb){
				
				$imagSource = DRUPAL_ROOT.'/uploads/' .$folder. '/'. $id. '/' .$path;
				$paths =  $width."x".$height.'/'.$path;
				$thumbPath = DRUPAL_ROOT.'/uploads/thumbs/'.$folder.'/'.$id.'/'. $paths;
				$url_img = $domain.'uploads/thumbs/'.$folder.'/'.$id.'/'. $paths;

				if(!file_exists($thumbPath)){
					if(file_exists($imagSource)){
						
						$objThumb = new PHPThumb\GD($imagSource);
						$objThumb->resize($width, $height);
		
						if(!file_exists($thumbPath)){
							if(!self::makeDir($folder, $id, $paths)){
								return '';
							}
							self::saveCustom($imagSource);
						}

						$objThumb->show(true, $thumbPath);
					}else{
						$url_img = IMAGE_DEFAULT;
					}
				}
			}

			if($returnPath){
				return $url_img;
			}else{
				return '<img src="'.$url_img.'" alt="'.$alt.'"/>';
			}
		}

		public static function saveCustom($fileName){
			@chmod($fileName, 0777);
			return true;
		}
	}
}