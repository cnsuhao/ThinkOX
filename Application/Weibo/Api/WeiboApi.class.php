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
        $this->weiboModel = D('Weibo/Weibo');
        $this->followModel = D('Weibo/Follow');
    }

    public function listAllWeibo($page = 1, $count = 20)
    {
        //获取微博列表
        $map = array('status' => 1);
        $model = $this->weiboModel;
        $list = $model->where($map)->order('create_time desc')->page($page, $count)->select();

        //确认正确获取了微博列表
        if (!$list) {
            return $this->apiError('没有更多微博了');
        }

        //获取每个微博详情
        foreach ($list as &$e) {
            $e = $this->getWeiboStructure($e['id']);
        }
        unset($e);

        //返回微博列表
        return $this->apiSuccess('获取成功', array('list' => arrayval($list)));
    }

    public function listMyFollowingWeibo($page = 1, $count = 20)
    {
        //获取我关注的人
        $result = $this->followModel->where(array('who_follow'=>get_uid()))->select();
        foreach($result as &$e) {
            $e = $e['follow_who'];
        }
        unset($e);
        $followList = $result;
        $followList[] = is_login();

        //获取我关注的微博
        $list = D('Weibo')->where('status=1 and uid in(' . implode(',', $followList) . ')')->order('id desc')->page($page, $count)->select();

        //获取每个微博的详细信息
        foreach($list as &$e) {
            $e = $this->getWeiboStructure($e['id']);
        }
        unset($e);

        //返回我关注的微博列表
        return $this->apiSuccess('获取成功', array('list' => arrayval($list)));
    }

    private function getWeiboStructure($id)
    {
        $weibo = $this->weiboModel->where(array('id' => $id))->find();
        return array(
            'id' => intval($weibo['id']),
            'content' => strval($weibo['content']),
            'create_time' => intval($weibo['create_time']),
            'comment_count' => intval($weibo['comment_count']),
            'user' => $this->getUserStructure($weibo['uid']),
        );
    }

    private function requireLogin() {
        if(!is_login()) {
            throw new ApiException('需要登录', 400);
        }
    }
}