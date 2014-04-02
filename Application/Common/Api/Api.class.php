<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 4/2/14
 * Time: 9:14 AM
 */

namespace Common\Api;

class Api {
    protected function apiSuccess($message, $extra) {
        return $this->apiReturn(true, $message, $extra);
    }

    protected function apiError($message, $extra=array()) {
        return $this->apiReturn(false, $message, $extra);
    }

    protected function apiReturn($success, $message, $extra) {
        $result = array('success'=>boolval($success), 'message'=>strval($message));
        $result = array_merge($result, $extra);
        return $result;
    }

    protected function getUserStructure($uid) {
        //请不要在这里增加用户敏感信息，可能会暴露用户隐私
        $fields = array('uid','username','avatar32', 'avatar64', 'avatar128', 'avatar256', 'avatar512','space_url','icons_html');
        return query_user($fields, $uid);
    }
}