<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-8
 * Time: PM4:14
 */

namespace Forum\Model;
use Think\Model;

class ForumPostReplyModel extends Model {
    protected $_validate = array(
        array('content', '1,40000', '内容长度不合法', self::EXISTS_VALIDATE, 'length'),
    );

    protected $_auto = array(
        array('create_time',NOW_TIME,self::MODEL_INSERT),
        array('update_time',NOW_TIME),
        array('status', '1', self::MODEL_INSERT),
    );

    public function addReply($post_id, $content) {
        //新增一条回复
        $data = array('uid'=>is_login(), 'post_id'=>$post_id, 'parse'=>0, 'content'=>$content);
        $data = $this->create($data);
        if(!$data) return false;
        $result = $this->add($data);

        //增加帖子的回复数
        D('ForumPost')->where(array('id'=>$post_id))->setInc('reply_count');

        //返回结果
        return $result;
    }
}