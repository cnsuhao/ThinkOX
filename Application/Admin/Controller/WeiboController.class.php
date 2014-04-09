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
use Admin\Builder\AdminSortBuilder;

class WeiboController extends AdminController
{
    public function weibo($page = 1, $r = 20)
    {
        //读取微博列表
        $map = array('status' => array('EGT', 0));
        $model = M('Weibo');
        $list = $model->where($map)->page($page, $r)->select();
        foreach ($list as &$li) {
            if (D('WeiboTop')->where(array('weibo_id' => $li['id']))->count()) {
                $li['top'] = '置顶';
            } else {
                $li['top'] = '不置顶';
            }
        }
        unset($li);
        $totalCount = $model->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();


        $attr['class'] = 'btn ajax-post';

        $attr['target-form'] = 'ids';

        $attr1 = $attr;
        $attr1['url'] = $builder->addUrlParam(U('setWeiboTop'), array('top' => 1));
        $attr0 = $attr;
        $attr0['url'] = $builder->addUrlParam(U('setWeiboTop'), array('top' => 0));

        $builder->title('微博管理')
            ->setStatusUrl(U('setWeiboStatus'))->buttonEnable()->buttonDisable()->buttonDelete()->button('置顶', $attr1)->button('取消置顶', $attr0)
            ->keyId()->keyLink('content', '内容', 'comment?weibo_id=###')->keyUid()->keyCreateTime()->keyStatus()->keyDoActionEdit('editWeibo?id=###')->keyText('top', '置顶')
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();


    }

    public function setWeiboTop($ids, $top)
    {
        D('Weibo')->where(array('id' => array('in', implode($ids))))->setField('is_top', $top);
        foreach ($ids as $id) {
            if ($top) {
                D('WeiboTop')->add(array('weibo_id' => $id, 'create_time' => time()));
            } else {
                D('WeiboTop')->where(array('weibo_id' => $id))->delete();
            }

        }

        $this->success('设置成功', $_SERVER['HTTP_REFERER']);
    }

    public function weiboTrash($page = 1, $r = 20)
    {
        //读取微博列表
        $map = array('status' => -1);
        $model = M('Weibo');
        $list = $model->where($map)->page($page, $r)->select();
        $totalCount = $model->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();
        $builder->title('微博回收站')
            ->setStatusUrl(U('setWeiboStatus'))->buttonRestore()
            ->keyId()->keyLink('content', '内容', 'comment?weibo_id=###')->keyUid()->keyCreateTime()
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();
    }

    public function setWeiboStatus($ids, $status)
    {
        $builder = new AdminListBuilder();
        $builder->doSetStatus('Weibo', $ids, $status);
    }

    public function editWeibo($id)
    {
        //读取微博内容
        $weibo = M('Weibo')->where(array('id' => $id))->find();

        //显示页面
        $builder = new AdminConfigBuilder();
        $builder->title('编辑微博')
            ->keyId()->keyTextArea('content', '内容')->keyCreateTime()->keyStatus()
            ->buttonSubmit(U('doEditWeibo'))->buttonBack()
            ->data($weibo)
            ->display();
    }

    public function doEditWeibo($id, $content, $create_time, $status)
    {
        //写入数据库
        $data = array('content' => $content, 'create_time' => $create_time, 'status' => $status);
        $model = M('Weibo');
        $result = $model->where(array('id' => $id))->save($data);
        if (!$result) {
            $this->error('编辑失败');
        }

        //返回成功信息
        $this->success('编辑成功', U('weibo'));
    }

    public function comment($weibo_id = null, $page = 1, $r = 20)
    {
        //读取评论列表
        $map = array('status' => array('EGT', 0));
        if ($weibo_id) $map['weibo_id'] = $weibo_id;
        $model = M('WeiboComment');
        $list = $model->where($map)->order('create_time asc')->page($page, $r)->select();
        $totalCount = $model->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();
        $builder->title('评论管理')
            ->setStatusUrl(U('setCommentStatus'))->buttonEnable()->buttonDisable()->buttonDelete()
            ->keyId()->keyText('content', '内容')->keyUid()->keyCreateTime()->keyStatus()->keyDoActionEdit('editComment')
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();
    }

    public function commentTrash($page = 1, $r = 20)
    {
        //读取评论列表
        $map = array('status' => -1);
        $model = M('WeiboComment');
        $list = $model->where($map)->order('create_time asc')->page($page, $r)->select();
        $totalCount = $model->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();
        $builder->title('评论回收站')
            ->setStatusUrl(U('setCommentStatus'))->buttonRestore()
            ->keyId()->keyText('content', '内容')->keyUid()->keyCreateTime()
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();
    }

    public function setCommentStatus($ids, $status)
    {
        $builder = new AdminListBuilder();
        $builder->doSetStatus('WeiboComment', $ids, $status);
    }

    public function editComment($id)
    {
        //读取评论内容
        $model = M('WeiboComment');
        $comment = $model->where(array('id' => $id))->find();

        //显示页面
        $builder = new AdminConfigBuilder();
        $builder->title('编辑评论')
            ->keyId()->keyTextArea('content', '内容')->keyCreateTime()->keyStatus()
            ->data($comment)
            ->buttonSubmit(U('doEditComment'))->buttonBack()
            ->display();
    }

    public function doEditComment($id, $content, $create_time, $status)
    {
        //写入数据库
        $data = array('content' => $content, 'create_time' => $create_time, 'status' => $status);
        $model = M('WeiboComment');
        $result = $model->where(array('id' => $id))->save($data);
        if (!$result) {
            $this->error('编辑出错');
        }

        //显示成功消息
        $this->success('编辑成功', U('comment'));
    }
}
