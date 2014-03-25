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
        $atusers=S('atUsersJson_'.is_login());
        if(empty($atusers)){
            $atusers = $this->getAtWhoJson();
            S('atUsersJson_'.is_login(),$atusers,600);
        }

        $this->assign('atwhousers', json_encode($atusers));

        //载入第一页微博
        $list = $this->loadWeiboList();
        foreach ($list as &$li) {
            $li['user'] = query_user(array('avatar64', 'username', 'uid', 'space_url', 'icons_html'), $li['uid']);
        }

        $self = query_user(array('avatar128', 'username', 'uid', 'space_url', 'icons_html', 'score', 'title', 'fans', 'following', 'weibocount'));


        //显示页面
        $this->assign('list', $list);
        $this->assign('self', $self);
        $this->display();
    }

public  function myconcerned()
{
    $atusers=S('atUsersJson_'.is_login());
    if(empty($atusers)){
        $atusers = $this->getAtWhoJson();
        S('atUsersJson_'.is_login(),$atusers,600);
    }
    $this->assign('atwhousers', json_encode($atusers));



    $list = $this->loadconcernedWeibolist();
    foreach ($list as &$li) {
        $li['user'] = query_user(array('avatar64', 'username', 'uid', 'space_url', 'icons_html'), $li['uid']);
    }

    $self = query_user(array('avatar128', 'username', 'uid', 'space_url', 'icons_html', 'score', 'title', 'fans', 'following', 'weibocount'));


    //显示页面
    $this->assign('list', $list);
    $this->assign('self', $self);
    $this->display();
}




    public function atjson()
    {

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


    public function concernedWeibo($page)
    {

        $list = $this->loadconcernedWeibolist($page);

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

    public function doComment($weibo_id, $content, $comment_id = 0)
    {
        //确认用户已经登录
        $this->requireLogin();

        //写入数据库
        $uid = is_login();
        $near = D('WeiboComment')->where('uid=' . $uid)->order('create_time desc')->find();

        $cha = time() - $near['create_time'];


        if ($cha > 10) {
            $model = D('WeiboComment');
            $result = $model->addComment(is_login(), $weibo_id, $content, $comment_id);
            //dump($result);exit;
            if (!$result) {
                $this->error('评论失败：' . $model->getError());
            }

            //显示成功页面
            $this->success('评论成功');
        } else {

            $this->error('相隔不能低于十秒');
        }
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
        //dump($list);exit;
        return $list;
    }

    private function loadconcernedWeibolist($page=1)
    {
        $uid=is_login();
        $concerned=D('Follow')->where('who_follow='.$uid)->select();
        //dump( $concerned);exit;
        $count=D('Follow')->where('who_follow='.$uid)->count();
        //dump( $count);exit;
        for($i=0;$i<$count;$i++)
        {
            $map[$i]=$concerned[$i]['follow_who'];

        }
        $list = D('Weibo')->where('status=1 and uid in('.implode(',',$map).')')->order('create_time desc')->page($page, 10)->select();
        //dump($list);exit;
        return $list;
    }


    /**
     * @param $user
     * @return array
     */
    private function getAtWhoJson()
    {
        $atuserIds = array();
        $atusers = array();
        $users_who_follow = D('Follow')->where('who_follow=' . is_login())->limit(999)->select();
        foreach ($users_who_follow as &$user) {
            if (!in_array($user['follow_who'], $atuserIds)) {
                $user_temp = query_user(array('username', 'id'), $user['follow_who']);
                $user_temp['pinyin'] = D('PinYin')->Pinyin($user_temp['username']);
                $atusers = array_merge($atusers, array($user_temp));
                $atuserIds[] = $user['follow_who'];
            }
        }
        unset($user);

        $users_follow_who = D('Follow')->where('follow_who=' . is_login())->limit(999)->select();
        foreach ($users_follow_who as &$user) {
            if (!in_array($user['who_follow'], $atuserIds)) {
                $user_temp = query_user(array('username', 'id'), $user['who_follow']);
                $user_temp['pinyin'] = D('PinYin')->Pinyin($user_temp['username']);
                $atusers = array_merge($atusers, array($user_temp));
                $atuserIds[] = $user['who_follow'];
            }

        }
        unset($user);
        return $atusers;
    }


}