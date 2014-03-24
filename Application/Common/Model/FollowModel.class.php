<?php
/**
 * 所属项目 OnePlus.
 * 开发者: 想天
 * 创建日期: 3/21/14
 * 创建时间: 10:17 AM
 * 版权所有 想天工作室(www.ourstu.com)
 */

namespace Common\Model;


use Think\Model;

class FollowModel extends Model
{

    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT));

    /**关注
     * @param $uid
     * @return int|mixed
     */
    public function follow($uid)
    {
        $follow['who_follow'] = is_login();
        $follow['follow_who'] = $uid;
        if ($this->where($follow)->count() > 0) {
            return 0;
        }
        $follow = $this->create($follow);

        clean_query_user_cache($uid,'fans');
        clean_query_user_cache(is_login(),'following');
        /**
         * @param $to_uid 接受消息的用户ID
         * @param string $content 内容
         * @param string $title 标题，默认为  您有新的消息
         * @param $url 链接地址，不提供则默认进入消息中心
         * @param $int $from_uid 发起消息的用户，根据用户自动确定左侧图标，如果为用户，则左侧显示头像
         * @param int $type 消息类型，0系统，1用户，2应用
         */
        $user = query_user(array('id', 'username', 'space_url'));

        D('Message')->sendMessage($uid, $user['username'] . ' 关注了你。', '粉丝数增加', $user['space_url'], is_login(), 0);
        return $this->add($follow);
    }

    /**取消关注
     * @param $uid
     * @return mixed
     */
    public function unfollow($uid)
    {
        $follow['who_follow'] = is_login();
        $follow['follow_who'] = $uid;
        clean_query_user_cache($uid,'fans');
        clean_query_user_cache(is_login(),'following');
        $user = query_user(array('id', 'username', 'space_url'));
        D('Message')->sendMessage($uid, $user['username'] . '取消了对你的关注', '粉丝数减少', $user['space_url'], is_login(), 0);
        return $this->where($follow)->delete();
    }

    public function getFans($uid, $page,$fields,&$totalCount)
    {
        $map['follow_who'] = $uid;
        $fans = $this->where($map)->field('who_follow')->order('create_time desc')->page($page, 10)->select();
        $totalCount = $this->where($map)->field('who_follow')->order('create_time desc')->count();
        foreach ($fans as &$user) {
            $user['user'] = query_user($fields, $user['who_follow']);
        }
        unset($user);
        return $fans;
    }
    public function getFollowing($uid, $page,$fields,&$totalCount)
    {
        $map['who_follow'] = $uid;
        $fans = $this->where($map)->field('follow_who')->order('create_time desc')->page($page, 10)->select();
        $totalCount = $this->where($map)->field('follow_who')->order('create_time desc')->count();

        foreach ($fans as &$user) {
            $user['user'] = query_user($fields, $user['follow_who']);
        }
        unset($user);
        return $fans;
    }

} 