<?php
/**
 * 所属项目 OnePlus.
 * 开发者: 想天
 * 创建日期: 3/16/14
 * 创建时间: 10:56 PM
 * 版权所有 想天工作室(www.ourstu.com)
 */

namespace Forum\Model;

use Think\Model;

class ForumMessageModel extends Model
{
    public function getData()
    {
        $amessage = array('uid' => 3,
            'ctime' => friendlyDate(time() - 6000),
        );
        $amessage_self = $amessage;
        $amessage_self['uid'] = is_login();
        $messages[] = $amessage;
        $messages[] = $amessage;
        $messages[] = $amessage_self;
        $messages[] = $amessage;
        $messages[] = $amessage;
        $messages[] = $amessage;
        $messages[] = $amessage_self;

        foreach ($messages as &$message) {
            $user = query_user(array('avatar128', 'username', 'space_url'), $message['uid']);
            $message = array_merge($user, $message);
            $message['content'] = '测试内容' . rand(0, 1000);
            unset($message);
        }
        unset($message);
        $data['messages']=$messages;
        $data['source']['content']='原帖内容';
        $data['source']['url']=U('Forum/Index/detail');
        return $data;
    }
} 