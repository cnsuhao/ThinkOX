<?php

namespace Addons\SyncLogin;

use Common\Controller\Addon;
use Weibo\Api\WeiboApi;

/**
 * 同步登陆插件
 * @author 想天软件工作室
 */
class SyncLoginAddon extends Addon
{

    public $info = array(
        'name' => 'SyncLogin',
        'title' => '同步登陆',
        'description' => '同步登陆',
        'status' => 1,
        'author' => 'xjw129xjt',
        'version' => '0.1'
    );

    public function install()
    {
        return true;
    }

    public function uninstall()
    {
        return true;
    }

    //实现的repost钩子方法
    public function syncLogin($param)
    {
        $this->assign($param);

        $config = $this->getConfig();
        dump($config);

        $this->display('login');
    }

    public function syncMeta($param)
    {
        $platform_options = $this->getConfig();

        echo $platform_options['meta'];
    }

    public function AdminIndex($param)
    {
        $config = $this->getConfig();
        $this->assign('addons_config', $config);
        if ($config['display'])
            $this->display('widget');
    }

    public function loginWithoutpwd($uid)
    {
        if (0 < $uid) { //UC登录成功
            /* 登录用户 */
            $Member = D('Member');
            if ($Member->login($uid, false)) { //登录用户
                //TODO:跳转到登录前页面
                $this->success('登录成功！', U('Home/Index/index'));
            } else {
                $this->error($Member->getError());
            }
        }
    }

}