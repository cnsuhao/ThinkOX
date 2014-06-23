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
    public function repost($param)
    {
        $weibo = $this->getweiboDetail($param['weiboId']);


        $sourseId = $weibo['data']['sourseId'];

        if (!$sourseId) {
            $sourseId = $param['weiboId'];
        }
        $param['sourseId'] = $sourseId;
        $this->assign('repost_count', $weibo['repost_count']);
        $this->assign($param);
        $this->display('repost');
    }

}