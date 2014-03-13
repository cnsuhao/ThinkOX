<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-11
 * Time: PM5:41
 */

namespace Admin\Controller;
use Admin\Builder\AdminListBuilder;
use Admin\Builder\AdminConfigBuilder;
use Admin\Model\AuthGroupModel;

class ForumController extends AdminController {

    public function index() {
        redirect(U('forum'));
    }

    public function forum($page=1) {
        //读取数据
        $map = array('status'=>array('GT',-1));
        $model = M('Forum');
        $list = $model->where($map)->page($page, 10)->select();
        $totalCount = $model->where($map)->count();

        //添加操作
        foreach($list as &$e) {
            //标题
            $forumUrl = U('Forum/post', array('forum_id'=>$e['id']));
            $e['title'] = "<a href=\"{$forumUrl}\">{$e[title]}</a>";

            //添加操作
            $editUrl = U('Forum/editForum', array('id'=>$e['id']));
            $e['DOACTIONS'] = "<a href=\"{$editUrl}\">编辑</a>";
        }

        //显示页面
        $builder = new AdminListBuilder();
        $builder
            ->title('贴吧管理')
            ->buttonNew(U('Forum/editForum'))
            ->keyId()->keyHtml('title', '标题')->keyCreateTime()->keyText('post_count', '帖子数量')->keyStatus()->keyHtml('DOACTIONS', '操作')
            ->data($list)
            ->pagination($totalCount)
            ->display();
    }

    public function editForum($id=null) {
        //判断是否为编辑模式
        $isEdit = $id ? true : false;

        //如果是编辑模式，读取贴吧的属性
        if($isEdit) {
            $forum = M('Forum')->where(array('id'=>$id))->find();
        } else {
            $forum = array('create_time'=>time(), 'post_count'=>0, 'status'=>1);
        }

        //显示页面
        $builder = new AdminConfigBuilder();
        $builder
            ->title($isEdit ? '编辑贴吧' : '新增贴吧')
            ->keyId()->keyTitle()->keyCreateTime()->keyMultiUserGroup('allow_user_group', '允许发帖的用户组')->keyStatus()
            ->data($forum)
            ->buttonSubmit(U('doEditForum'))->buttonBack()
            ->display();
    }

    public function doEditForum($id=null, $title, $create_time, $status, $allow_user_group) {
        //判断是否为编辑模式
        $isEdit = $id ? true : false;

        //生成数据
        $create_time = strtotime($create_time);
        $data = array('title'=>$title, 'create_time'=>$create_time, 'status'=>$status, 'allow_user_group'=>$allow_user_group);

        //写入数据库
        $model = M('Forum');
        if($isEdit) {
            $data['id'] = $id;
            $data = $model->create($data);
            $result = $model->where(array('id'=>$id))->save($data);
            if(!$result) {
                $this->error('编辑失败');
            }
        } else {
            $data = $model->create($data);
            $result = $model->add($data);
            if(!$result) {
                $this->error('创建失败');
            }
        }

        //返回成功信息
        $this->success($isEdit ? '编辑成功' : '保存成功');
    }

    public function post($page=1, $forum_id=null) {
        //读取帖子数据
        $map = array('status'=>array('EGT', 0));
        if($forum_id) $map['forum_id'] = $forum_id;
        $model = M('ForumPost');
        $list = $model->where($map)->order('last_reply_time desc')->page($page,20)->select();
        $totalCount = $model->where($map)->count();

        //添加操作选项
        foreach($list as &$e) {
            $editUrl = U('editPost', array('id'=>$e['id']));
            $e['DOACTIONS'] = "<a href=\"{$editUrl}\">编辑</a>";
        }

        //读取板块基本信息
        if($forum_id) {
            $forum = M('Forum')->where(array('id'=>$forum_id))->find();
            $forumTitle = ' - ' . $forum['title'];
        } else {
            $forumTitle = '';
        }

        //显示页面
        $builder = new AdminListBuilder();
        $builder->title('帖子管理' . $forumTitle)
            ->buttonNew(U('editPost'))
            ->keyId()->keyTitle()->keyCreateTime()->keyUpdateTime()->keyTime('last_reply_time','最后回复时间')->keyHtml('DOACTIONS', '操作')
            ->data($list)
            ->pagination($totalCount, 20)
            ->display();
    }

    public function editPost($id=null) {
        //判断是否在编辑模式
        $isEdit = $id ? true : false;

        //读取帖子内容
        if($isEdit) {
            $post = M('ForumPost')->where(array('id'=>$id))->find();
        } else {
            $post = array();
        }

        //读取贴吧列表
        $forumList = M('Forum')->where(array('status'=>1))->order('id asc')->select();
        $forums = array();
        foreach($forumList as &$e) {
            $forums[$e['id']] = $e['title'];
        }

        //显示页面
        $builder = new AdminConfigBuilder();
        $builder->title($isEdit ? '编辑帖子' : '新建帖子')
            ->keyId()->keyTitle()->keyEditor('content','内容')->keyCreateTime()->keyUpdateTime()->keyTime('last_reply_time','最后回复时间')->keySelect('forum_id','所属贴吧',null,$forums)
            ->buttonSubmit(U('doEditPost'))->buttonBack()
            ->data($post)
            ->display();
    }

    public function doEditPost($id=null,$title,$content,$create_time,$update_time,$last_reply_time) {
        //判断是否为编辑模式
        $isEdit = $id ? true : false;

        //写入数据库
        $model = M('ForumPost');
        $data = array('title'=>$title,'content'=>$content,'create_time'=>$create_time,'update_time'=>$update_time,'last_reply_time'=>$last_reply_time);
        if($isEdit) {
            $result = $model->where(array('id'=>$id))->save($data);
        } else {
            $result = $model->add($data);
        }

        //如果写入不成功，则报错
        if(!$result) {
            $this->error($isEdit ? '编辑失败' : '创建成功');
        }

        //返回成功信息
        $this->success($isEdit ? '编辑成功' : '创建成功');
    }
}
