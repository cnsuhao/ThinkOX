<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-10
 * Time: PM9:14
 */

namespace Weibo\Controller;

use Think\Controller;

class IndexController extends Controller
{
    public function index()
    {
        //载入第一页微博
        $list = $this->loadWeiboList();
        foreach ($list as &$li) {
            $li['user'] = query_user(array('avatar64', 'username', 'uid', 'space_url', 'icons_html'), $li['uid']);
        }

        //显示页面
        $this->assign('list', $list);
        $this->display();
    }

    public function loadWeibo($page = 1)
    {
        //载入全站微博
        $list = $this->loadWeiboList($page);
        foreach ($list as &$li) {
            $li['user'] = query_user(array('avatar64', 'username', 'uid', 'space_url', 'icons_html'), $li['uid']);
        }
        unset($li);

        //如果没有微博，则返回错误
        if (!$list) {
            $this->error('没有更多了');
        }

        //返回html代码用于ajax显示
        $this->assign('list', $list);
        $this->display();
    }

    public function doSend($content)
    {
        //确认用户已经登录
        $this->requireLogin();

        //写入数据库
        $model = D('Weibo');
        $result = $model->addWeibo(is_login(), $content);
        if (!$result) {
            $this->error('发布失败：' . $model->getError());
        }

        //显示成功页面
        $this->success('发表成功');
    }

    public function doComment($weibo_id, $content)
    {
        //确认用户已经登录
        $this->requireLogin();

        //写入数据库
        $model = D('WeiboComment');
        $result = $model->addComment(is_login(), $weibo_id, $content);
        if (!$result) {
            $this->error('评论失败：' . $model->getError());
        }

        //显示成功页面
        $this->success('评论成功');
    }

    public function loadComment($weibo_id)
    {
        //读取数据库中全部的评论列表
        $list = D('WeiboComment')->where(array('weibo_id' => $weibo_id))->order('create_time desc')->select();
        $weiboCommentTotalCount = count($list);

        //返回html代码用于ajax显示
        $this->assign('weiboId', $weibo_id);
        $this->assign('weiboCommentTotalCount', $weiboCommentTotalCount);
        $this->assign('list', $list);
        $this->display();
    }

    private function requireLogin()
    {
        if (!is_login()) {
            $this->error('需要登录');
        }
    }

    private function loadWeiboList($page = 1)
    {
        $map = array('status' => 1);
        $list = D('Weibo')->where($map)->order('create_time desc')->page($page, 10)->select();
        return $list;
    }


}