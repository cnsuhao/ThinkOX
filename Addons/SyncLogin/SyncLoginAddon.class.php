<?php

namespace Addons\SyncLogin;

use Common\Controller\Addon;
use Weibo\Api\WeiboApi;

/**
 * 同步登陆插件
 * @author 嘉兴想天信息科技有限公司
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
        $prefix = C("DB_PREFIX");
        $model = D();
        $model->execute("DROP TABLE IF EXISTS {$prefix}sync_login;");
        $model->execute("CREATE TABLE {$prefix}sync_login ( `uid` int(11) NOT NULL,  `type_uid` varchar(255) NOT NULL,  `type` varchar(255) NOT NULL,  `oauth_token` varchar(255) NOT NULL,  `oauth_token_secret` varchar(255) NOT NULL,  `is_sync` tinyint(4) NOT NULL,  PRIMARY KEY (`uid`))");
        return true;
    }

    public function uninstall()
    {
        return true;
    }

    //登录按钮钩子
    public function syncLogin($param)
    {
        $this->assign($param);
        $config = $this->getConfig();
        $this->assign('config',$config);
        $this->display('login');
    }

    /**
     * meta代码钩子
     * @param $param
     * autor:xjw129xjt
     */
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

}