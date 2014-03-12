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
            $editUrl = U('Forum/editForum', array('id'=>$e['id']));
            $e['DOACTIONS'] = "<a href=\"{$editUrl}\">编辑</a>";
        }

        //显示页面
        $builder = new AdminListBuilder();
        $builder
            ->title('贴吧管理')
            ->buttonNew(U('Forum/editForum'))
            ->keyId()
            ->keyTitle()
            ->keyCreateTime()
            ->keyText('post_count', '帖子数量')
            ->keyStatus()
            ->keyHtml('DOACTIONS', '操作')
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
            ->keyId()
            ->keyTitle()
            ->keyCreateTime()
            ->keyInteger('post_count', '帖子数量')
            ->keyStatus()
            ->data($forum)
            ->buttonSubmit(U('doEditForum'))
            ->buttonBack()
            ->display();
    }

    public function doEditForum($id=null, $title, $post_count, $create_time, $status) {
        //判断是否为编辑模式
        $isEdit = $id ? true : false;

        //生成数据
        $create_time = strtotime($create_time);
        $data = array('title'=>$title, 'post_count'=>$post_count, 'create_time'=>$create_time, 'status'=>$status);

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
}
