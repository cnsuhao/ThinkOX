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
    protected $mTalkModel;

    public function _initialize()
    {
        parent::_initialize();
        $this->mTalkModel = D('Talk');
    }

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

    public function session()
    {
        $this->defaultTabHash('session');
        $talks = D('Talk')->where('uids like' . '"%[' . is_login() . ']%"' . ' and status=1')->order('update_time desc')->select();
        foreach ($talks as &$v) {

            $uids_array = $this->mTalkModel->getUids($v['uids']);
            foreach ($uids_array as $uid) {
                $users[] = query_user(array('avatar64', 'username', 'space_link', 'id'), $uid);
            }
            $v['users'] = $users;
            $v['last_message'] = D('TalkMessage')->where('talk_id=' . $v['id'])->order('create_time desc')->find();
            $v['last_message']['user'] = query_user(array('username', 'space_url', 'id'), $v['last_message']['uid']);
        }
        // dump($talks);exit;
        $this->assign('talks', $talks);
        $this->display();
    }

    public function talk($message_id = 0, $talk_id = 0)
    {
        //获取当前会话
        $talk = $this->getTalk($message_id, $talk_id);
        $map['talk_id'] = $talk['id'];
        $messages = D('TalkMessage')->where($map)->order('create_time desc')->limit(20)->select();
        $messages = array_reverse($messages);
        foreach ($messages as &$mes) {
            $mes['user'] = query_user(array('avatar128', 'uid', 'username'), $mes['uid']);
        }
        unset($mes);
        $this->assign('messages', $messages);

        $this->assign('talk', $talk);
        $self = query_user(array('avatar128'), is_login());
        $this->assign('self', $self);
        $this->assign('mid', is_login());
        $this->defaultTabHash('talk');
        $this->display();
    }

    public function postMessage($content, $talk_id)
    {

        D('TalkMessage')->addMessage($content, is_login(), $talk_id);
        $talk = D('Talk')->find($talk_id);
        $message = D('Message')->find($talk['message_id']);
        $messageModel = $this->getMessageModel($message);
        $rs = $messageModel->postMessage($message, $talk, $content, is_login());
        if ($rs) {
            $this->ajaxReturn(true);
        }
        $this->ajaxReturn(false);
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
            $talk['uids'] = implode(',', array('[' . is_login() . ']', '[' . $message['from_uid'] . ']'));
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
            $talkMessage['uid'] = $message['from_uid'];
            $talkMessage['talk_id'] = $talk['id'];
            $talkMessage['content'] = $messageModel->getFindContent($message);
            $talkMessageModel = D('TalkMessage');
            $talkMessage = $talkMessageModel->create($talkMessage);
            $talkMessage['id'] = $talkMessageModel->add($talkMessage);
            return $talk;

        } else {
            $talk = D('Talk')->find($talk_id);
            $uids_array = $this->mTalkModel->getUids($talk['uids']);
            if (!count($uids_array)) {
                $this->error('越权操作。');
                return $talk;
            }
            return $talk;
        }
    }
}