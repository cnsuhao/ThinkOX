<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 1/17/14
 * Time: 7:51 PM
 */

namespace Usercenter\Model;
use Think\Model;

class TitleModel extends Model {
    public function getTitle($uid) {
        $score = query_user('score');
        return $this->getTitleByScore($score);
    }

    public function getTitleByScore($score) {
        //根据积分查询对应头衔
        $config = $this->getTitleConfig();
        foreach($config as $min=>$title) {
            if($score >= $min) {
                return $title;
            }
        }
        //查询无结果，返回最高头衔
        $keys = array_keys($config);
        $max_key = $keys[count($config)-1];
        return $config[$max_key];
    }

    public function getTitleConfig() {
        return array(
            0 => '新手',
            10 => '入门',
            100 => '初级',
            1000 => '高级',
        );
    }
}