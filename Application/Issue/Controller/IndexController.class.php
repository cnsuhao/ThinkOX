<?php


namespace Issue\Controller;

use Think\Controller;


class IndexController extends Controller
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {
        $tree=D('Issue')->getTree();
        $this->assign('tree',$tree);
    }

    public function index()
    {
        $this->display();
    }


}