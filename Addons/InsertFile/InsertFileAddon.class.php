<?php

namespace Addons\InsertFile;

use Common\Controller\Addon;

/**
 * 插入附件插件
 * @author onep2p
 */
class InsertFileAddon extends Addon
{

    public $info = array(
        'name' => 'InsertFile',
        'title' => '插入附件',
        'description' => '微博上传附件',
        'status' => 1,
        'author' => 'onep2p',
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

    //实现的InsertFile钩子方法
    public function weiboType($param)
    {
        $this->display('InsertFile');
    }
    
    //发送钩子
    public function beforeSendRepost($param){
    	if(isset($_SESSION['Upload_File_ID']) && !empty($_SESSION['Upload_File_ID'])){
    		$param['type'] = 'file';
    		$param['feed_data']['attach_ids'] = $_SESSION['Upload_File_ID'];
    	}
    }
    
    //展示数据
    public function fetchFile($weibo)
    {
        $weibo_data = unserialize($weibo['data']);

        $param['weibo'] = $weibo;
        $param['weibo']['weibo_data'] = $weibo_data;

        $this->assign($param);
        return $this->fetch('display');
    }
}