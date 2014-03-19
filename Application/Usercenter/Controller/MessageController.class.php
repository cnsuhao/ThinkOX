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

class MessageController extends BaseController
{
    public function index()
    {

    }

    public function message($page = 1, $tab = 'unread')
    {

        switch ($tab) {
            case 'system':
                $map['type'] = 0;
                break;
            case 'user':
                $map['type'] = 1;
                break;
            case 'app':
                $map['type'] = 2;
                break;
            case 'all':
                break;
            default:
                $map['is_read'] = 0;
                break;
        }

        $map['to_uid'] = is_login();
        $this->defaultTabHash('message');
        $messages = D('Message')->where($map)->order('create_time desc')->page($page, 10)->select();
        foreach ($messages as &$v) {
            if ($v['from_uid'] != 0) {
                $v['from_user'] = query_user(array('username', 'space_url', 'avatar64', 'space_link'), $v['from_uid']);
            }

        }
        $totalCount = D('Message')->where($map)->order('create_time desc')->count();
        $this->assign('totalCount', $totalCount);
        $this->assign('messages', $messages);

        $this->assign('tab', $tab);
        $this->display();
    }

    public function talk($message_id = 0, $talk_id = 0)
    {
        //获取当前会话
        $talk = $this->getTalk($message_id, $talk_id);
        /*$messages=D('TalkMessage')

        $this->assign('messages', $messages);*/


        $this->assign('talk', $talk);
        $self = query_user(array('avatar128'), is_login());
        $this->assign('self', $self);
        $this->assign('mid', is_login());
        $this->defaultTabHash('talk');
        $this->display();
    }

    public function postMessage($content, $message_id)
    {
        $message = D('Message')->find($message_id);
        $messageModel = $this->getMessageModel($message);
        $rs = $messageModel->postMessage($message, $content, is_login());

        if ($rs) {
            $info['status'] = 1;
            $this->ajaxReturn($info);
        } else {
            $this->ajaxReturn('false');
        }
    }

    private function getMessageModel($message)
    {

        $appname = ucwords($message['appname']);
        $messageModel = D($appname . '/' . $appname . 'Message');
        return $messageModel;
    }

    /**
     * @param $message_id
     * @param $talk_id
     * @param $map
     * @return array
     */
    private function getTalk($message_id, $talk_id)
    {
        if ($message_id != 0) {
            /*如果是传递了message_id，就是创建对话*/
            $message = D('Message')->find($message_id);

            //权限检测，防止越权创建会话
            if (($message['to_uid'] != $this->mid && $message['from_uid'] != $this->mid) || !$message) {
                $this->error('非法操作。');
            }
            $map['message_id'] = $message_id;
            $talk = D('Talk')->where($map)->find();
            if ($talk) {
                redirect(U('UserCenter/Message/talk', array('talk_id' => $talk['id'])));
            }
            //创建talk
            $talk['uid'] = $this->mid;
            $talk['appname'] = $message['appname'];
            $talk['apptype'] = $message['apptype'];
            $talk['source_id'] = $message['source_id'];
            $talk['message_id'] = $message_id;

            $messageModel = $this->getMessageModel($message);
            $talk = array_merge($messageModel->getSource($message), $talk);
            $talk = D('Talk')->create($talk);
            $talk['id'] = D('Talk')->add($talk);
            $message['talk_id'] = $talk['id'];
            D('Message')->save($message);
            return $talk;

        } else {
            $talk = D('Talk')->find($talk_id);
            if ($talk['uid'] != $this->mid) {
                $this->error('越权操作。');
                return $talk;
            }
            return $talk;
        }
    }
}