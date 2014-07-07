<?php


namespace People\Controller;

use Think\Controller;


class IndexController extends Controller
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {
    }

    public function index($page = 1)
    {


        $peoples = D('Member')->where('status=1 and last_login_time!=0')->field('uid', 'reg_time', 'last_login_time')->order('last_login_time desc')->findPage(18);
        foreach ($peoples['data'] as &$v) {
            $v['user'] = query_user(array('avatar128', 'space_url', 'username', 'fans', 'following', 'signature', 'nickname'), $v['uid']);
        }
        unset($v);

        $this->assign('lists', $peoples);

        $this->display();
    }

    public function find($page = 1, $keywords = '')
    {
        $nickname = op_t($keywords);
        if ($nickname != '') {
            $map['nickname'] = array('like','%'.$nickname.'%');
        }
        $list = D('Member')->where($map)->findPage(18);
        foreach ($list['data'] as &$v) {
            $v['user'] = query_user(array('avatar128', 'space_url', 'username', 'fans', 'following', 'signature', 'nickname'), $v['uid']);
        }
        unset($v);
        $this->assign('lists', $list);
        $this->assign('nickname',$nickname);
        $this->display();
    }
}