<?php

namespace Addons\SyncLogin\Controller;

use Think\Hook;
use User\Api\UserApi;
use Home\Controller\AddonsController;
require_once(dirname(dirname(__FILE__))."/QQSDK/qqConnectAPI.php");




class BaseController extends AddonsController
{

    public function loginWithoutpwd($uid)
    {
        if (0 < $uid) { //UC登录成功
            /* 登录用户 */
            $Member = D('Member');
            if ($Member->login($uid, false)) { //登录用户
                //TODO:跳转到登录前页面
                //redirect(U('Home/Index/index'));
                $this->success('登录成功！', U('Home/Index/index'));
            } else {
                $this->error($Member->getError());
            }
        }
    }

    /**
     * 增加sync_login表中数据
     * @param $uid
     * @param $token
     * @param $openID
     * @param $type
     * @param $oauth_token_secret
     * @return mixed
     * autor:xjw129xjt
     */
    public function addSyncLoginData($uid, $token, $openID, $type, $oauth_token_secret)
    {
        $data['uid'] = $uid;
        $data['type_uid'] = $openID;
        $data['oauth_token'] = $token;
        $data['oauth_token_secret'] = $oauth_token_secret;
        $data['type'] = $type;
        $res = D('sync_login')->add($data);
        return $res;
    }

    /**
     * 将头像保存到本地
     * @param $url
     * @param $oid
     * @param $uid
     * autor:xjw129xjt
     */
    public function saveAvatar($url, $oid, $uid,$type)
    {
        mkdir('./Uploads/Avatar/'.$type.'Avatar', 0777, true);
        $img = file_get_contents($url);
        $filename = './Uploads/Avatar/'.$type.'Avatar/' . $oid . '.jpg';
        file_put_contents($filename, $img);
        $data['uid'] = $uid;
        $data['path'] = $type.'Avatar/' . $oid . '.jpg';
        $data['create_time'] = time();
        $data['status'] = 1;
        $data['is_temp'] = 0;
        D('avatar')->add($data);

    }

}