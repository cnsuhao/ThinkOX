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
        $uid =is_login();

        $list = D('Check_info')->where('uid='.$uid)->order('ctime desc')->count();

         $login= is_login() ? true : false;


        if ($list==0) {


            $data['uid']=$uid;
            $data['ctime']=time();
            D('Check_info')->add($data);
            $check_info = D('Check_info')->where('uid='.$uid)->order('ctime desc')->find();
            $this->assign("addons_config",$check_info);
           $this->display('View/checkin');
            //$this->display('View/testcheck');
        }

       elseif(!$login) {

           $this->display('View/default');

            }

        else{
            //$checkinfo= D('Check_info')->where('uid='.$uid)->getField('max(con_num)');

            $checkinfo = D('Check_info')->where('uid='.$uid)->order('ctime desc')->find();
            //$checkinfo = D('User_cdata')->where($map)->order('mtime desc')->select();
            $this->assign("addons_config",$checkinfo);
            $this->display('View/checkin');
           // $this->display('View/testcheck');
        }

    }

}








