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
        $userProfile = query_user(array('username', 'score', 'signature', 'last_login_time', 'reg_time', 'title'), $uid);

        //callApi('User/getProfile', array('uid' => $uid));
        $userProfile['total'] = D('Title')->getScoreTotal($userProfile['score']);

        echo json_encode($userProfile);
    }

    public function getMessage()
    {

        $message = D('Message');
        //取到所有没有提示过的信息
        $haventToastMessages = $message->getHaventToastMessage(is_login());
        $message->setAllToasted(is_login());
        exit(json_encode($haventToastMessages));
    }

    public function setAllMessageReaded()
    {
        D('Message')->setAllReaded(is_login());
    }
}