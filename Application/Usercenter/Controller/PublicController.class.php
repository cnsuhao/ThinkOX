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
        $uid = intval($_REQUEST['uid']);
        $userProfile = query_user(array('id', 'nickname','avatar64','space_url','following', 'fans','weibocount','signature'), $uid);
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


    /**检测消息
     * 返回新会话状态和系统的消息
     * @auth 陈一枭
     */
    public function getInformation()
    {

        $message = D('Common/Message');
        //取到所有没有提示过的信息
        $haventToastMessages = $message->getHaventToastMessage(is_login());

        $message->setAllToasted(is_login());//消息中心推送

        $new_talks = D('TalkPush')->getAllPush();//会话推送
        D('TalkPush')->where(array('uid' => get_uid(),'status'=>0))->setField('status',1);//读取到推送之后，自动删除此推送来防止反复推送。


        exit(json_encode(array('messages' => $haventToastMessages, 'talk_messages' => $talk_messages, 'new_talks' => $new_talks)));
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