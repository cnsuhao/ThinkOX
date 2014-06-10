<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 14-6-9
 * Time: 上午8:59
 * @author 郑钟良<zzl@ourstu.com>
 */

namespace Usercenter\Widget;
use Think\Action;

/**input类型输入渲染
 * Class InputWidget
 * @package Usercenter\Widget
 * @郑钟良
 */
class InputRenderWidget extends Action {

    public function inputRender($data=array(),$type){
        //dump($data);exit;
        $this->assign('type',$type);
        $this->assign('field_id',$data['id']);
        switch($data['form_type']){
            case 'input':
                $this->assign('field_name',$data['field_name']);

                if(!$data['field_content']){
                    $this->assign('field_data',$data['form_default_value']);
                }else{
                    $this->assign('field_data',$data['field_content']['field_data']);
                }
                $this->display('Widget/input_template');
                break;
            case 'radio':
                $this->assign('field_name',$data['field_name']);
                $checked=isset($data['field_content']['field_data'])?$data['field_content']['field_data']:"还未选择";
                if($type=="personal"){
                    if($data['form_default_value']!=''&&$data['form_default_value']!=null){
                        $canCheck=explode('|',$data['form_default_value']);
                        $items=array();
                        foreach($canCheck as $key=>$val){
                            $items[$key]['value']=$val;
                            $items[$key]['checked']=($checked==$val)?'checked':'';
                        }
                        if(!isset($data['field_content']['field_data'])){
                            $items[0]['checked']='checked';
                        }
                    }
                }

                $this->assign('items',$items);
                $this->assign('checked',$checked);
                $this->display('Widget/radio_template');
                break;
            case 'checkbox':
                $this->assign('field_name',$data['field_name']);
                if($type=="personal"){
                    if($data['form_default_value']!=''&&$data['form_default_value']!=null){
                        $canCheck=explode('|',$data['form_default_value']);
                        $items=null;
                        if(!$data['field_content']){
                            foreach($canCheck as $key=>$val){
                                if($val!=''){
                                    $items[$key]['value']=$val;
                                    $items[$key]['selected']=0;
                                }
                            }
                        }else{
                            $checked=explode('|',$data['field_content']['field_data']);
                            foreach($canCheck as $key=>$val){
                                if($val!=''){
                                    $items[$key]['value']=$val;
                                    if(in_array($val,$checked)){
                                        $items[$key]['selected']=1;
                                    }else{
                                        $items[$key]['selected']=0;
                                    }
                                }
                            }
                        }
                        $this->assign('items',$items);
                    }
                }else{
                    $checked=explode('|',$data['field_content']['field_data']);
                    $this->assign('checked',$checked);
                }
                $this->display('Widget/checkbox_template');
                break;
            case 'select':
                $this->assign('field_name',$data['field_name']);
                $selected=isset($data['field_content']['field_data'])?$data['field_content']['field_data']:"还未选择";
                if($type=="personal"){
                    if($data['form_default_value']!=''&&$data['form_default_value']!=null){
                        $canSelected=explode('|',$data['form_default_value']);
                        $items=array();
                        foreach($canSelected as $key=>$val){
                            $items[$key]['value']=$val;
                            $items[$key]['selected']=($selected==$val)?'selected':'';
                        }
                        if(!isset($data['field_content']['field_data'])){
                            $items[0]['selected']='selected';
                        }
                    }else{
                        $canSelected[0]['value']='无';
                        $canSelected[0]['selected']='selected';
                    }
                }

                $this->assign('items',$items);
                $this->assign('selected',$selected);
                $this->display('Widget/select_template');
                break;
            case 'time':
                $this->assign('field_name',$data['field_name']);

                if(!$data['field_content']){
                    $this->assign('field_data',null);
                }else{
                    $this->assign('field_data',$data['field_content']['field_data']);
                }
                $this->display('Widget/time_template');
                break;
            case 'textarea':
                $this->assign('field_name',$data['field_name']);

                if(!$data['field_content']){
                    $this->assign('field_data',$data['form_default_value']);
                }else{
                    $this->assign('field_data',$data['field_content']['field_data']);
                }
                $this->display('Widget/textarea_template');
                break;
            }
    }

} 