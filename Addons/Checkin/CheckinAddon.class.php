<?php

namespace Addons\Checkin;

use Common\Controller\Addon;

/**
 * 签到插件
 * @author 想天软件工作室
 */

class CheckinAddon extends Addon
{

    public $info = array(
        'name' => 'Checkin',
        'title' => '签到',
        'description' => '签到积分',
        'status' => 1,
        'author' => '想天软件工作室',
        'version' => '0.1'
    );

    public $admin_list = array(
        'model' => 'Check_info', //要查的表
        'fields' => '*', //要查的字段
        'map' => '', //查询条件, 如果需要可以再插件类的构造方法里动态重置这个属性
        'order' => 'id desc', //排序,
        'listKey' => array( //这里定义的是除了id序号外的表格里字段显示的表头名
            'uid' => 'UID',
            'con_num'=>'连续签到次数',
            'total_num'=>'总签到次数',
            'ctime'=>'签到时间',
        ),
    );

    public function install()
    {
        return true;
    }

    public function uninstall()
    {
        return true;
    }

    //实现的checkin钩子方法
    public function checkin($param)
    {

       $uid = is_login();

        $data =  s('check_info_');//model('Cache')->get('check_info_' . $uid . '_' . date('Ymd'));
       //dump($data);exit;
        if (!$data) {
            $map['uid'] = $uid;
            $map['ctime'] = array('gt', strtotime(date('Ymd')));
            $res = D('Check_info')->where($map)->find();
            //dump($res);exit;
            //是否签到
            $data['ischeck'] = $res ? true : false;
            //dump($data);exit;

            $checkinfo = D('Check_info')->where('uid=' . $uid)->order('ctime desc')->limit(1)->find();
           // dump($checkinfo);exit;
            if ($checkinfo) {
                if ($checkinfo['ctime'] > (strtotime(date('Ymd')) - 86400)) {
                    $data['con_num'] = $checkinfo['con_num'];
                } else {
                    $data['con_num'] =1;
                }
                $data['total_num'] = $checkinfo['total_num'];
            } else {
                $data['con_num'] = 1;
                $data['total_num'] = 1;
            }
            $data['day'] = date('m.d');
            //dump($data);exit;
            //model('Cache')->set('check_info_' . $uid . '_' . date('Ymd'), $data);
            S('a','check_info_');
            //dump(S('a','check_info_'));exit;
        }

        $data['tpl'] = 'index';
        //dump($data);exit;
        $week = date('w');
        //dump($week);exit;
        switch ($week) {
            case '0':
                $week = '周日';
                break;
            case '1':
                $week = '周一';
                break;
            case '2':
                $week = '周二';
                break;
            case '3':
                $week = '周三';
                break;
            case '4':
                $week = '周四';
                break;
            case '5':
                $week = '周五';
                break;
            case '6':
                $week = '周六';
                break;
        }
        $data['week'] = $week;
        //dump($data);exit;
        //$content = $this->renderFile(dirname(__FILE__) . "/" . $data['tpl'] . '.html', $data);
        // return $content;
        $this->assign("check",$data);





        $uid =is_login();

        $list = D('Check_info')->where('uid='.$uid)->order('ctime desc')->count();

         $login= is_login() ? true : false;


      /*  if ($list==0) {


            $data['uid']=$uid;
            $data['ctime']=time();
            D('Check_info')->add($data);
            $check_info = D('Check_info')->where('uid='.$uid)->order('ctime desc')->find();
            $this->assign("addons_config",$check_info);
           $this->display('View/checkin');
            //$this->display('View/testcheck');
        }

       else*/if(!$login) {

           $this->display('View/default');

            }

        else{
            //$checkinfo= D('Check_info')->where('uid='.$uid)->getField('max(con_num)');

            $map['key'] = "check_connum";
            $map['uid'] = $uid;

            //$checkinfo = D('Check_info')->where('uid='.$uid)->order('ctime desc')->find();
            $checkcon = D('User_cdata')->where($map)->order('mtime desc')->select();
            //dump($checkinfo);exit;
            $this->assign("lxqd",$checkcon['0']['value']);

            $total['key'] = "check_totalnum";
            $total['uid'] = $uid;
            $checktotal = D('User_cdata')->where($total)->order('mtime desc')->select();

            $this->assign("zgqd",$checktotal['0']['value']);
            $this->display('View/checkin');
           // $this->display('View/testcheck');
        }

    }

}








