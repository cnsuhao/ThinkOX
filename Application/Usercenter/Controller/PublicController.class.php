<?php
/**
 * 所属项目 OnePlus.
 * 开发者: 想天
 * 创建日期: 3/12/14
 * 创建时间: 12:49 PM
 * 版权所有 想天工作室(www.ourstu.com)
 */

namespace Usercenter\Controller;


use Think\Controller;

class PublicController extends Controller
{
    public function getProfile()
    {
        $uid = $_REQUEST['uid'];
        $userProfile = callApi('User/getProfile', array('uid' => $uid));
        $userProfile['total'] = D('Title')->getScoreTotal($userProfile['score']);

        echo json_encode($userProfile);
    }
} 