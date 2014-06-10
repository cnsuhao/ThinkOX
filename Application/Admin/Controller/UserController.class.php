<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Admin\Controller;
use Admin\Builder\AdminConfigBuilder;
use Admin\Builder\AdminListBuilder;
use Admin\Builder\AdminSortBuilder;
use User\Api\UserApi;

/**
 * 后台用户控制器
 * @author 麦当苗儿 <zuojiazi@vip.qq.com>
 */
class UserController extends AdminController {

    /**
     * 用户管理首页
     * @author 麦当苗儿 <zuojiazi@vip.qq.com>
     */
    public function index(){
        $nickname       =   I('nickname');
        $map['status']  =   array('egt',0);
        if(is_numeric($nickname)){
            $map['uid|nickname']=   array(intval($nickname),array('like','%'.$nickname.'%'),'_multi'=>true);
        }else{
            $map['nickname']    =   array('like', '%'.(string)$nickname.'%');
        }

        $list   = $this->lists('Member', $map);
        int_to_string($list);
        $this->assign('_list', $list);
        $this->meta_title = '用户信息';
        $this->display();
    }

    /**扩展用户信息分组列表
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function profile(){
        $map['status']  =   array('egt',0);
        $profileList=D('profile_group')->where($map)->order("sort asc")->select();
        $builder=new AdminListBuilder();
        $builder->title("扩展信息分组列表");
        $builder->meta_title = '扩展信息分组';
        $builder->buttonNew(U('editProfile',array('id'=>'0')))->buttonDelete(U('changeProfileStatus',array('status'=>'-1')))->setStatusUrl(U('changeProfileStatus'))->buttonSort(U('sortProfile'));
        $builder->keyId()->keyText('profile_name',"分组名称")->keyText('sort','排序')->keyTime("createTime","创建时间");
        $builder->keyStatus()->keyDoAction('User/field?id=###','管理字段')->keyDoAction('User/editProfile?id=###','编辑');
        $builder->data($profileList);
        $builder->display();
    }

    /**扩展分组排序
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function sortProfile(){
        $map['status']  =   array('egt',0);
        $list=D('profile_group')->where($map)->order("sort asc")->select();
        foreach($list as $key=>$val){
            $list[$key]['title']=$val['profile_name'];
        }
        $builder=new AdminSortBuilder();
        $builder->meta_title = '分组排序';
        $builder->data($list);
        $builder->buttonSubmit(U('doSortProfile'))->buttonBack();
        $builder->display();
    }

    /**扩展分组排序实现
     * @param $ids
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function doSortProfile($ids) {
        $builder = new AdminSortBuilder();
        $builder->doSort('Profile_group', $ids);
    }

    /**扩展字段列表
     * @param $id
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function field($id){
        $profile=D('profile_group')->where('id='.$id)->find();
        $map['status']  =   array('egt',0);
        $map['profile_group_id']=$id;
        $field_list=D('field_setting')->where($map)->order("sort asc")->select();
        $builder=new AdminListBuilder();
        $builder->title('【'.$profile['profile_name'].'】 字段管理');
        $builder->meta_title =$profile['profile_name'].'字段管理';
        $builder->buttonNew(U('editFieldSetting',array('id'=>'0','profile_group_id'=>$id)))->buttonDelete(U('setFieldSettingStatus',array('status'=>'-1')))->setStatusUrl(U('setFieldSettingStatus'))->buttonSort(U('sortField',array('id'=>$id)))->button('返回',array('href'=>U('profile')));
        $builder->keyId()->keyText('field_name',"字段名称")->keyBool('visiable','是否公开')->keyBool('required','是否必填')->keyText('sort',"排序")->keyText('form_type','表单类型')->keyText('form_default_value','默认值')->keyText('validation','表单验证方式');
        $builder->keyTime("createTime","创建时间")->keyStatus()->keyDoAction('User/editFieldSetting?profile_group_id='.$id.'&id=###','编辑');
        $builder->data($field_list);
        $builder->display();
    }

    /**分组排序
     * @param $id
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function sortField($id){
        $profile=D('profile_group')->where('id='.$id)->find();
        $map['status']  =   array('egt',0);
        $map['profile_group_id']=$id;
        $list=D('field_setting')->where($map)->order("sort asc")->select();
        foreach($list as $key=>$val){
            $list[$key]['title']=$val['field_name'];
        }
        $builder=new AdminSortBuilder();
        $builder->meta_title = $profile['profile_name'].'字段排序';
        $builder->data($list);
        $builder->buttonSubmit(U('doSortField'))->buttonBack();
        $builder->display();
    }

    /**分组排序实现
     * @param $ids
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function doSortField($ids) {
        $builder = new AdminSortBuilder();
        $builder->doSort('Field_setting', $ids);
    }

    /**添加、编辑字段信息
     * @param $id
     * @param $profile_group_id
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function editFieldSetting($id,$profile_group_id){
        $builder=new AdminConfigBuilder();
        if($id!=0){
            $field_setting=D('field_setting')->where('id='.$id)->find();
            $builder->title("修改字段信息");
            $builder->meta_title = '修改字段信息';
        }else{
            $builder->title("添加字段");
            $builder->meta_title = '新增字段';
            $field_setting['profile_group_id']=$profile_group_id;
        }
        $type_default=array(
            'input'=>'input',
            'radio'=>'radio',
            'checkbox'=>'checkbox',
            'select'=>'select',
            'time'=>'time',
            'textarea'=>'textarea'
        );
        $builder->keyReadOnly("id","标识")->keyReadOnly('profile_group_id','分组id')->keyText('field_name',"字段名称")->keySelect('form_type',"表单类型",'',$type_default)->keyTextArea('form_default_value','默认值',"多个值用'|'分割开")
            ->keyText('validation','表单验证方式')->keyBool('visiable','是否公开')->keyBool('required','是否必填');
        $builder->data($field_setting);
        $builder->buttonSubmit(U('doEditFieldSetting'),$id==0?"添加":"修改")->buttonBack();

        $builder->display();
    }

    /**字段添加、编辑实现
     * @param $id
     * @param $field_name
     * @param $profile_group_id
     * @param $visiable
     * @param $required
     * @param $form_type
     * @param $form_default_value
     * @param $validation
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function doEditFieldSetting($id,$field_name,$profile_group_id,$visiable,$required,$form_type,$form_default_value,$validation){

        $data['field_name']=$field_name;
        $data['profile_group_id']=$profile_group_id;
        $data['visiable']=$visiable;
        $data['required']=$required;
        $data['form_type']=$form_type;
        $data['form_default_value']=$form_default_value;
        $data['validation']=$validation;
        if($id!=''){
            $res=D('field_setting')->where('id='.$id)->save($data);
        }else{
            $map['field_name']=$field_name;
            $map['status']=array('egt',0);
            $map['profile_group_id']=$profile_group_id;
            if(D('field_setting')->where($map)->count()>0){
                $this->error('该分组下已经有同名字段，请使用其他名称！');
            }
            $data['status']=1;
            $data['createTime']=time();
            $data['sort']=0;
            $res=D('field_setting')->add($data);
        }
        if($res){
            $this->success($id==''?"添加字段成功":"编辑字段成功",U('field',array('id'=>$profile_group_id)));
        }else{
            $this->error($id==''?"添加字段失败":"编辑字段失败");
        }
    }

    /**设置字段状态：删除=-1，禁用=0，启用=1
     * @param $ids
     * @param $status
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function setFieldSettingStatus($ids, $status) {
        $builder = new AdminListBuilder();
        $builder->doSetStatus('field_setting', $ids, $status);
    }

    /**设置分组状态：删除=-1，禁用=0，启用=1
     * @param $status
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function changeProfileStatus($status){
        $id = array_unique((array)I('ids',0));
        if ( $id[0]==0 ) {
            $this->error('请选择要操作的数据!');
        }
        $id=is_array($id)?$id:explode(',',$id);
        D('profile_group')->where(array('id'=>array('in',$id)))->setField('status',$status);
        if($status==-1){
            $this->success('删除成功');
        }else if($status==0){
            $this->success('禁用成功');
        }else{
            $this->success('启用成功');
        }

    }

    /**添加、编辑分组信息
     * @param $id
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function editProfile($id){
        $builder=new AdminConfigBuilder();
        if($id!=0){
            $profile=D('profile_group')->where('id='.$id)->find();
            $builder->title("修改分组信息");
            $builder->meta_title = '修改分组信息';
        }else{
            $builder->title("添加扩展信息分组");
            $builder->meta_title = '新增分组';
        }
        $builder->keyReadOnly("id","标识")->keyText('profile_name','分组名称');
        $builder->data($profile);
        $builder->buttonSubmit(U('doEditProfile'),$id==0?"添加":"修改")->buttonBack();
        $builder->display();
    }

    /**添加、编辑分组信息实现
     * @param $id
     * @param $profile_name
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function doEditProfile($id,$profile_name){


        $data['profile_name']=$profile_name;
        if($id!=''){
            $res=D('profile_group')->where('id='.$id)->save($data);
        }else{
            $map['profile_name']=$profile_name;
            $map['status']=array('egt',0);
            if(D('profile_group')->where($map)->count()>0){
                   $this->error('已经有同名分组，请使用其他分组名称！');
            }
            $data['status']=1;
            $data['createTime']=time();
            $res=D('profile_group')->add($data);
        }
        if($res){
            $this->success($id==''?"添加分组成功":"编辑分组成功",U('profile'));
        }else{
            $this->error($id==''?"添加分组失败":"编辑分组失败");
        }
    }

    /**
     * 修改昵称初始化
     * @author huajie <banhuajie@163.com>
     */
    public function updateNickname(){
        $nickname = M('Member')->getFieldByUid(UID, 'nickname');
        $this->assign('nickname', $nickname);
        $this->meta_title = '修改昵称';
        $this->display();
    }

    /**
     * 修改昵称提交
     * @author huajie <banhuajie@163.com>
     */
    public function submitNickname(){
        //获取参数
        $nickname = I('post.nickname');
        $password = I('post.password');
        empty($nickname) && $this->error('请输入昵称');
        empty($password) && $this->error('请输入密码');

        //密码验证
        $User   =   new UserApi();
        $uid    =   $User->login(UID, $password, 4);
        ($uid == -2) && $this->error('密码不正确');

        $Member =   D('Member');
        $data   =   $Member->create(array('nickname'=>$nickname));
        if(!$data){
            $this->error($Member->getError());
        }

        $res = $Member->where(array('uid'=>$uid))->save($data);

        if($res){
            $user               =   session('user_auth');
            $user['username']   =   $data['nickname'];
            session('user_auth', $user);
            session('user_auth_sign', data_auth_sign($user));
            $this->success('修改昵称成功！');
        }else{
            $this->error('修改昵称失败！');
        }
    }

    /**
     * 修改密码初始化
     * @author huajie <banhuajie@163.com>
     */
    public function updatePassword(){
        $this->meta_title = '修改密码';
        $this->display();
    }

    /**
     * 修改密码提交
     * @author huajie <banhuajie@163.com>
     */
    public function submitPassword(){
        //获取参数
        $password   =   I('post.old');
        empty($password) && $this->error('请输入原密码');
        $data['password'] = I('post.password');
        empty($data['password']) && $this->error('请输入新密码');
        $repassword = I('post.repassword');
        empty($repassword) && $this->error('请输入确认密码');

        if($data['password'] !== $repassword){
            $this->error('您输入的新密码与确认密码不一致');
        }

        $Api    =   new UserApi();
        $res    =   $Api->updateInfo(UID, $password, $data);
        if($res['status']){
            $this->success('修改密码成功！');
        }else{
            $this->error($res['info']);
        }
    }

    /**
     * 用户行为列表
     * @author huajie <banhuajie@163.com>
     */
    public function action(){
        //获取列表数据
        $Action =   M('Action')->where(array('status'=>array('gt',-1)));
        $list   =   $this->lists($Action);
        int_to_string($list);
        // 记录当前列表页的cookie
        Cookie('__forward__',$_SERVER['REQUEST_URI']);

        $this->assign('_list', $list);
        $this->meta_title = '用户行为';
        $this->display();
    }

    /**
     * 新增行为
     * @author huajie <banhuajie@163.com>
     */
    public function addAction(){
        $this->meta_title = '新增行为';
        $this->assign('data',null);
        $this->display('editaction');
    }

    /**
     * 编辑行为
     * @author huajie <banhuajie@163.com>
     */
    public function editAction(){
        $id = I('get.id');
        empty($id) && $this->error('参数不能为空！');
        $data = M('Action')->field(true)->find($id);

        $this->assign('data',$data);
        $this->meta_title = '编辑行为';
        $this->display();
    }

    /**
     * 更新行为
     * @author huajie <banhuajie@163.com>
     */
    public function saveAction(){
        $res = D('Action')->update();
        if(!$res){
            $this->error(D('Action')->getError());
        }else{
            $this->success($res['id']?'更新成功！':'新增成功！', Cookie('__forward__'));
        }
    }

    /**
     * 会员状态修改
     * @author 朱亚杰 <zhuyajie@topthink.net>
     */
    public function changeStatus($method=null){
        $id = array_unique((array)I('id',0));
        if( in_array(C('USER_ADMINISTRATOR'), $id)){
            $this->error("不允许对超级管理员执行该操作!");
        }
        $id = is_array($id) ? implode(',',$id) : $id;
        if ( empty($id) ) {
            $this->error('请选择要操作的数据!');
        }
        $map['uid'] =   array('in',$id);
        switch ( strtolower($method) ){
            case 'forbiduser':
                $this->forbid('Member', $map );
                break;
            case 'resumeuser':
                $this->resume('Member', $map );
                break;
            case 'deleteuser':
                $this->delete('Member', $map );
                break;
            default:
                $this->error('参数非法');
        }
    }

    public function add($username = '', $password = '', $repassword = '', $email = ''){
        if(IS_POST){
            /* 检测密码 */
            if($password != $repassword){
                $this->error('密码和重复密码不一致！');
            }

            /* 调用注册接口注册用户 */
            $User   =   new UserApi;
            $uid    =   $User->register($username, $password, $email);
            if(0 < $uid){ //注册成功
                $user = array('uid' => $uid, 'nickname' => $username, 'status' => 1);
                if(!M('Member')->add($user)){
                    $this->error('用户添加失败！');
                } else {
                    $this->success('用户添加成功！',U('index'));
                }
            } else { //注册失败，显示错误信息
                $this->error($this->showRegError($uid));
            }
        } else {
            $this->meta_title = '新增用户';
            $this->display();
        }
    }

    /**
     * 获取用户注册错误信息
     * @param  integer $code 错误编码
     * @return string        错误信息
     */
    private function showRegError($code = 0){
        switch ($code) {
            case -1:  $error = '用户名长度必须在16个字符以内！'; break;
            case -2:  $error = '用户名被禁止注册！'; break;
            case -3:  $error = '用户名被占用！'; break;
            case -4:  $error = '密码长度必须在6-30个字符之间！'; break;
            case -5:  $error = '邮箱格式不正确！'; break;
            case -6:  $error = '邮箱长度必须在1-32个字符之间！'; break;
            case -7:  $error = '邮箱被禁止注册！'; break;
            case -8:  $error = '邮箱被占用！'; break;
            case -9:  $error = '手机格式不正确！'; break;
            case -10: $error = '手机被禁止注册！'; break;
            case -11: $error = '手机号被占用！'; break;
            case -12:$error='用户名必须以中文或字母开始，只能包含拼音数字，字母，汉字！';break;
            default:  $error = '未知错误';
        }
        return $error;
    }

}
