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

    public function talk()
    {
        $appname = 'Forum';


        $messageModel = D($appname . '/' . $appname . 'Message');
        $data = $messageModel->getData();
        $this->assign($data);
        // $messageModel->getPoster();


        $this->assign('mid', is_login());
        $this->defaultTabHash('talk');
        $this->display();
    }
}