<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class AjaxAction{
	
    function run(){
        $action = FunctionLib::getParam('act', '');

        switch( $action ){
            case 'action_update_status' :
                $this->action_update_status();
                break;
            default:
                $this->action_index();
                break;
        }
    }

    function action_index(){
        die("Nothing to do...");
    }
    
    function action_update_status(){
        
    }
}