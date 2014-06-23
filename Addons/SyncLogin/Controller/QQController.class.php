<?php

namespace Addons\SyncLogin\Controller;

use Think\Hook;
use User\Api\UserApi;
use Home\Controller\AddonsController;
require_once(dirname(dirname(__FILE__))."/QQSDK/qqConnectAPI.php");




class QQController extends BaseController
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
            $this->saveAvatar($info['figureurl_qq_2'], $oid, $uid,$type);
        }
        $this->loginWithoutpwd($uid);

       /* Hook::exec('SyncLogin','loginWithoutpwd',$uid);*/

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

}