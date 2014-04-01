<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-8
 * Time: PM4:30
 */

namespace Forum\Controller;

use Think\Controller;

define('TOP_ALL', 1);
define('TOP_FORUM', 2);

class LZLController extends Controller
{


    public function  lzllist($to_f_reply_id, $page = 1)
    {
        $limit = 5;
        $list = D('ForumLzlReply')->getLZLReplyList($to_f_reply_id,'ctime asc',$page,$limit);
        $totalCount = D('forum_lzl_reply')->where('to_f_reply_id=' . $to_f_reply_id)->count();
        $data['to_f_reply_id'] = $to_f_reply_id;
        $pageCount = ceil($totalCount / $limit);
        $html = getPageHtml('changePage', $pageCount, $data, $page);
        $this->assign('lzlList', $list);
        $this->assign('html', $html);
        $this->assign('nowPage', $page);
        $this->assign('totalCount', $totalCount);
        $this->assign('limit', $limit);
        $this->assign('count', count($list));
        $this->assign('to_f_reply_id', $to_f_reply_id);
        $this->display();
    }


    public function doSendLZLReply($post_id, $to_f_reply_id, $to_reply_id, $to_uid, $content)
    {

        //确认用户已经登录
        $this->requireLogin();
        //写入数据库
        $model = D('ForumLzlReply');
        $result = $model->addLZLReply($post_id, $to_f_reply_id, $to_reply_id, $to_uid, op_t($content));
        if (!$result) {
            $this->error('发布失败：' . $model->getError());
        }
        //显示成功页面
        $totalCount = D('forum_lzl_reply')->where('to_f_reply_id=' . $to_f_reply_id)->count();
        $limit = 5;
        $pageCount = ceil($totalCount / $limit);
        $this->success($pageCount);
    }

    private function requireLogin()
    {
        if (!is_login()) {
            $this->error('需要登录');
        }
    }

public function delLZLReply($id){
    $this->requireLogin();
    $res= D('ForumLzlReply')->delLZLReply($id);
    $res &&   $this->success($res);
    !$res &&   $this->error('');
}

}