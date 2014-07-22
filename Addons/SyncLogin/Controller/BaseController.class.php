<?php

namespace Addons\SyncLogin\Controller;

use Think\Hook;
use User\Api\UserApi;
use Home\Controller\AddonsController;

require_once(dirname(dirname(__FILE__))."/ThinkSDK/ThinkOauth.class.php");




class BaseController extends AddonsController
{

    //登录地址
    public function login(){
        $type= I('get.type');
        empty($type) && $this->error('参数错误');
        //加载ThinkOauth类并实例化一个对象
        $sns  = \ThinkOauth::getInstance($type);
        //跳转到授权页面
        redirect($sns->getRequestCodeURL());
    }


    /**
     * 登陆后回调地址
     * autor:xjw129xjt
     */
    public function callback(){
        $code =  I('get.code');
        $type= I('get.type');
        $sns  = \ThinkOauth::getInstance($type);

        //腾讯微博需传递的额外参数
        $extend = null;
        if($type == 'tencent'){
            $extend = array('openid' => I('get.openid'), 'openkey' =>  I('get.openkey'));
        }

        $token = $sns->getAccessToken($code , $extend);


/*      $addon_config =  get_addon_config('SynvLogin');

        redirect(addons_url('SyncLogin://Base/bind'));*/


        $access_token = $token['access_token'];
        $openid =  $token['openid'];
        $user_info = D('Addons://SyncLogin/Info')->$type($token);
        if ($info1 = D('sync_login')->where("`type_uid`='" . $openid . "' AND type='" . $type . "'")->find()) {
            $user = D('UcenterMember')->where("id=" . $info1 ['uid'])->find();
            if (empty ($user)) {
                D('sync_login')->where("type_uid=" . $openid . " AND type='" . $type . "'")->delete();
                //已经绑定过，执行登录操作，设置token
            } else {
                if ($info1 ['oauth_token'] == '') {

                    $syncdata ['id'] = $info1 ['id'];
                    $syncdata ['oauth_token'] = $access_token;
                    $syncdata ['oauth_token_secret'] = $openid;
                    D('sync_login')->save($syncdata);
                }
                $uid = $info1 ['uid'];
            }
        } else {
            $Api = new UserApi();
            //usercenter表新增数据
            $uid = $Api->addSyncData();
            //member表新增数据
            D('Home/Member')->addSyncData($uid, $user_info);

            // 记录数据到sync_login表中
            $this->addSyncLoginData($uid, $access_token, $openid, $type, $openid);
            //保存头像
            $this->saveAvatar($user_info['head'], $openid, $uid,$type);
            $config=D('Config')->where(array('name'=>'USER_REG_WEIBO_CONTENT'))->find();
            $reg_weibo=$config['value'];//用户注册的微博内容
            if($reg_weibo!='' && $config){//为空不发微博
                D('Weibo/Weibo')->addWeibo($uid,$reg_weibo);
            }
        }
        $this->loginWithoutpwd($uid);


    }

    /**
     * 利用uid登录
     * @param $uid
     * autor:xjw129xjt
     */
    protected  function loginWithoutpwd($uid)
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
    protected  function addSyncLoginData($uid, $token, $openID, $type, $oauth_token_secret)
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
    protected function saveAvatar($url, $oid, $uid,$type)
    {

        if(is_sae()){
            $s = new \SaeStorage();
            $img = file_get_contents($url);  //括号中的为远程图片地址

            $url_sae= $s->write (C('UPLOAD_SAE_CONFIG.domain') ,  '/Avatar/'.$type.'Avatar/' . $oid . '.jpg', $img );
            $data['path'] = $url_sae;
        }else{
            mkdir('./Uploads/Avatar/'.$type.'Avatar', 0777, true);
            $img = file_get_contents($url);
            $filename = './Uploads/Avatar/'.$type.'Avatar/' . $oid . '.jpg';
            file_put_contents($filename, $img);
            $data['path'] = $type.'Avatar/' . $oid . '.jpg';
        }
        $data['uid'] = $uid;
        $data['create_time'] = time();
        $data['status'] = 1;
        $data['is_temp'] = 0;
        D('avatar')->add($data);

    }

    public function bind(){

        dump('aaaaa');
        dump(T('Addons://Attachment@Article/detail'));
        $this->display(T('Addons://SyncLogin@Base/bind'));
    }

}