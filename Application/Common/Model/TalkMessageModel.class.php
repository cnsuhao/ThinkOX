<?php
/**
 * 所属项目 OnePlus.
 * 开发者: 想天
 * 创建日期: 3/18/14
 * 创建时间: 9:12 PM
 * 版权所有 想天工作室(www.ourstu.com)
 */

namespace Common\Model;


use Think\Model;

class TalkMessageModel extends Model
{
    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('status', '1', self::MODEL_INSERT),
    );

    public function addMessage($content, $uid, $talk_id)
    {
        $message['content'] = $content;
        $message['uid'] = $uid;
        $message['talk_id'] = $talk_id;
        $message = $this->create($message);
        return $this->add($message);

    }
} 