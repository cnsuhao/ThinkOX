<?php

namespace Addons\SyncLogin\Controller;

use User\Api\UserApi;
use Home\Controller\AddonsController;
require_once(dirname(dirname(__FILE__))."/QQSDK/qqConnectAPI.php");



class QQController extends AddonsController
{

    /**
     * qqlogin
     * QQ同步登陆回调
     * autor:xjw129xjt
     */

    public function qqlogin()
    {
        $qc = new \QC();
        $acs = $qc->qq_callback();
        $oid = $qc->get_openid();
        $qc = new \QC($acs, $oid);
        $info = $qc->get_user_info();
        $type = 'qq';
        if ($info1 = D('sync_login')->where("`type_uid`='" . $oid . "' AND type='" . $type . "'")->find()) {
            $user = D('UcenterMember')->where("id=" . $info1 ['uid'])->find();
            if (empty ($user)) {
                D('sync_login')->where("type_uid=" . $oid . " AND type='" . $type . "'")->delete();
                //已经绑定过，执行登录操作，设置token
            } else {
                if ($info1 ['oauth_token'] == '') {
                    $syncdata ['id'] = $info1 ['id'];
                    $syncdata ['oauth_token'] = $acs;
                    $syncdata ['oauth_token_secret'] = $oid;
                    D('sync_login')->save($syncdata);
                }
                $uid = $info1 ['uid'];
            }
        } else {

            $Api = new UserApi();

            $uid = $Api->addSyncData($info);
            D('Member')->addSyncData($uid, $info);
            $this->addSyncLoginData($uid, $acs, $oid, 'qq', $oid);
            $this->saveAvatar($info['figureurl_qq_2'], $oid, $uid);
        }
      //  $this->loginWithoutpwd($uid);

        Hook::exec('SyncLogin','loginWithoutpwd',$uid);

    }

    /**
     * 跳转到QQ同步登陆页面
     * autor:xjw129xjt
     */
    public function qq()
    {
        $qc = new \QC();
        $qc->qq_login();
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
    public function saveAvatar($url, $oid, $uid)
    {
        mkdir('./Uploads/Avatar/qqAvatar', 0777, true);
        $img = file_get_contents($url);
        $filename = './Uploads/Avatar/qqAvatar/' . $oid . '.jpg';
        file_put_contents($filename, $img);
        $data['uid'] = $uid;
        $data['path'] = 'qqAvatar/' . $oid . '.jpg';
        $data['create_time'] = time();
        $data['status'] = 1;
        $data['is_temp'] = 0;
        D('avatar')->add($data);

    }



}