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

    public function index($page = 1, $issue_id = 0)
    {


        $peoples = D('UcenterMember')->field('id','reg_time','last_login_time')->page($page, 10)->select();
        $count = D('UcenterMember')->field('id')->page($page, 10)->count();
        foreach ($peoples as &$v) {
            $v['user']=query_user(array('avatar128','space_url','nickname','username'),$v['id']);
        }
        unset($v);

        $this->assign('lists', $peoples);
        $this->assign('totalPageCount', $count);

        $this->display();
    }

}