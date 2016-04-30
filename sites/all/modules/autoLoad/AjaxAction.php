<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class AjaxAction{
	
    function run($action){
        switch( $action ){
            case 'action_order_update_status' :
                $this->action_order_update_status();
                break;
            default:
                $this->action_index();
                break;
        }
    }

    function action_index(){
        die("Nothing to do...");
    }
    
    function action_order_update_status(){
        global $user_shop;

        $order_id       = FunctionLib::getParam('order_id',0);
        $order_status   = trim(FunctionLib::getParam('order_status', -1));
        $order_user_shop_id = $user_shop->shop_id;
        
        if($order_id > 0 && $order_status > 0 && $order_user_shop_id > 0){
            
            $cond = 'order_id='.$order_id.' AND order_user_shop_id='.$order_user_shop_id;
            $check_order = OrdersShop::getItembyCond('order_id', $cond);
            if(!empty($check_order)){
                OrdersShop::save(array('order_status'=>$order_status), $order_id);
                echo 'ok';die;
            }else{
                echo 'not';die;
            }
        }
        echo 'not';die;
    }
}