<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-8
 * Time: PM4:14
 */

namespace Forum\Model;
use Think\Model;

class ForumModel extends Model {
    protected $_validate = array(
        array('title', '1,100', '标题长度不合法', self::EXISTS_VALIDATE, 'length'),
    );

    protected $_auto = array(
        array('post_count', '0', self::MODEL_INSERT),
        array('create_time', NOW_TIME, self::MODEL_INSERT),
        array('status', '1', self::MODEL_INSERT),
    );
}
