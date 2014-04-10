<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-10
 * Time: PM9:14
 */

namespace Weibo\Controller;

use Think\Controller;
use Weibo\Api\WeiboApi;
use Think\Exception;
use Common\Exception\ApiException;

class IndexController extends Controller
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    private $weiboApi;

    public function _initialize()
    {
        $this->weiboApi = new WeiboApi();
    }

    public function index()
    {
        //载入第一页微博
        $result = $this->weiboApi->listAllWeibo();

        //显示页面
        $this->assign('list', $result['list']);
        $this->assign('tab', 'all');
        $this->assign('loadMoreUrl', U('loadWeibo'));
        $this->assignSelf();
        $this->display();
    }

    public function myconcerned()
    {
        //载入我关注的微博
        $result = $this->weiboApi->listMyFollowingWeibo();

        //显示页面
        $this->assign('list', $result['list']);
        $this->assign('tab', 'concerned');
        $this->assign('loadMoreUrl', U('loadConcernedWeibo'));
        $this->assignSelf();
        $this->display('index');
    }

    public function weiboDetail($id)
    {
        //读取微博详情
        $result = $this->weiboApi->getWeiboDetail($id);

        //显示页面
        $this->assign('weibo', $result['weibo']);
        $this->assignSelf();
        $this->display();
    }

    public function loadWeibo($page = 1)
    {
        //载入全站微博
        $result = $this->weiboApi->listAllWeibo($page);

        //如果没有微博，则返回错误
        if (!$result['list']) {
            $this->error('没有更多了');
        }

        //返回html代码用于ajax显示
        $this->assign('list', $result['list']);
        $this->display();
    }

    public function loadConcernedWeibo($page = 1)
    {
        //载入我关注的人的微博
        $result = $this->weiboApi->listMyFollowingWeibo($page);

        //如果没有微博，则返回错误
        if (!$result['list']) {
            $this->error('没有更多了');
        }

        //返回html代码用于ajax显示
        $this->assign('list', $result['list']);
        $this->display('loadweibo');
    }

    public function doSend($content)
    {
        //发送微博
        $result = $this->weiboApi->sendWeibo($content);

        //返回成功结果
        $this->ajaxReturn(apiToAjax($result));
    }

    public function doComment($weibo_id, $content, $comment_id = 0)
    {
        //发送评论
        $result = $this->weiboApi->sendComment($weibo_id, $content, $comment_id);

        //返回成功结果
        $this->ajaxReturn(apiToAjax($result));
    }

    public function loadComment($weibo_id)
    {
        //读取数据库中全部的评论列表
        $result = $this->weiboApi->listComment($weibo_id, 1, 10000);
        $list = $result['list'];
        $weiboCommentTotalCount = count($list);

        //返回html代码用于ajax显示
        $this->assign('list', $list);
        $this->assign('weiboId', $weibo_id);
        $this->assign('weiboCommentTotalCount', $weiboCommentTotalCount);
        $this->display();
    }

    public function doDelWeibo($weibo_id = 0)
    {
        //删除微博
        $result = $this->weiboApi->deleteWeibo($weibo_id);

        //返回成功信息
        $this->ajaxReturn(apiToAjax($result));
    }

    public function doDelComment($comment_id = 0)
    {
        //删除评论
        $result = $this->weiboApi->deleteComment($comment_id);

        //返回成功信息
        $this->ajaxReturn(apiToAjax($result));
    }

    public function atWhoJson()
    {
        exit(json_encode($this->getAtWhoUsers()));
    }

    /**
     * 获取表情列表。
     */
    public function getSmile()
    {
        //这段代码不是测试代码，请勿删除
        exit(json_encode(D('Expression')->getAllExpression()));
    }

    private function getAtWhoUsers()
    {
        //获取能AT的人，UID列表。包括我关注的人，和关注我的人，不包括自己。
        $uid = get_uid();
        $follows = D('Follow')->where(array('who_follow' => $uid, 'follow_who' => $uid, '_logic' => 'or'))->limit(999)->select();
        $uids = array();
        foreach ($follows as &$e) {
            $uids[] = $e['who_follow'];
            $uids[] = $e['follow_who'];
        }
        unset($e);
        $uids = array_unique($uids);

        //加入拼音检索
        $users = array();
        foreach ($uids as $uid) {
            $user = query_user(array('username', 'id', 'avatar32'), $uid);
            $user['search_key'] = $user['username'] . D('PinYin')->Pinyin($user['username']);
            $users[] = $user;
        }

        //返回at用户列表
        return $users;
    }

    private function getAtWhoUsersCached()
    {
        $cacheKey = 'weibo_at_who_users_' . get_uid();
        $atusers = S($cacheKey);
        if (empty($atusers)) {
            $atusers = $this->getAtWhoUsers();
            S($cacheKey, $atusers, 600);
        }
        return $atusers;
    }

    private function assignSelf()
    {
        $self = query_user(array('avatar128', 'username', 'uid', 'space_url', 'icons_html', 'score', 'title', 'fans', 'following', 'weibocount', 'rank_link'));
        $this->assign('self', $self);
    }
}