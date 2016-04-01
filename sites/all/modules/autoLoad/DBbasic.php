<?php
/*
* @Created by: HSS
* @Author	 : nguyenduypt86@gmail.com
* @Date 	 : 06/2014
* @Version	 : 1.0
*/
class DB{

    /**
     * QuynhTM
     * @param $tableAction
     * @param string $primary_key:
     * @param array $arrFields
     * @param int $id
     * @return array
     */
    public static function getItemById($tableAction, $primary_key = 'id', $arrFields = array(), $id = 0){
        $arrItem = array();
        if(!empty($arrFields) && $id > 0){
            $sql = db_select($tableAction, 'i');
            foreach($arrFields as $field){
                $sql->addField('i', $field, $field);
            }
            $sql->condition('i.'.$primary_key, (int)$id, '=');
            $result = $sql->execute();
            $arrItem = (array)$result->fetchAll();
        }
        return $arrItem;
    }

    /**
     * QuynhTM
     * @param $tableAction
     * @param string $primary_key
     * @param array $dataFields
     * @param int $id
     * @return bool
     */
    public static function updateId($tableAction, $primary_key = 'id', $dataFields=array(), $id=0){
        //dataFields la array co field=>value
        if(!empty($dataFields) && $id > 0){
            $sql = db_update($tableAction)->fields($dataFields)->condition($primary_key, (int)$id, '=')->execute();
            if($sql)
                return true;
        }
        return false;
    }

    /**
     * QuynhTM
     * @param $tableAction
     * @param string $primary_key
     * @param int $id
     * @return bool
     */
    public static function deleteId($tableAction,$primary_key = 'id', $id=0){
        if($id > 0){
            $sql = db_delete($tableAction)->condition($primary_key, $id)->execute();
            if($sql)
                return true;
        }
        return false;
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
        if($fields == ''){
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

   
    public static function updateOneItemByCond($tableAction, $dataFields=array(), $cond=''){
        //dataFields la array co field=>value
        if(!empty($dataFields)){
            if($cond != ''){
                $cond = ' WHERE '.$cond;
            }
            $fiels = '';
            $i = 0;
            foreach($dataFields as $field => $value){
                $i++;
                if($i<count($dataFields))
                    $fiels .= $field." = '".$value."', ";
                else{
                    $fiels .= $field." = '".$value."' ";
                }
            }
        
            $sql = db_query("UPDATE {$tableAction} SET $fiels ".$cond);
            if($sql)
                return true;
        }
        return false;
    }

    public static function insertOneItem($tableAction, $dataFields=array()){
        //dataFields la array co field=>value
        if(!empty($dataFields)){
            $sql = db_insert($tableAction)->fields($dataFields)->execute();
            if($sql)
                return $sql;
        }
        return false;
    }

    
    public static function deleteOneItemByCond($tableAction, $cond=''){
        if($cond != ''){
            $cond = ' WHERE '.$cond;
            $sql = db_query("DELETE FROM {$tableAction}".$cond);
            if($sql)
                return true;
        }
        return false;
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


