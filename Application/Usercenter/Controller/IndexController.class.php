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
        $uid=isset($_GET['uid'])?op_t($_GET['uid']):is_login();
        //调用API获取基本信息
        $this->userInfo($uid);

        $this->_fans_and_following($uid);

    }

    public function index($uid = null,$page=1,$count=10)
    {


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
        $content = D(ucfirst($type).'/'.$className)->profileContent($uid,$page,$count);
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


    public function appList ($uid=null,$page=1,$count=10) {

        $appArr=$this->_tab_menu();

        $type = op_t($_GET['type']);
        if (! isset ( $appArr [$type] )) {
            $this->error ( '参数出错！！' );
        }
        $this->assign('type', $type);
        $className = ucfirst($type).'Protocol';
        $content = D(ucfirst($type).'/'.$className)->profileContent($uid,$page,$count);
        if (empty($content)) {
            $content = '暂无内容';
        }else{
            $totalCount=D(ucfirst($type).'/'.$className)->getTotalCount($uid);
            $this->assign('totalCount',$totalCount);
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


    public function _fans_and_following($uid=null){
        $uid=isset($uid)?$uid:is_login();
        //我的粉丝展示
        $map['follow_who'] = $uid;
        $fans_default = D('Follow')->where($map)->field('who_follow')->order('create_time desc')->limit(8)->select();
        $fans_totalCount = D('Follow')->where($map)->count();
        foreach ($fans_default as &$user) {
            $user['user'] = query_user(array('avatar64', 'uid', 'nickname', 'fans', 'following', 'weibocount', 'space_url','title'), $user['who_follow']);
        }
        unset($user);
        $this->assign('fans_totalCount',$fans_totalCount);
        $this->assign('fans_default',$fans_default);

        //我关注的展示
        $map_follow['who_follow'] = $uid;
        $follow_default = D('Follow')->where($map_follow)->field('follow_who')->order('create_time desc')->limit(8)->select();
        $follow_totalCount = D('Follow')->where($map_follow)->count();
        foreach ($follow_default as &$user) {
            $user['user'] = query_user(array('avatar64', 'uid', 'nickname', 'fans', 'following', 'weibocount', 'space_url','title'), $user['follow_who']);
        }
        unset($user);
        $this->assign('follow_totalCount',$follow_totalCount);
        $this->assign('follow_default',$follow_default);
        dump($fans_default);
    }

    public function fans($uid=null,$page = 1)
    {
        $uid=isset($uid)?$uid:is_login();
        //调用API获取基本信息
        $this->userInfo($uid);
        $this->_tab_menu();


        $this->assign('tab', 'fans');
        $fans = D('Follow')->getFans($uid, $page, array('avatar128', 'uid', 'nickname', 'fans', 'following', 'weibocount', 'space_url','title'),$totalCount);
        $this->assign('fans', $fans);
        $this->assign('totalCount',$totalCount);
        $this->display();
    }

    public function following($uid=null,$page=1)
    {
        $uid=isset($uid)?$uid:is_login();
        //调用API获取基本信息
        $this->userInfo($uid);
        $this->_tab_menu();

        $following = D('Follow')->getFollowing($uid, $page, array('avatar128', 'uid', 'nickname', 'fans', 'following', 'weibocount', 'space_url','title'),$totalCount);
        $this->assign('following',$following);
        $this->assign('totalCount',$totalCount);
        $this->assign('tab', 'following');
        $this->display();
    }
} 