<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 4/2/14
 * Time: 9:14 AM
 */

namespace Weibo\Api;

use Common\Api\Api;
use Common\Exception\ApiException;

class WeiboApi extends Api
{
    private $weiboModel;

    public function __construct()
    {
        // 模型名称请使用完整路径，否则其他应用中无法调用接口。
        $this->weiboModel = D('Weibo/Weibo');
        $this->followModel = D('Weibo/Follow');
        $this->commentModel = D('Weibo/WeiboComment');
    }

    public function listAllWeibo($page = 1, $count = 10)
    {
        //获取微博列表
        $map = array('status' => 1);
        $model = $this->weiboModel;
        $list = $model->where($map)->order('create_time desc')->page($page, $count)->select();

        //获取每个微博详情
        foreach ($list as &$e) {
            $e = $this->getWeiboStructure($e['id']);
        }
        unset($e);

        //返回微博列表
        return $this->apiSuccess('获取成功', array('list' => arrayval($list)));
    }

    public function listMyFollowingWeibo($page = 1, $count = 10)
    {
        $this->requireLogin();

        //获取我关注的人
        $result = $this->followModel->where(array('who_follow' => get_uid()))->select();
        foreach ($result as &$e) {
            $e = $e['follow_who'];
        }
        unset($e);
        $followList = $result;
        $followList[] = is_login();

        //获取我关注的微博
        $list = D('Weibo')->where('status=1 and uid in(' . implode(',', $followList) . ')')->order('id desc')->page($page, $count)->select();

        //获取每个微博的详细信息
        foreach ($list as &$e) {
            $e = $this->getWeiboStructure($e['id']);
        }
        unset($e);

        //返回我关注的微博列表
        return $this->apiSuccess('获取成功', array('list' => arrayval($list)));
    }

    public function getWeiboDetail($weibo_id)
    {
        $this->requireWeiboExist($weibo_id);

        //获取微博详情
        $weibo = $this->getWeiboStructure($weibo_id);

        //返回微博详情
        return $this->apiSuccess('获取成功', array('weibo' => $weibo));
    }

    public function sendWeibo($content)
    {
        $this->requireSendInterval();
        $this->requireLogin();

        //写入数据库
        $model = $this->weiboModel;
        $score_before = getMyScore();
        $result = $model->addWeibo(is_login(), $content);
        $score_after = getMyScore();
        if (!$result) {
            throw new ApiException('发布失败：' . $model->getError());
        }
        $this->updateLastSendTime();

        //显示成功页面
        $message = '发表微博成功。' . getScoreTip($score_before, $score_after);
        $score_increase = $score_after - $score_before;
        return $this->apiSuccess($message, array('score_increase' => $score_increase));
    }

    public function sendComment($weibo_id, $content, $comment_id = 0)
    {
        $this->requireSendInterval();
        $this->requireLogin();

        //写入数据库
        $model = D('WeiboComment');
        $score_before = getMyScore();
        $result = $model->addComment(get_uid(), $weibo_id, $content, $comment_id);
        $score_after = getMyScore();
        if (!$result) {
            return $this->apiError('评论失败：' . $model->getError());
        }
        $this->updateLastSendTime();

        //显示成功页面
        return $this->apiSuccess('评论成功。' . getScoreTip($score_before, $score_after));
    }

    public function listComment($weibo_id, $page = 1, $count = 10)
    {
        //从数据库中读取评论列表
        $list = D('WeiboComment')->where(array('weibo_id' => $weibo_id, 'status' => 1))->order('create_time desc')->page($page, $count)->select();

        //格式化评论列表
        foreach ($list as &$e) {
            $e = $this->getCommentStructure($e['id']);
        }
        unset($e);

        //返回结果
        return $this->apiSuccess('获取成功', array('list' => arrayval($list)));
    }

    public function deleteWeibo($weibo_id)
    {
        //确认当前登录的用户有删除权限
        if (!$this->canDeleteWeibo($weibo_id)) {
            return $this->apiError('您没有权限删除微博');
        }

        //从数据库中删除微博
        $result = $this->weiboModel->where(array('id' => $weibo_id))->setField('status', 0);
        $this->commentModel->where(array('weibo_id' => $weibo_id))->setField('status', 0);
        if (!$result) {
            return $this->apiError('数据库写入错误');
        }

        //返回成功消息
        return $this->apiSuccess('删除成功');
    }

    public function deleteComment($comment_id)
    {
        //确认当前登录的用户有删除权限
        if (!$this->canDeleteComment($comment_id)) {
            return $this->apiError('您没有删除权限');
        }

        //从数据库中删除微博
        $result = $this->commentModel->where(array('id' => $comment_id))->setField('status', 0);
        if (!$result) {
            return $this->apiError('数据库写入错误');
        }

        //减少微博评论数量
        $this->weiboModel->where(array('id' => $comment_id))->setDec('comment_count');

        //返回成功消息
        return $this->apiSuccess('删除成功');
    }

    private function getWeiboStructure($id)
    {
        $weibo = $this->weiboModel->find($id);
        $canDelete = $this->canDeleteWeibo($id);
        return array(
            'id' => intval($weibo['id']),
            'content' => strval($weibo['content']),
            'create_time' => intval($weibo['create_time']),
            'comment_count' => intval($weibo['comment_count']),
            'can_delete' => boolval($canDelete),
            'user' => $this->getUserStructure($weibo['uid']),
        );
    }

    private function getCommentStructure($id)
    {
        $comment = $this->commentModel->find($id);
        $canDelete = $this->canDeleteComment($id);
        return array(
            'id' => intval($comment['id']),
            'content' => strval($comment['content']),
            'create_time' => intval($comment['create_time']),
            'can_delete' => boolval($canDelete),
            'user' => $this->getUserStructure($comment['uid']),
        );
    }

    private function requireWeiboExist($id)
    {
        $weibo = $this->weiboModel->where(array('id' => $id, 'status' => 1))->find();
        if (!$weibo) {
            throw new ApiException('微博不存在');
        }
    }

    private function canDeleteWeibo($weibo_id)
    {
        //如果是管理员，则可以删除微博
        if (is_administrator(get_uid())) {
            return true;
        }

        //如果是自己发送的微博，可以删除微博
        $weibo = $this->weiboModel->find($weibo_id);
        if ($weibo['uid'] == get_uid()) {
            return true;
        }

        //返回，不能删除微博
        return false;
    }

    private function canDeleteComment($comment_id)
    {
        //如果是管理员，则可以删除
        if (is_administrator(get_uid())) {
            return true;
        }

        //如果评论是自己发送的，则可以删除微博
        $comment = $this->commentModel->find($comment_id);
        if ($comment['uid'] == get_uid()) {
            return true;
        }

        //其他情况不能删除微博
        return false;
    }
}