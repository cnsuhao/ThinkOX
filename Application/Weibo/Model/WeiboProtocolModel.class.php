<?php
/**
 *
 */

namespace Weibo\Model;

use Think\Model;
use Weibo\Api\WeiboApi;

/**
 * Class WeiboProtocolModel
 * @package Weibo\Model
 * @郑钟良
 */
class WeiboProtocolModel extends Model
{
    private $weiboApi;

    public function _initialize()
    {
        $this->weiboApi = new WeiboApi();
    }
    // 在个人空间里查看该应用的内容列表
    public function profileContent($uid=null) {
        if ($uid != 0) {
            $result = $this->weiboApi->listAllWeibo(null, null, array('uid' => $uid));
        } else {
            $result = $this->weiboApi->listAllWeibo(null, null, array('uid' => is_login()));
        }

        $tpl = APP_PATH.'/weibo/View/default/Index/profile_content.html';
        $view=new \Think\View();
        $view->assign($result);
        $view->assign('loadMoreUrl', U('loadWeibo', array('uid' => $uid)));
        $content='';
        $content=$view->fetch($tpl,$content);
        return $content;
    }
}