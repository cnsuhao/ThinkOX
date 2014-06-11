<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-11
 * Time: PM1:13
 */

namespace Usercenter\Controller;

use Think\Controller;

class IndexController extends BaseController
{
    public function _initialize(){
        parent::_initialize();

    }
    public function index($uid = null)
    {
        //调用API获取基本信息
        $user = query_user(array('username', 'email', 'mobile', 'last_login_time', 'last_login_ip', 'score', 'reg_time', 'title', 'avatar256','rank_link'), $uid);

        //显示页面
        $this->defaultTabHash('index');
        $this->assign('user', $user);
        $this->assign('call', $this->getCall($uid));
        $this->display('basic');
    }

    /**获取用户扩展信息
     * @param null $uid
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function expandInfo($uid=null){
        $profile_group_list=$this->_profile_group_list();
        if($profile_group_list){
            $info_list=$this->_info_list($profile_group_list[0]['id'],$uid);
            $this->assign('info_list',$info_list);
            $this->assign('profile_group_id',$profile_group_list[0]['id']);
            //dump($info_list);exit;
        }

        $this->assign('profile_group_list',$profile_group_list);
        $this->defaultTabHash('expand-info');
        $this->display();
    }

    /**显示某一扩展分组信息
     * @param null $profile_group_id
     * @param null $uid
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function show_expandInfo($profile_group_id=null,$uid=null){
        $res=D('profile_group')->where(array('id'=>$profile_group_id,'status'=>'1'))->find();
        if(!$res){
            $this->error('信息出错！');
        }
        $profile_group_list=$this->_profile_group_list();
        $info_list=$this->_info_list($profile_group_id,$uid);
        $this->assign('info_list',$info_list);
        $this->assign('profile_group_id',$profile_group_id);
        //dump($info_list);exit;
        $this->assign('profile_group_list',$profile_group_list);
        $this->defaultTabHash('expand-info');
        $this->display('expandinfo');
    }

    /**修改用户扩展信息
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function edit_expandinfo($profile_group_id){

        $field_setting_list=D('field_setting')->where(array('profile_group_id'=>$profile_group_id,'status'=>'1'))->order('sort asc')->select();

        if(!$field_setting_list){
            $this->error('没有要修改的信息！');
        }

        $data=null;
        foreach($field_setting_list as $key=>$val){
            $data[$key]['uid']=is_login();
            $data[$key]['field_id']=$val['id'];
            switch($val['form_type']){
                case 'input':
                    $val['value']=op_t($_POST['expand_'.$val['id']]);
                    if((!$val['value']||$val['value']=='')&&$val['required']==1){
                        $this->error($val['field_name'].'输入框信息不完整！');
                    }
                    $val['submit']=$this->_checkInput($val);
                    if($val['submit']!=null&&$val['submit']['succ']==0){
                        $this->error($val['submit']['msg']);
                    }
                    $data[$key]['field_data']=$val['value'];
                    break;
                case 'radio':
                    $val['value']=op_t($_POST['expand_'.$val['id']]);
                    $data[$key]['field_data']=$val['value'];
                    break;
                case 'checkbox':
                    $val['value']=$_POST['expand_'.$val['id']];
                    if(!is_array($val['value'])&&$val['required']==1){
                        $this->error('请至少选择一个：'.$val['field_name']);
                    }
                    $data[$key]['field_data']=is_array($val['value'])?implode('|',$val['value']):'';
                    break;
                case 'select':
                    $val['value']=op_t($_POST['expand_'.$val['id']]);
                    $data[$key]['field_data']=$val['value'];
                    break;
                case 'time':
                    $val['value']=op_t($_POST['expand_'.$val['id']]);
                    $val['value']=strtotime($val['value']);
                    $data[$key]['field_data']=$val['value'];
                    break;
                case 'textarea':
                    $val['value']=op_t($_POST['expand_'.$val['id']]);
                    if((!$val['value']||$val['value']=='')&&$val['required']==1){
                        $this->error($val['field_name'].'内容不能为空！');
                    }
                    $data[$key]['field_data']=$val['value'];
                    break;
            }
        }
        $map['uid']=is_login();
        foreach($data as $dl){
            $map['field_id']=$dl['field_id'];
            $res=D('field')->where($map)->find();
            if(!$res){
                $dl['createTime']=$dl['changeTime']=time();
                if(!D('field')->add($dl)){
                    $this->error('信息添加时出错！');
                }
            }else{
                $dl['changeTime']=time();
                if(!D('field')->where('id='.$res['id'])->save($dl)){
                    $this->error('信息修改时出错！');
                }
            }
            unset($map['field_id']);
        }
        $this->success('保存成功！');
    }

    /**input类型验证
     * @param $data
     * @return mixed
     * @author 郑钟良<zzl@ourstu.com>
     */
    function _checkInput($data){
        switch($data['child_form_type']){
            case 'string':
                $validation=$this->_getValidation($data['validation']);
                if(($validation['min']!=0&&strlen($data['value'])<$validation['min'])||($validation['max']!=0&&strlen($data['value'])>$validation['max'])){
                    if($validation['max']==0){
                        $validation['max']='';
                    }
                    $info['succ']=0;
                    $info['msg']=$data['field_name']."长度必须在"+$validation['min']+"-"+$validation['max']+"之间";
                }
                break;
            case 'number':
                if(preg_match("/^\d*$/",$data['value'])){
                    $validation=$this->_getValidation($data['validation']);
                    if(($validation['min']!=0&&strlen($data['value'])<$validation['min'])||($validation['max']!=0&&strlen($data['value'])>$validation['max'])){
                        if($validation['max']==0){
                            $validation['max']='';
                        }
                        $info['succ']=0;
                        $info['msg']=$data['field_name']."长度必须在"+$validation['min']+"-"+$validation['max']+"之间，且为数字";
                    }
                }else{
                    $info['succ']=0;
                    $info['msg']=$data['field_name']."必须是数字";
                }
                break;
            case 'email':
                if(!preg_match("/([a-z0-9]*[-_\.]?[a-z0-9]+)*@([a-z0-9]*[-_]?[a-z0-9]+)+[\.][a-z]{2,3}([\.][a-z]{2})?/i",$data['value'])){
                    $info['succ']=0;
                    $info['msg']=$data['field_name']."格式不正确，必需为邮箱格式";
                }
                break;
            case 'phone':
                if(!preg_match("/^\d{11}$/",$data['value'])){
                    $info['succ']=0;
                    $info['msg']=$data['field_name']."格式不正确，必须为手机号码格式";
                }
                break;
        }
        return $info;
    }

    /**处理$validation
     * @param $validation
     * @return mixed
     * @author 郑钟良<zzl@ourstu.com>
     */
    function _getValidation($validation){
        $data['min']=$data['max']=0;
        if($validation!=''){
            $items=explode('&',$validation);
            foreach($items as $val){
                $item=explode('=',$val);
                if($item[0]=='min'&&is_numeric($item[1])&&$item[1]>0){
                    $data['min']=$item[1];
                }
                if($item[0]=='max'&&is_numeric($item[1])&&$item[1]>0){
                    $data['max']=$item[1];
                }
            }
        }
        return $data;
    }

    /**分组下的字段信息及相应内容
     * @param null $id 扩展分组id
     * @param null $uid
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function _info_list($id=null,$uid=null){
        $info_list=null;

        if(isset($uid)&&$uid!=is_login()){
                //查看别人的扩展信息
                $field_setting_list=D('field_setting')->where(array('profile_group_id'=>$id,'status'=>'1','visiable'=>'1'))->order('sort asc')->select();

                if(!$field_setting_list){
                    return null;
                }
                $map['uid']=$uid;
        }else if(is_login()){
            $field_setting_list=D('field_setting')->where(array('profile_group_id'=>$id,'status'=>'1'))->order('sort asc')->select();

            if(!$field_setting_list){
                return null;
            }
            $map['uid']=is_login();

        }else{
            $this->error('请先登录！');
        }
        foreach($field_setting_list as $val){
            $map['field_id']=$val['id'];
            $field=D('field')->where($map)->find();
            $val['field_content']=$field;
            $info_list[$val['id']]=$val;
            unset($map['field_id']);
        }

        return $info_list;
    }


    /**扩展信息分组列表获取
     * @return mixed
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function _profile_group_list(){
        $profile_group_list=D('profile_group')->where('status=1')->order('sort asc')->select();

        return $profile_group_list;
    }

    public function logout()
    {
        //调用退出登录的API
        $result = callApi('Public/logout');
        $this->ensureApiSuccess($result);

        exit(json_encode(array('message' => $result['message'], 'url' => U('Home/Index/index'))));
        //显示页面
        //$this->success($result['message'], U('Home/Index/index'));
    }

    public function changePassword()
    {
        $this->defaultTabHash('change-password');
        $this->display();
    }

    public function doChangePassword($old_password, $new_password)
    {
        //调用接口
        $result = callApi('User/changePassword', array($old_password, $new_password));
        $this->ensureApiSuccess($result);

        //显示成功信息
        $this->success($result['message']);
    }

    public function changeSignature()
    {
        $this->defaultTabHash('change-signature');
        $this->display();
    }

    public function doChangeSignature($signature)
    {
        //调用接口
        $result = callApi('User/setProfile', array('signature' => $signature));
        $this->ensureApiSuccess($result);

        //显示成功信息
        $this->success($result['message']);
    }

    public function changeEmail()
    {
        $this->defaultTabHash('change-email');
        $this->display();
    }

    public function doChangeEmail($email)
    {
        //调用API
        $result = callApi('User/setProfile', array(null, $email));
        $this->ensureApiSuccess($result);

        //显示成功信息
        $this->success($result['message']);
    }

    public function unbindMobile()
    {
        //确认用户已经绑定手机
        $profile = callApi('User/getProfile');
        if (!$profile['mobile']) {
            $this->error('您尚未绑定手机', U('UserCenter/Index/index'));
        }

        //发送验证码到已经绑定的手机上
        $result = callApi('Public/sendSms');
        $this->ensureApiSuccess($result);

        //显示页面
        $this->defaultTabHash('index');
        $this->display();
    }

    public function doUnbindMobile($verify)
    {
        //调用解绑手机的API
        $result = callApi('User/unbindMobile', array($verify));
        if (!$result['success']) {
            $this->error($result['message']);
        }
        //显示成功消息
        $this->success($result['message'], U('UserCenter/Index/index'));
    }

    public function bindMobile()
    {
        //显示页面
        $this->defaultTabHash('index');
        $this->display();
    }

    public function doBindMobile($mobile)
    {
        //调用API发送手机验证码
        $result = callApi('Public/sendSms', array($mobile));
        $this->ensureApiSuccess($result);

        //显示成功消息
        $this->success($result['message']);
    }

    public function doBindMobile2($verify)
    {
        //调用API绑定手机
        $result = callApi('User/bindMobile', array($verify));
        $this->ensureApiSuccess($result);

        //显示成功消息
        $this->success($result['message'], U('UserCenter/Index/index'));
    }

    public function unbookmark($favorite_id)
    {
        //调用API取消收藏
        $result = callApi('User/deleteFavorite', array($favorite_id));
        $this->ensureApiSuccess($result);

        //返回结果
        $this->success($result['message']);
    }

    public function changeAvatar()
    {
        $this->defaultTabHash('change-avatar');
        $this->display();
    }

    public function doCropAvatar($crop)
    {
        //调用上传头像接口改变用户的头像
        $result = callApi('User/applyAvatar', array($crop));
        $this->ensureApiSuccess($result);

        //显示成功消息
        $this->success($result['message']);
    }

    public function doUploadAvatar()
    {
        //调用上传头像接口
        $result = callApi('User/uploadTempAvatar');
        $this->ensureApiSuccess($result);

        //显示成功消息
        $this->iframeReturn(apiToAjax($result));
    }

    private function iframeReturn($result) {
        $json = json_encode($result);
        $json = htmlspecialchars($json);
        $html = "<textarea data-type=\"application/json\">$json</textarea>";
        echo $html;
        exit;
    }

    public function fans($page = 1)
    {

        $this->assign('tab', 'fans');
        $fans = D('Follow')->getFans(is_login(), $page, array('avatar128', 'id', 'username', 'fans', 'following', 'weibocount', 'space_url','title'),$totalCount);
        $this->assign('fans', $fans);
        $this->assign('totalCount',$totalCount);
        $this->display();
    }

    public function following($page=1)
    {
        $following = D('Follow')->getFollowing(is_login(), $page, array('avatar128', 'id', 'username', 'fans', 'following', 'weibocount', 'space_url','title'),$totalCount);
        $this->assign('following',$following);
        $this->assign('totalCount',$totalCount);
        $this->assign('tab', 'following');
        $this->display();
    }
}