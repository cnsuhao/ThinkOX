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
        $userProfile = query_user(array('id', 'username', 'score', 'signature', 'weibocount', 'fans', 'following', 'space_url', 'title','rank_link'), $uid);
        $userProfile['total'] = D('Title')->getScoreTotal($userProfile['score']);
        $follow['follow_who'] = $userProfile['id'];
        $follow['who_follow'] = is_login();
        $userProfile['followed'] = D('Follow')->where($follow)->count();

        echo json_encode($userProfile);
    }

    public function follow($uid = 0)
    {

        if (D('Follow')->follow($uid)) {
            $this->ajaxReturn(array('status' => 1));
        } else {
            $this->ajaxReturn(array('status' => 0));
        }
    }

    public function unfollow($uid = 0)
    {
        if (D('Follow')->unfollow($uid)) {
            $this->ajaxReturn(array('status' => 1));
        } else {
            $this->ajaxReturn(array('status' => 0));
        }
    }


    public function getMessage()
    {

        $message = D('Common/Message');
        //取到所有没有提示过的信息
        $haventToastMessages = $message->getHaventToastMessage(is_login());
        $message->setAllToasted(is_login());
        exit(json_encode($haventToastMessages));
    }

    public function setAllMessageReaded()
    {
        D('Message')->setAllReaded(is_login());
    }

    public function readMessage($message_id)
    {
        exit(json_encode(array('status' => D('Common/Message')->readMessage($message_id))));

    }
}