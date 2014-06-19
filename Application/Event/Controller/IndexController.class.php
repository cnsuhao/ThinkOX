<?php


namespace Event\Controller;

use Think\Controller;


class IndexController extends Controller
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {
        $tree = D('EventType')->where(array('status' => 1))->select();
        $this->assign('tree', $tree);
    }

    public function index($page = 1, $type_id = 0)
    {
        $type_id = intval($type_id);
        if ($type_id != 0) {
            $map['type_id'] = $type_id;
        }
        $map['status'] = 1;
        $content = D('Event')->where($map)->order('create_time desc')->page($page, 16)->select();
        $totalCount = D('Event')->where($map)->count();
        foreach ($content as &$v) {
            $v['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar128', 'rank_html'), $v['uid']);
            $v['type'] = $this->getType($v['type_id']);;

        }
        unset($v);
        $this->assign('type_id', $type_id);
        $this->assign('contents', $content);
        $this->assign('totalPageCount', $totalCount);
        $this->display();
    }

    private function getType($type_id)
    {
        $type = D('EventType')->where('id=' . $type_id)->find();
        return $type;
    }

    public function doPost($id = 0, $cover_id = 0, $title = '', $explain = '', $sTime = '', $eTime = '', $address = '', $limitCount = 0, $deadline = '')
    {
        if (!is_login()) {
            $this->error('请登陆后再投稿。');
        }
        if (!$cover_id) {
            $this->error('请上传封面。');
        }
        if (trim(op_t($title)) == '') {
            $this->error('请输入标题。');
        }
        if (trim(op_h($explain)) == '') {
            $this->error('请输入内容。');
        }
        if (trim(op_h($address)) == '') {
            $this->error('请输入地点。');
        }
        if ($sTime < $deadline) {
            $this->error('报名截止不能大于活动开始时间');
        }
        if ($sTime > $eTime) {
            $this->error('活动开始时间不能大于活动结束时间');
        }
        $content = D('Event')->create();
        $content['explain'] = op_h($content['explain']);
        $content['title'] = op_t($content['title']);
        $content['sTime'] = strtotime($content['sTime']);
        $content['eTime'] = strtotime($content['eTime']);
        $content['deadline'] = strtotime($content['deadline']);
        if ($id) {
            $content_temp = D('Event')->find($id);
            if (!is_administrator(is_login())) { //不是管理员则进行检测
                if ($content_temp['uid'] != is_login()) {
                    $this->error('小样儿，可别学坏。别以为改一下页面元素就能越权操作。');
                }
            }
            $content['uid'] = $content_temp['uid']; //权限矫正，防止被改为管理员
            $rs = D('Event')->save($content);
            if ($rs) {
                $this->success('编辑成功。', U('detail', array('id' => $content['id'])));
            } else {
                $this->success('编辑失败。', '');
            }
        } else {
            if (C('NEED_VERIFY') && !is_administrator()) //需要审核且不是管理员
            {
                $content['status'] = 0;
                $tip = '但需管理员审核通过后才会显示在列表中，请耐心等待。';
                $user = query_user(array('username', 'nickname'), is_login());
                D('Common/Message')->sendMessage(C('USER_ADMINISTRATOR'), "{$user['nickname']}发布了一个活动，请到后台审核。", $title = '活动发布提醒', U('Admin/Event/verify'), is_login(), 2);
            }
            $rs = D('Event')->add($content);
            if ($rs) {
                $this->success('发布成功。' . $tip, U('index'));
            } else {
                $this->success('发布失败。', '');
            }
        }
    }

    public function detail($id = 0)
    {

        $check_isSign = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $id))->select();

        $this->assign('check_isSign', $check_isSign);

        $event_content = D('Event')->find($id);
        if (!$event_content) {
            $this->error('404 not found');
        }
        D('Event')->where(array('id' => $id))->setInc('view_count');
        $event_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $event_content['uid']);

        $menber = D('event_attend')->where(array('event_id' => $id, 'status' => 1))->select();
        foreach ($menber as $k => $v) {
            $event_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $v['uid']);

        }

        $this->assign('content', $event_content);
        $this->display();
    }

    public function member($id = 0, $tip = 'all')
    {
        if ($tip == 'sign') {
            $map['status'] = 0;
        }
        if ($tip == 'attend') {
            $map['status'] = 1;
        }
        $check_isSign = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $id))->select();
        $this->assign('check_isSign', $check_isSign);

        $event_content = D('Event')->find($id);
        if (!$event_content) {
            $this->error('404 not found');
        }
        $map['event_id'] = $id;
        $event_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $event_content['uid']);
        $menber = D('event_attend')->where($map)->select();
        foreach ($menber as $k => $v) {
            $event_content['member'][$k] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $v['uid']);
            $event_content['member'][$k]['name'] = $v['name'];
            $event_content['member'][$k]['phone'] = $v['phone'];
            $event_content['member'][$k]['status'] = $v['status'];
        }

        $this->assign('all_count', D('event_attend')->where(array('event_id' => $id))->count());
        $this->assign('sign_count', D('event_attend')->where(array('event_id' => $id, 'status' => 0))->count());
        $this->assign('attend_count', D('event_attend')->where(array('event_id' => $id, 'status' => 1))->count());

        $this->assign('content', $event_content);
        $this->assign('tip', $tip);
        $this->display();
    }


    public function edit($id)
    {
        $event_content = D('Event')->find($id);
        if (!$event_content) {
            $this->error('404 not found');
        }
        if (!is_administrator(is_login())) { //不是管理员则进行检测
            if ($event_content['uid'] != is_login()) {
                $this->error('404 not found');
            }
        }
        $event_content['user'] = query_user(array('id', 'username', 'nickname', 'space_url', 'space_link', 'avatar64', 'rank_html', 'signature'), $event_content['uid']);
        $this->assign('content', $event_content);
        $this->display();
    }


    public function doSign($event_id, $name, $phone)
    {
        if (!is_login()) {
            $this->error('请登陆后再投稿。');
        }
        if (!$event_id) {
            $this->error('参数错误');
        }
        if (trim(op_t($name)) == '') {
            $this->error('请输入姓名。');
        }
        if (trim($phone) == '') {
            $this->error('请输入手机号码。');
        }
        $check = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $event_id))->select();
        $event_content = D('Event')->find($event_id);
  /*      if ($event_content['attentionCount'] + 1 > $event_content['limitCount']) {
            $this->error('超过限制人数，报名失败');
        }*/
        if (time() > $event_content['deadline']) {
            $this->error('报名已经截止');
        }
        if (!$check) {
            $data['uid'] = is_login();
            $data['event_id'] = $event_id;
            $data['name'] = $name;
            $data['phone'] = $phone;
            $data['creat_time'] = time();
            $res = D('event_attend')->add($data);
            if ($res) {
                D('Event')->where(array('id' => $event_id))->setInc('signCount');
                $this->success('报名成功。', 'refresh');
            } else {
                $this->error('报名失败。', '');
            }
        } else {
            $this->error('您已经报过名了。', '');
        }
    }

    public function shenhe($uid, $event_id, $tip)
    {
        $event_content = D('Event')->find($event_id);
        if ($event_content['uid'] == is_login()) {
            $res = D('event_attend')->where(array('uid' => $uid, 'event_id' => $event_id))->setField('status', $tip);
            if($tip){
                D('Event')->where(array('id' => $event_id))->setInc('attentionCount');
            }else{
                D('Event')->where(array('id' => $event_id))->setDec('attentionCount');
            }
            if ($res) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败！');
            }
        } else {
            $this->error('操作失败，非活动发起者操作！');
        }
    }

    public function unSign($event_id){
        $check = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $event_id))->find();

        $res = D('event_attend')->where(array('uid' => is_login(), 'event_id' => $event_id))->delete();
        if($res){
            if($check['status']){
                D('Event')->where(array('id' => $event_id))->setDec('attentionCount');
            }
            D('Event')->where(array('id' => $event_id))->setDec('signCount');
            $this->success('取消报名成功');
        }
        else{
            $this->error('操作失败');
        }
    }
}