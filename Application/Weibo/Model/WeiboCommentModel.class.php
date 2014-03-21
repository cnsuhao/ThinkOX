<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-10
 * Time: PM9:01
 */

namespace Weibo\Model;

use Think\Model;

class WeiboCommentModel extends Model
{
    protected $_validate = array(
        array('content', '1,99999', '内容不能为空', self::EXISTS_VALIDATE, 'length'),
        array('content', '0,500', '内容太长', self::EXISTS_VALIDATE, 'length'),
    );

    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('status', '1', self::MODEL_INSERT),
    );

    public function addComment($uid, $weibo_id, $content,$comment_id=0)
    {
        //将评论内容写入数据库
        $data = array('uid' => $uid, 'weibo_id' => $weibo_id, 'content' => $content,'comment_id'=>$comment_id);
        $data = $this->create($data);
        if (!$data) return false;
        $result = $this->add($data);
        $this->sendCommentMessage($uid, $weibo_id, $content);
        if($comment_id!=0){
            $this->sendCommentReplyMessage($uid, $comment_id, $content);
        }

        //增加微博的评论数量
        D('Weibo')->where(array('id' => $weibo_id))->setInc('comment_count');

        //返回评论编号
        return $result;
    }

    /**
     * @param $uid
     * @param $weibo_id
     * @param $content
     */
    private function sendCommentMessage($uid, $weibo_id, $content)
    {

        $user = query_user(array('username', 'space_url'), $uid);

        $title = $user['username'] . '评论了您的微博。';
        $content = '评论内容：' . $content;

        $weibo = D('Weibo')->find($weibo_id);
        $url = U('Weibo/Index/index');
        $from_uid = $uid;
        $type = 2;
        D('Message')->sendMessage($weibo['uid'], $content, $title, $url, $from_uid, $type);
    }
    /**
     * @param $uid
     * @param $weibo_id
     * @param $content
     */
    private function sendCommentReplyMessage($uid, $comment_id, $content)
    {

        $user = query_user(array('username', 'space_url'), $uid);

        $title = $user['username'] . '回复了您的微博评论。';
        $content = '回复内容：' . $content;

        $comment = $this->find($comment_id);
        $url = U('Weibo/Index/index').'#weibo_'.$comment['weibo_id'];
        $from_uid = $uid;
        $type = 2;
        D('Message')->sendMessage($comment['uid'], $content, $title, $url, $from_uid, $type);
    }

}