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

    public function getMessage()
    {
        $now = time();
        $count = D('message')->where('to_uid=' . is_login() . ' and is_read=0 and last_toast=0')->count();

        if ($count) {
            $messages = D('message')->where('to_uid=' . is_login() . ' and  is_read=0  and last_toast=0')->order('id desc')->limit(99)->select();

            $result['count'] = D('message')->where('to_uid=' . is_login() . ' and is_read=0 ')->count();
            $result['last_id'] = $messages[0]['id'];
            $result['messages'] = $messages;
            D('message')->where('to_uid=' . is_login() . ' and  is_read=0 and last_toast=0')->setField('last_toast', $now); //设为已经推荐过的
            exit(json_encode($result));
        } else {
            $result['count'] =  D('message')->where('to_uid=' . is_login() . ' and is_read=0 ')->count();
            $result['messages']=0;
            exit(json_encode($result));
        }
    }
}