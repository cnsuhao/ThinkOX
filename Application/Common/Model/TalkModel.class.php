<?php
/**
 * 所属项目 OnePlus.
 * 开发者: 想天
 * 创建日期: 3/13/14
 * 创建时间: 7:41 PM
 * 版权所有 想天工作室(www.ourstu.com)
 */

namespace Common\Model;

use Think\Model;

class TalkModel extends Model
{
    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
        array('status', '1', self::MODEL_INSERT),
    );

    public function getUids($uids)
    {
        preg_match_all('/\[(.*?)\]/', $uids, $uids_array);
        return $uids_array[1];
    }

    public function getCurrentSessions()
    {
        $list = $this->where('uids like' . '"%[' . is_login() . ']%"' . ' and status=1')->order('update_time desc')->select();
        foreach ($list as &$li) {
            $uids = $this->getUids($li['uids']);
            foreach ($uids as $uid) {
                if ($uid != is_login()) {
                    $li['first_user'] = query_user(array('avatar64', 'username'), $uid);
                    $li['last_message'] = $this->getLastMessage($li['id']);
                    break;
                }
            }
        }
        unset($li);
        return $list;
    }

    public function getLastMessage($talk_id)
    {
        $last_message = D('TalkMessage')->where('talk_id=' . $talk_id)->order('create_time desc')->find();
        $last_message['user'] = query_user(array('username', 'space_url', 'id'), $last_message['uid']);
        $last_message['content'] = op_t($last_message['content']);
        return $last_message;
    }


}