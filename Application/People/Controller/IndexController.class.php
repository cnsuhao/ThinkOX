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


        $peoples = D('UcenterMember')->where('status=1 and last_login_time!=0')->field('id','reg_time','last_login_time')->order('last_login_time desc')->findPage(20);
        foreach ($peoples['data'] as &$v) {
            $v['user']=query_user(array('avatar128','space_url','nickname','username'),$v['id']);
        }
        unset($v);

        $this->assign('lists', $peoples);

        $this->display();
    }

}