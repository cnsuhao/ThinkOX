<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-10
 * Time: PM9:01
 */

namespace Weibo\Model;

use Think\Model;

class WeiboModel extends Model
{
    protected $_validate = array(
        array('content', '1,99999', '内容不能为空', self::EXISTS_VALIDATE, 'length'),
        array('content', '0,500', '内容太长', self::EXISTS_VALIDATE, 'length'),
    );

    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('status', '1', self::MODEL_INSERT),
    );

    public function addWeibo($uid, $content)
    {


        //$tag_pattern = "/\#([^\#|.]+)\#/";
        $content = op_t($content);//过滤全部非法标签
        $user_math = match_users($content);

        $self = query_user(array('username')); //超找自己
        $content = $this->sendAllAtMessages($content, $user_math, $self);
        $data = array('uid' => $uid, 'content' => $content);
        $data = $this->create($data);
        if (!$data) return false;
        return $this->add($data);
    }


    /**
     * @param $content
     * @param $user_math
     * @param $self
     * @return mixed
     */
    private function sendAllAtMessages($content, $user_math,  $self)
    {
        foreach ($user_math[1] as $match) {

            $map['username'] = $match;
            $user = D('ucenter_member')->where($map)->find();
            if($user){
                $query_user = query_user(array('username', 'space_url'), $user['id']);
                $content = str_replace('@' . $match . ' ', '<a ucard="' . $user['id'] . '" href="' . $query_user['space_url'] . '">@' . $match . ' </a>', $content);
                /**
                 * @param $to_uid 接受消息的用户ID
                 * @param string $content 内容
                 * @param string $title 标题，默认为  您有新的消息
                 * @param $url 链接地址，不提供则默认进入消息中心
                 * @param $int $from_uid 发起消息的用户，根据用户自动确定左侧图标，如果为用户，则左侧显示头像
                 * @param int $type 消息类型，0系统，1用户，2应用
                 */
                D('Message')->sendMessage($user['id'], '微博内容：' . $content, $title = $self['username'] . '的微博@了您', U('Weibo/Index/index'), is_login(), 1);
            }

        }
        return $content;
    }
}