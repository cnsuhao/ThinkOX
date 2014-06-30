<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-8
 * Time: PM4:30
 */

namespace Forum\Controller;

use Think\Controller;
use Weibo\Api\WeiboApi;

define('TOP_ALL', 2);
define('TOP_FORUM', 1);

class IndexController extends Controller
{
    private function getForumList()
    {
        $forum_list = S('forum_list');
        if (empty($forum_list)) {
            //读取板块列表
            $forum_list = D('Forum/Forum')->where(array('status' => 1))->order('sort asc')->select();
            S('forum_list', $forum_list, 300);
        }
        return $forum_list;
    }

    public function _initialize()
    {

        $forum_list = $this->getForumList();
        //判断板块能否发帖
        foreach ($forum_list as &$e) {
            $e['allow_publish'] = $this->isForumAllowPublish($e['id']);
        }
        unset($e);
        $myInfo = query_user(array('avatar128', 'nickname', 'uid', 'space_url', 'icons_html'), is_login());
        $this->assign('myInfo', $myInfo);
        //赋予贴吧列表
        $this->assign('forum_list', $forum_list);

        $count = S('forum_count');
        if (empty($count)) {
            $count['forum'] = D('Forum')->where(array('status' => 1))->count();
            $count['post'] = D('ForumPost')->where(array('status' => 1))->count();
            $count['all'] = $count['post'] + D('ForumPostReply')->where(array('status' => 1))->count() + D('ForumLzlReply')->where(array('status' => 1))->count();
            S('forum_count', $count, 60);
        }
        $this->assign('count', $count);
    }

    public function index($page = 1)
    {
        redirect(U('forum', array('page' => $page)));
    }

    /**某个版块的帖子列表
     * @param int    $id
     * @param int    $page
     * @param string $order
     * @auth 陈一枭
     */
    public function forum($id = 0, $page = 1, $order = 'last_reply_time desc')
    {
        if ($order == 'ctime') {
            $order = 'create_time desc';
        } else if ($order == 'reply') {
            $order = 'reply_count desc';
        }
        $this->requireForumAllowView($id);
        $forums =$this->getForumList();
        $forum_key_value=array();
        foreach($forums as $f){
            $forum_key_value[$f['id']]=$f;
        }


        //读取帖子列表
        if ($id == 0) {
            $map = array('status' => 1);
            $list_top = D('ForumPost')->where(' status=1 AND is_top=' . TOP_ALL . '')->order($order)->select();
        } else {
            $map = array('forum_id' => $id, 'status' => 1);
            $list_top = D('ForumPost')->where('status=1 AND (is_top=' . TOP_ALL . ') OR (is_top=' . TOP_FORUM . ' AND forum_id=' . intval($id) . ' and status=1)')->order($order)->select();
        }

        foreach($list_top as &$v){
            $v['forum']=$forum_key_value[$v['forum_id']];
        }
        unset($v);
        $list = D('ForumPost')->where($map)->order($order)->page($page, 10)->select();
        $totalCount = D('ForumPost')->where($map)->count();
        foreach($list as &$v){
            $v['forum']=$forum_key_value[$v['forum_id']];
        }
        unset($v);
        //读取置顶列表

        //显示页面
        $this->assign('forum_id', $id);
        $this->assignAllowPublish();
        $this->assign('list', $list);
        $this->assign('list_top', $list_top);
        $this->assign('totalCount', $totalCount);
        if ($_GET['order'] == 'ctime') {
            $this->assign('order', 1);
        } else {
            $this->assign('order', 0);
        }
        $this->display();
    }

    public function forums()
    {
        $this->display();
    }

    public function detail($id, $page = 1, $sr = null, $sp = 1)
    {
        $id = intval($id);
        $limit = 10;
        //读取帖子内容
        $post = D('ForumPost')->where(array('id' => $id, 'status' => 1))->find();

        if (!$post) {
            $this->error('找不到该帖子');
        }
        $post['content'] = op_h($post['content'], 'html');
        //增加浏览次数
        D('ForumPost')->where(array('id' => $id))->setInc('view_count');
        //读取回复列表
        $map = array('post_id' => $id, 'status' => 1);
        $replyList = D('ForumPostReply')->getReplyList($map, 'create_time', $page, $limit);

        $replyTotalCount = D('ForumPostReply')->where($map)->count();
        //判断是否需要显示1楼
        if ($page == 1) {
            $showMainPost = true;
        } else {
            $showMainPost = false;
        }

        foreach ($replyList as &$reply) {
            $reply['content'] = op_h($reply['content'], 'html');
        }

        unset($reply);
        //判断是否已经收藏
        $isBookmark = D('ForumBookmark')->exists(is_login(), $id);
        //显示页面
        $this->assign('forum_id', $post['forum_id']);
        $this->assignAllowPublish();
        $this->assign('isBookmark', $isBookmark);
        $this->assign('post', $post);
        $this->assign('limit', $limit);
        $this->assign('sr', $sr);
        $this->assign('sp', $sp);
        $this->assign('page', $page);
        $this->assign('replyList', $replyList);
        $this->assign('replyTotalCount', $replyTotalCount);
        $this->assign('showMainPost', $showMainPost);
        $this->display();
    }

    public function delPostReply($id)
    {
        $this->requireLogin();
        $this->requireCanDeletePostReply($id);
        $res = D('ForumPostReply')->delPostReply($id);
        $res && $this->success($res);
        !$res && $this->error('');
    }

    public function editReply($reply_id = null)
    {
        if ($reply_id) {
            $reply = D('forum_post_reply')->where(array('id' => $reply_id, 'status' => 1))->find();
        } else {
            $this->error('参数出错！');
        }

        //显示页面
        $this->assign('reply', $reply);
        $this->display();
    }

    public function doReplyEdit($reply_id = null, $content)
    {
        //对帖子内容进行安全过滤
        $content = $this->filterPostContent($content);

        if (!$content) {
            $this->error("回复内容不能为空！");
        }
        $data['content'] = $content;
        $data['update_time'] = time();
        $post_id = D('forum_post_reply')->where(array('id' => intval($reply_id), 'status' => 1))->getField('post_id');
        $reply = D('forum_post_reply')->where(array('id' => intval($reply_id)))->save($data);
        if ($reply) {
            S('post_replylist_' . $post_id, null);
            $this->success('编辑回复成功', U('Forum/Index/detail', array('id' => $post_id)));
        } else {
            $this->error("编辑回复失败");
        }
    }

    public function edit($forum_id = 0, $post_id = null)
    {
        //判断是不是为编辑模式
        $isEdit = $post_id ? true : false;
        //如果是编辑模式的话，读取帖子，并判断是否有权限编辑
        if ($isEdit) {
            $post = D('ForumPost')->where(array('id' => intval($post_id), 'status' => 1))->find();
            $this->requireAllowEditPost($post_id);
        } else {
            $post = array('forum_id' => $forum_id);
        }
        //获取贴吧编号
        $forum_id = $forum_id ? intval($forum_id) : $post['forum_id'];

        //确认当前贴吧能发帖
        $this->requireForumAllowPublish($forum_id);

        //确认贴吧能发帖
        if ($forum_id) {
            $this->requireForumAllowPublish($forum_id);
        }

        //显示页面
        $this->assign('forum_id', $forum_id);
        $this->assignAllowPublish();
        $this->assign('post', $post);
        $this->assign('isEdit', $isEdit);
        $this->display();
    }

    public function doEdit($post_id = null, $forum_id, $title, $content)
    {

        //判断是不是编辑模式
        $isEdit = $post_id ? true : false;

        //如果是编辑模式，确认当前用户能编辑帖子
        if ($isEdit) {
            $this->requireAllowEditPost($post_id);
        }

        //确认当前贴吧能发帖
        $this->requireForumAllowPublish($forum_id);

        //写入帖子的内容
        if (strlen($content) < 25) {
            $this->error('发表失败：内容长度不能小于25');
        }
        $model = D('ForumPost');
        if ($isEdit) {
            $data = array('id' => intval($post_id), 'title' => $title, 'content' => $content, 'parse' => 0, 'forum_id' => intval($forum_id));
            $result = $model->editPost($data);


            if (!$result) {
                $this->error('编辑失败：' . $model->getError());
            }
        } else {
            $data = array('uid' => is_login(), 'title' => $title, 'content' => $content, 'parse' => 0, 'forum_id' => $forum_id);

            $before = getMyScore();
            $tox_money_before = getMyToxMoney();
            $result = $model->createPost($data);
            $after = getMyScore();
            $tox_money_after = getMyToxMoney();
            if (!$result) {
                $this->error('发表失败：' . $model->getError());
            }
            $post_id = $result;
        }

        //发布帖子成功，发送一条微博消息
        $postUrl = "http://$_SERVER[HTTP_HOST]" . U('Forum/Index/detail', array('id' => $post_id));
        $weiboApi = new WeiboApi();
        $weiboApi->resetLastSendTime();
        if ($isEdit) {
            $weiboApi->sendWeibo("我修改了帖子【" . $title . "】：" . $postUrl);
        } else {
            $weiboApi->sendWeibo("我发表了一个新的帖子【" . $title . "】：" . $postUrl);
        }


        //显示成功消息
        $message = $isEdit ? '编辑成功。' : '发表成功。' . getScoreTip($before, $after) . getToxMoneyTip($tox_money_before, $tox_money_after);
        $this->success($message, U('Forum/Index/detail', array('id' => $post_id)));
    }

    public function doReply($post_id, $content)
    {
        //确认有权限回复
        $this->requireAllowReply($post_id);


        //检测回复时间限制
        $uid = is_login();
        $near = D('ForumPostReply')->where(array('uid' => $uid))->order('create_time desc')->find();

        $cha = time() - $near['create_time'];
        if ($cha > 10) {

            //添加到数据库
            $model = D('ForumPostReply');
            $before = getMyScore();
            $tox_money_before = getMyToxMoney();
            $result = $model->addReply($post_id, $this->filterPostContent($content));
            $after = getMyScore();
            $tox_money_after = getMyToxMoney();
            if (!$result) {
                $this->error('回复失败：' . $model->getError());
            }
            //显示成功消息
            $this->success('回复成功。' . getScoreTip($before, $after), 'refresh') . getToxMoneyTip($tox_money_before, $tox_money_after);
        } else {
            $this->error('请10秒之后再回复');

        }
    }

    public function doBookmark($post_id, $add = true)
    {
        //确认用户已经登录
        $this->requireLogin();

        //写入数据库
        if ($add) {
            $result = D('ForumBookmark')->addBookmark(is_login(), $post_id);
            if (!$result) {
                $this->error('收藏失败');
            }
        } else {
            $result = D('ForumBookmark')->removeBookmark(is_login(), $post_id);
            if (!$result) {
                $this->error('取消失败');
            }
        }

        //返回成功消息
        if ($add) {
            $this->success('收藏成功');
        } else {
            $this->success('取消成功');
        }
    }

    private function assignAllowPublish()
    {
        $forum_id = $this->get('forum_id');
        $allow_publish = $this->isForumAllowPublish($forum_id);
        $this->assign('allow_publish', $allow_publish);
    }

    private function requireLogin()
    {
        if (!$this->isLogin()) {
            $this->error('需要登录才能操作');
        }
    }

    private function isLogin()
    {
        return is_login() ? true : false;
    }

    private function requireForumAllowPublish($forum_id)
    {
        $this->requireForumExists($forum_id);
        $this->requireLogin();
        $this->requireForumAllowCurrentUserGroup($forum_id);
    }

    private function isForumAllowPublish($forum_id)
    {
        if (!$this->isLogin()) {
            return false;
        }
        if (!$this->isForumExists($forum_id)) {
            return false;
        }
        if (!$this->isForumAllowCurrentUserGroup($forum_id)) {
            return false;
        }
        return true;
    }

    private function requireAllowEditPost($post_id)
    {
        $this->requirePostExists($post_id);
        $this->requireLogin();

        //确认帖子时自己的
        $post = D('ForumPost')->where(array('id' => $post_id, 'status' => 1))->find();
        if ($post['uid'] != is_login()) {
            $this->error('没有权限编辑帖子');
        }
    }

    private function requireForumAllowView($forum_id)
    {
        $this->requireForumExists($forum_id);
    }

    private function requireForumExists($forum_id)
    {
        if (!$this->isForumExists($forum_id)) {
            $this->error('贴吧不存在');
        }
    }

    private function isForumExists($forum_id)
    {
        $forum = D('Forum')->where(array('id' => $forum_id, 'status' => 1));
        return $forum ? true : false;
    }

    private function requireAllowReply($post_id)
    {
        $this->requirePostExists($post_id);
        $this->requireLogin();
    }

    private function requirePostExists($post_id)
    {
        $post = D('ForumPost')->where(array('id' => $post_id))->find();
        if (!$post) {
            $this->error('帖子不存在');
        }
    }

    private function requireForumAllowCurrentUserGroup($forum_id)
    {
        if (!$this->isForumAllowCurrentUserGroup($forum_id)) {
            $this->error('该板块不允许发帖');
        }
    }

    private function isForumAllowCurrentUserGroup($forum_id)
    {
        //如果是超级管理员，直接允许
        if (is_login() == 1) {
            return true;
        }

        //如果帖子不属于任何板块，则允许发帖
        if (intval($forum_id) == 0) {
            return true;
        }

        //读取贴吧的基本信息
        $forum = D('Forum')->where(array('id' => $forum_id))->find();
        $userGroups = explode(',', $forum['allow_user_group']);

        //读取用户所在的用户组
        $list = M('AuthGroupAccess')->where(array('uid' => is_login()))->select();
        foreach ($list as &$e) {
            $e = $e['group_id'];
        }

        //每个用户都有一个默认用户组
        $list[] = '1';

        //判断用户组是否有权限
        $list = array_intersect($list, $userGroups);
        return $list ? true : false;
    }


    public function search($page = 1)
    {
        $_REQUEST['keywords'] = op_t($_REQUEST['keywords']);
        //读取帖子列表
        $map['title'] = array('like', "%{$_REQUEST['keywords']}%");
        $map['content'] = array('like', "%{$_REQUEST['keywords']}%");
        $map['_logic'] = 'OR';
        $where['_complex'] = $map;
        $where['status'] = 1;

        $list = D('ForumPost')->where($where)->order('last_reply_time desc')->page($page, 10)->select();
        $totalCount = D('ForumPost')->where($where)->count();
        $forums =$this->getForumList();
        $forum_key_value=array();
        foreach($forums as $f){
            $forum_key_value[$f['id']]=$f;
        }
        foreach ($list as &$post) {
            $post['colored_title'] = str_replace('"', '', str_replace($_REQUEST['keywords'], '<span style="color:red">' . $_REQUEST['keywords'] . '</span>', op_t(strip_tags($post['title']))));
            $post['colored_content'] = str_replace('"', '', str_replace($_REQUEST['keywords'], '<span style="color:red">' . $_REQUEST['keywords'] . '</span>', op_t(strip_tags($post['content']))));
            $post['forum']=$forum_key_value[$post['forum_id']];
        }
        unset($post);

        $_GET['keywords'] = $_REQUEST['keywords'];
        //显示页面
        $this->assign('list', $list);
        $this->assign('totalCount', $totalCount);
        $this->display();
    }


    private function limitPictureCount($content)
    {
        //默认最多显示10张图片
        $maxImageCount = 10;

        //正则表达式配置
        $beginMark = 'BEGIN0000hfuidafoidsjfiadosj';
        $endMark = 'END0000fjidoajfdsiofjdiofjasid';
        $imageRegex = '/<img(.*?)\\>/i';
        $reverseRegex = "/{$beginMark}(.*?){$endMark}/i";

        //如果图片数量不够多，那就不用额外处理了。
        $imageCount = preg_match_all($imageRegex, $content);
        if ($imageCount <= $maxImageCount) {
            return $content;
        }

        //清除伪造图片
        $content = preg_replace($reverseRegex, "<img$1>", $content);

        //临时替换图片来保留前$maxImageCount张图片
        $content = preg_replace($imageRegex, "{$beginMark}$1{$endMark}", $content, $maxImageCount);

        //替换多余的图片
        $content = preg_replace($imageRegex, "[图片]", $content);

        //将替换的东西替换回来
        $content = preg_replace($reverseRegex, "<img$1>", $content);

        //返回结果
        return $content;
    }

    private function requireCanDeletePostReply($post_id)
    {
        if (!$this->canDeletePostReply($post_id)) {
            $this->error('您没有删贴权限');
        }
    }

    private function canDeletePostReply($post_id)
    {
        //如果是管理员，则可以删除
        if (is_administrator()) {
            return true;
        }

        //如果是自己的回帖，则可以删除
        $reply = D('ForumPostReply')->find($post_id);
        if ($reply['uid'] == get_uid()) {
            return true;
        }

        //其他情况不能删除
        return false;
    }


    /**过滤输出，临时解决方案
     * @param $content
     * @return mixed|string
     * @auth 陈一枭
     */
    private function filterPostContent($content)
    {
        $content = op_h($content);
        $content = $this->limitPictureCount($content);
        $content = op_h($content);
        return $content;
    }
}