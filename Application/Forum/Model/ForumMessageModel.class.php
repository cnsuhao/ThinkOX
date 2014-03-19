<?php
/**
 * 所属项目 OnePlus.
 * 开发者: 想天
 * 创建日期: 3/16/14
 * 创建时间: 10:56 PM
 * 版权所有 想天工作室(www.ourstu.com)
 */

namespace Forum\Model;

use Common\Model\IMessage;
use Think\Model;

class ForumMessageModel extends Model implements IMessage
{
    public function getData($id, $source_id, $type = 'reply')
    {

        $message = D('Message')->find($id);
        $messages = array();
        $source = array();
        if (strtolower($type) == 'reply') {
            $post = D('forum_post')->find($message['source_id']);
            $user = query_user(array('space_link', 'avatar64'), $post['uid']);
            $source['content'] = '<h2>[标题] ' . op_t($post['title']) . '</h2><p>[内容] ' . op_t($post['content']) . '</p><div class="pull-right"><img class="avatar-img" style="width:64px" src="' . $user['avatar64'] . '" ucard="' . $post['uid'] . '"</div>';
            $source['url'] = U('Forum/Index/detail', array('id' => $post['id']));
            //查找来源用户和当前用户的全部
            $forum_reply = D('forum_post_reply')->find($message['find_id']); //查找回帖信息
            $message['uid'] = $forum_reply['uid'];
            $message['ctime'] = friendlyDate($forum_reply['create_time']);
            $user = query_user(array('avatar128', 'username', 'space_url'), $forum_reply['uid']);
            $message = array_merge($user, $message);
            $message['content'] = $forum_reply['content'];
            $messages[] = $message;
        } else {
            $post = D('forum_post')->find($message['source_id']);
            $user = query_user(array('space_link', 'avatar64'), $post['uid']);
            $source['content'] = '<h2>[标题] ' . op_t($post['title']) . '</h2><p>[内容] ' . op_t($post['content']) . '</p><div class="pull-right"><img class="avatar-img" style="width:64px" src="' . $user['avatar64'] . '" ucard="' . $post['uid'] . '"</div>';
            $source['url'] = U('Forum/Index/detail', array('id' => $post['id']));
            //查找来源用户和当前用户的全部
            $forum_reply = D('forum_post_reply')->find($message['find_id']); //查找回帖信息
            $message['uid'] = $forum_reply['uid'];
            $message['ctime'] = friendlyDate($forum_reply['create_time']);
            $user = query_user(array('avatar128', 'username', 'space_url'), $forum_reply['uid']);
            $message = array_merge($user, $message);
            $message['content'] = $forum_reply['content'];
            $messages[] = $message;


        }
        $data['messages'] = $messages;
        $data['source'] = $source;
        return $data;
    }

    public function getSource($message)
    {
        if ($message['apptype'] == 'reply') {
            $post = D('ForumPost')->find($message['source_id']);
            $source['source_title'] = $post['title'];
            $source['source_content'] = $post['content'];
            $source['source_url'] = U('Forum/Index/detail', array('id' => $post['id']));
        }

        return $source;
    }

    public function postMessage($source_message, $content, $uid, $type = 'reply')
    {
        return D('Forum/ForumLzlReply')->addLZLReply($source_message['source_id'], $source_message['find_id'], 0, $source_message['from_uid'], $content);
    }


}