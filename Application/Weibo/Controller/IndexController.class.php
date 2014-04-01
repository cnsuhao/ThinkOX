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
        $atusers = $this->getAtWhoJson();
        $this->assign('atwhousers', $atusers);

        //载入第一页微博
        $list = $this->loadWeiboList();
        //dump($list);exit;
        foreach ($list as &$li) {
            $li['user'] = query_user(array('avatar64', 'username', 'uid', 'space_url', 'icons_html'), $li['uid']);
        }

        $self = query_user(array('avatar128', 'username', 'uid', 'space_url', 'icons_html', 'score', 'title', 'fans', 'following', 'weibocount'));


        //显示页面
        $this->assign('list', $list);
        $this->assign('self', $self);
        $this->display();
    }

    public function myconcerned()
    {
        $atusers = $this->getAtWhoJson();
        $this->assign('atwhousers', $atusers);

        $list = $this->loadconcernedWeibolist();
        foreach ($list as &$li) {
            $li['user'] = query_user(array('avatar64', 'username', 'uid', 'space_url', 'icons_html'), $li['uid']);
        }
        unset($li);

        $self = query_user(array('avatar128', 'username', 'uid', 'space_url', 'icons_html', 'score', 'title', 'fans', 'following', 'weibocount'));


        //显示页面
        $this->assign('list', $list);
        $this->assign('self', $self);
        $this->display();
    }


    public function weiboDetail()
    {

        $id = $_GET['id'];
        $list = D('Weibo')->where(array('id' => $id, 'status' => 1))->select();
        if (!$list) { //针对微博存在的检测
            $this->assign('jumpUrl', U('Weibo/Index/index'));
            $this->error('404未能找到该微博。');
        }
        $uid = $list[0]['uid'];

        $self = query_user(array('avatar128', 'username', 'uid', 'space_url', 'icons_html', 'score', 'title', 'fans', 'following', 'weibocount'), $uid);

        $atusers = $this->getAtWhoJson();
        $this->assign('atwhousers', $atusers);


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


    public function concernedWeibo($page = 1)
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
        $score_before = getMyScore();
        $result = $model->addWeibo(is_login(), $content);
        $score_after =getMyScore();
        if (!$result) {
            $this->error('发布失败：' . $model->getError());
        }
        //显示成功页面
        $this->success('发表微博成功。' . getScoreTip($score_before,$score_after));
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
            $score_before = getMyScore();
            $result = $model->addComment(is_login(), $weibo_id, $content, $comment_id);
            $score_after =getMyScore();
            if (!$result) {
                $this->error('评论失败：' . $model->getError());
            }

            //显示成功页面
            $this->success('评论成功。'.getScoreTip($score_before,$score_after));
        } else {
            $this->error('相隔不能低于10秒');
        }
    }

    public function loadComment($weibo_id)
    {
        //读取数据库中全部的评论列表
        $list = D('WeiboComment')->where(array('weibo_id' => $weibo_id, 'status' => 1))->order('create_time desc')->select();
        $weiboCommentTotalCount = count($list);

        //返回html代码用于ajax显示
        $this->assign('weiboId', $weibo_id);
        $weibo = D('Weibo')->find($weibo_id);
        $this->assign('weibo', $weibo);
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

    private function loadconcernedWeibolist($page = 1)
    {
        $concerned = D('Follow')->where('who_follow=' . is_login())->select();
        $map = array();
        foreach ($concerned as $cuser) {
            $map[] = $cuser['follow_who'];
        }
        $map[] = is_login();
        $list = D('Weibo')->where('status=1 and uid in(' . implode(',', $map) . ')')->order('create_time desc')->page($page, 10)->select();
        return $list;
    }


    /**
     * @param $user
     * @return array
     */
    private function getAtWho()
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

    /**
     * @return array|mixed
     */
    private function getAtWhoJson()
    {
        $atusers = S('atUsersJson_' . is_login());
        if (empty($atusers)) {
            $atusers = $this->getAtWho();
            S('atUsersJson_' . is_login(), $atusers, 600);
            return json_encode($atusers);
        }
        return json_encode($atusers);
    }


    public function doDelWeibo($weibo_id = 0)
    {
        if (intval($weibo_id)) {

            if (is_administrator()) {
                $del = D('Weibo')->where(array('id' => $weibo_id))->setField('status', 0); //管理员即可直接删除
            } else {
                $del = D('Weibo')->where(array('id' => $weibo_id, 'uid' => is_login()))->setField('status', 0); //删除带检测权限
            }
            if ($del) {
                D('WeiboComment')->where(array('weibo_id' => $weibo_id))->setField('status', 0);
            }
            exit(json_encode(array('status' => $del)));
        }
    }

    public
    function doDelComment($comment_id = 0)
    {
        if (intval($comment_id)) {
            if (is_administrator()) {
                $del = D('WeiboComment')->where(array('id' => $comment_id))->setField('status', 0); //管理员即可直接删除
            } else {
                $del = D('WeiboComment')->where(array('id' => $comment_id, 'uid' => is_login()))->setField('status', 0); //先删除带检测权限
            }
            if ($del) {
                $comment = D('WeiboComment')->find($comment_id);
                $count = D('WeiboComment')->where(array('weibo_id' => $comment['weibo_id'], 'status' => 1))->count();
                D('Weibo')->where(array('id' => $comment['weibo_id']))->setField('comment_count', $count);
            }
            exit(json_encode(array('status' => $del)));
        }
    }

}