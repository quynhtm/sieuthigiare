<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class DbBasic{

    public static function getSearchListItemsAndPage($tableAction, $dataSearch=array(), $arrFields=array(), $limit=30, &$totalItem=0, &$pager=array()){
        $arrItem=array();
        if(!empty($arrFields)){
            $sql = db_select($tableAction, 'i')->extend('PagerDefault');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }

            /*Begin search*/
            if($dataSearch['category'] > 0){
                $sql->condition('i.catid', $dataSearch['category'], '=');
            }

            if($dataSearch['status'] != ''){
                $sql->condition('i.status', $dataSearch['status'], '=');
            }

            if($dataSearch['keyword'] != ''){
                $db_or = db_or();
                $db_or->condition('i.title', '%'.$dataSearch['keyword'].'%', 'LIKE');
                $db_or->condition('i.title_alias', '%'.$dataSearch['keyword'].'%', 'LIKE');
                $sql->condition($db_or);
            }
            /*End search*/
            $result = $sql->limit($limit)->orderBy('i.id', 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();
            $totalItem = count($arrItem);
            $pager = array('#theme' => 'pager','#quantity' => 3);
        }
        return $arrItem;
    }

    public static function getOneItem($tableAction, $arrFields=array(), $id=0){
        $arrItem = array();
        if(!empty($arrFields) && $id > 0){
            $sql = db_select($tableAction, 'i');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.id', (int)$id, '=');
            $result = $sql->range(0, 1)->orderBy('i.id', 'DESC')->execute();
            $arrItem = (array)$result->fetchAll();
        }
        return $arrItem;
    }
    
    public static function getItembyCond($tableAction, $fields='', $groupby='', $oderby='', $cond='', $limit=0){
        if($fields != ''){
            $fields = '*';
        }
        if($groupby != ''){
            $groupby = ' GROUP BY '.$groupby;
        }
        if($oderby != ''){
            $oderby = ' ORDER BY '.$oderby;
        }
        if($cond != ''){
            $cond = ' WHERE '.$cond;

        }
        if($limit > 0){
            $limit = ' LIMIT 0, '.$limit;
        }
        $sql = db_query("SELECT $fields FROM {$tableAction}".$cond.$groupby.$oderby.$limit);
        $arrItem = $sql->fetchAll();
        return $arrItem;
    }

    public static function updateOneItem($tableAction, $dataFields=array(), $id=0){
        //dataFields la array co field=>value
        if(!empty($dataFields) && $id > 0){
            $sql = db_update($tableAction)->fields($dataFields)->condition('id', (int)$id, '=')->execute();
            if($sql)
                return 1;
        }
        return  0;
    }

    public static function updateOneItemByCond($tableAction, $dataFields=array(), $cond=''){
        //dataFields la array co field=>value
    }

    public static function insertOneItem($tableAction, $dataFields=array()){
        //dataFields la array co field=>value
        if(!empty($dataFields)){
            $sql = db_insert($tableAction)->fields($dataFields)->execute();
            if($sql)
                return 1;
        }
        return  0;
    }

    public static function deleteOneItem($tableAction, $id=0){
        if($id > 0){
           $sql = db_delete($tableAction)->condition('id', $id)->execute();
            if($sql)
                return 1;
        }
        
        return  0;
    }

    public static function deleteOneItemByCond($tableAction, $cond=''){
        if($cond != ''){
            $cond = ' WHERE '.$cond;
            $sql = db_query("DELETE FROM {$tableAction}".$cond);
        }
    }

    public static function countItem($tableAction, $fields='', $cond='', $groupby='', $oderby=''){
       
        if($fields == ''){
            $fields = "*";
        }
        if($cond != ''){
            $cond = ' WHERE '.$cond;
        }
        if($groupby != ''){
            $groupby = ' GROUP BY '.$groupby;
        }
        if($oderby != ''){
            $oderby = ' ORDER BY '.$oderby;
        }
        $sql = db_query("SELECT $fields FROM {$tableAction}".$cond.$groupby.$oderby);
        $total = $sql->rowCount();

        return $total;
    }
}


