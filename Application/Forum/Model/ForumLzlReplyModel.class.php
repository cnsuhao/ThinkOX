<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-8
 * Time: PM4:14
 */

namespace Forum\Model;

use Think\Model;

class ForumLzlReplyModel extends Model
{
    protected $_validate = array(
        array('content', '1,40000', '内容长度不合法', self::EXISTS_VALIDATE, 'length'),
    );

    protected $_auto = array(
        array('ctime', NOW_TIME, self::MODEL_INSERT),
        array('is_del', '0', self::MODEL_INSERT),
    );

    public function addLZLReply($post_id,$to_f_reply_id,$to_reply_id,$to_uid, $content)
    {
        //新增一条回复
        $data = array('uid' => is_login(), 'post_id'=>$post_id,'to_f_reply_id' => $to_f_reply_id, 'to_reply_id' => $to_reply_id,'to_uid'=>$to_uid, 'content' => $content);
        $data = $this->create($data);
        if (!$data) return false;
        $result = $this->add($data);

        //增加帖子的回复数
        D('ForumPost')->where(array('id' => $post_id))->setInc('reply_count');

        //更新最后回复时间
        D("ForumPost")->where(array('id' => $post_id))->setField('last_reply_time', time());
        $this->sendReplyMessage(is_login(), $post_id, $content,$to_uid);
        //返回结果
        return $result;
    }


    /**
     * @param $uid
     * @param $weibo_id
     * @param $content
     */
    private function sendReplyMessage($uid, $post_id, $content,$to_uid)
    {
        //增加微博的评论数量
        $user = query_user(array('username', 'space_url'), $uid);
        $post = D('ForumPost')->find($post_id);

        $title = $user['username'] . '回复了您的评论。';
        $content = '回复内容：' . mb_substr($content, 0, 20);


        $url = U('Forum/Index/detail', array('id' => $post_id));
        $from_uid = $uid;
        $type = 2;
        D('Message')->sendMessage($to_uid, $content, $title, $url, $from_uid, $type);
    }
}