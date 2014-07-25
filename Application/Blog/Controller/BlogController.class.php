<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Blog\Controller;
use Think\Controller;

/**
 * 前台公共控制器
 * 为防止多分组Controller名称冲突，公共Controller名称统一使用分组名称
 */
class BlogController extends Controller {

	/* 空操作，用于输出404页面 */
	public function _empty(){
		$this->redirect('Index/index');
	}


    protected function _initialize(){
        /* 读取站点配置 */
        $config = api('Config/lists');
        C($config); //添加配置

        if(!C('WEB_SITE_CLOSE')){
            $this->error('站点已经关闭，请稍后访问~');
        }

        $sub_menu =
            array(
                'left' =>
                    array(
                        array('tab' => 'home', 'title' => '首页', 'href' => U('blog/index/index')),
                    ),
            );
        $category = D('Category')->getTree();
        $this->assign('categories', $category); //栏目
        foreach ($category as $cat) {
            $sub_menu['left'][] = array('tab' => 'cat_' . $cat['id'], 'title' => $cat['title'], 'href' => U('blog/article/lists', array('category' => $cat['id'])));
        }
        $this->assign('sub_menu', $sub_menu);
        $this->setTitle('博客');

    }


    protected function ensureApiSuccess($result)
    {
        if (!$result['success']) {
            $this->error($result['message'], $result['url']);
        }
    }
}
