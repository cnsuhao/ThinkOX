<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-8
 * Time: PM4:14
 */

namespace Forum\Model;
use Think\Model;

class ForumPostModel extends Model {
    protected $_validate = array(
        array('title', '1,100', '标题长度不合法', self::EXISTS_VALIDATE, 'length'),
        array('content', '1,40000', '内容长度不合法', self::EXISTS_VALIDATE, 'length'),
    );

    protected $_auto = array(
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('update_time', NOW_TIME, self::MODEL_BOTH),
        array('last_reply_time', NOW_TIME, self::MODEL_INSERT),
        array('status', '1', self::MODEL_INSERT),
    );

    public function editPost($data) {
        $data = $this->create($data);
        if(!$data) return false;
        return $this->save($data);
    }

    public function createPost($data) {
        //新增帖子
        $data = $this->create($data);
        if(!$data) return false;

        $result = $this->add($data);
        action_log('add_post','ForumPost',$result,is_login());
        if(!$result) {
            return false;
        }

        //增加板块的帖子数量
        D('Forum')->where(array('id'=>$data['forum_id']))->setInc('post_count');

        //返回帖子编号
        return $result;
    }
}