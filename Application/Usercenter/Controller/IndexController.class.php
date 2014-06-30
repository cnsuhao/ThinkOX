<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 14-6-27
 * Time: 下午1:54
 * @author 郑钟良<zzl@ourstu.com>
 */

namespace Usercenter\Controller;


use Think\Controller;

class IndexController extends BaseController{

    public function _initialize(){
        parent::_initialize();
    }

    public function index($uid = null,$page=1)
    {
        //调用API获取基本信息
        $this->userInfo($uid);

        $appArr=$this->_tab_menu();
        foreach($appArr as $key=>$val){
            $type=$key;
            break;
        }
        if (! isset ( $appArr [$type] )) {
            $this->error ( '参数出错！！' );
        }
        $this->assign('type', $type);
        $className = ucfirst($type).'Protocol';
        $content = D(ucfirst($type).'/'.$className)->profileContent($uid,$page);
        if (empty($content)) {
            $content = '暂无内容';
        }else{
            $totalCount=D(ucfirst($type).'/'.$className)->getTotalCount($uid);
            $this->assign('totalCount',$totalCount);
        }
        $this->assign('content', $content);
        $this->display();
    }

    private function userInfo($uid=null)
    {
        $user_info = query_user(array('avatar128', 'nickname', 'uid', 'space_url', 'icons_html', 'score', 'title', 'fans', 'following', 'weibocount', 'rank_link','signature'),$uid);
        $this->assign('user_info', $user_info);
        return $user_info;
    }


    public function appList ($uid=null) {
        //调用API获取基本信息
        $this->userInfo($uid);

        $appArr=$this->_tab_menu();

        $type = op_t($_GET['type']);
        if (! isset ( $appArr [$type] )) {
            $this->error ( '参数出错！！' );
        }
        $this->assign('type', $type);
        $className = ucfirst($type).'Protocol';
        $content = D(ucfirst($type).'/'.$className)->profileContent($uid);
        if (empty($content)) {
            $content = '暂无内容';
        }
        $this->assign('content', $content);
        $this->display('index');
    }

    /**
     * 个人主页标签导航
     * @return void
     */
    public function _tab_menu () {
        // 取全部APP信息
        $map['status'] = 1;
        $dir = APP_PATH;
        $appList=null;
        if (is_dir($dir))
        {
            if ($dh = opendir($dir))
            {
                while (($file = readdir($dh)) !== false)
                {
                    $appList[]['app_name']= $file;
                }
                closedir($dh);
            }
        }
        // 获取APP的HASH数组
        foreach ($appList as $app) {
            $appName = strtolower($app['app_name']);
            $className = ucfirst($appName);
            $dao = D($className.'/'.$className.'Protocol');
            if (method_exists($dao, 'profileContent')) {
                $appArr [$appName] = D($className.'/'.$className.'Protocol')->getModel_CN_Name();
            }
            unset ( $dao );
        }
        $this->assign ( 'appArr', $appArr );

        return $appArr;
    }
} 