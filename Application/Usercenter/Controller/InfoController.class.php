<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 14-6-27
 * Time: 下午1:54
 * @author 郑钟良<zzl@ourstu.com>
 */

namespace Usercenter\Controller;


use Think\Controller;

class InfoController extends BaseController{

    public function _initialize(){
        parent::_initialize();
    }

    public function index($uid = null)
    {
        //调用API获取基本信息
        $user = query_user(array('nickname', 'email', 'mobile', 'last_login_time', 'last_login_ip', 'score', 'reg_time', 'title', 'avatar256','rank_link'), $uid);
        $this->assign('user', $user);
        $this->assign('call', $this->getCall($uid));
        $this->display();
    }

} 