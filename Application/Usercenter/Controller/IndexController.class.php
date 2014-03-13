<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-11
 * Time: PM1:13
 */

namespace Usercenter\Controller;
use Think\Controller;

class IndexController extends BaseController {
    public function index($uid=null) {
        //调用API获取基本信息
        $user = query_user(array('username','email','mobile','last_login_time','last_login_ip','score','reg_time','title','avatar256'), $uid);

        //显示页面
        $this->defaultTabHash('index');
        $this->assign('user', $user);
        $this->assign('call', $this->getCall($uid));
        $this->display('basic');
    }

    public function logout() {
        //调用退出登录的API
        $result = callApi('Public/logout');
        $this->ensureApiSuccess($result);

        //显示页面
        $this->success($result['message'],U('Home/Index/index'));
    }

    public function changePassword() {
        $this->defaultTabHash('change-password');
        $this->display();
    }

    public function doChangePassword($old_password, $new_password) {
        //调用接口
        $result = callApi('User/changePassword', array($old_password, $new_password));
        $this->ensureApiSuccess($result);

        //显示成功信息
        $this->success($result['message']);
    }

    public function changeSignature() {
        $this->defaultTabHash('change-signature');
        $this->display();
    }

    public function doChangeSignature($signature) {
        //调用接口
        $result = callApi('User/setProfile', array('signature'=>$signature));
        $this->ensureApiSuccess($result);

        //显示成功信息
        $this->success($result['message']);
    }

    public function changeEmail() {
        $this->defaultTabHash('change-email');
        $this->display();
    }

    public function doChangeEmail($email) {
        //调用API
        $result = callApi('User/setProfile', array(null,$email));
        $this->ensureApiSuccess($result);

        //显示成功信息
        $this->success($result['message']);
    }

    public function unbindMobile() {
        //确认用户已经绑定手机
        $profile = callApi('User/getProfile');
        if(!$profile['mobile']) {
            $this->error('您尚未绑定手机', U('UserCenter/Index/index'));
        }

        //发送验证码到已经绑定的手机上
        $result = callApi('Public/sendSms');
        $this->ensureApiSuccess($result);

        //显示页面
        $this->defaultTabHash('index');
        $this->display();
    }

    public function doUnbindMobile($verify) {
        //调用解绑手机的API
        $result = callApi('User/unbindMobile', array($verify));
        if(!$result['success']) {
            $this->error($result['message']);
        }
        //显示成功消息
        $this->success($result['message'], U('UserCenter/Index/index'));
    }

    public function bindMobile() {
        //显示页面
        $this->defaultTabHash('index');
        $this->display();
    }

    public function doBindMobile($mobile) {
        //调用API发送手机验证码
        $result = callApi('Public/sendSms', array($mobile));
        $this->ensureApiSuccess($result);

        //显示成功消息
        $this->success($result['message']);
    }

    public function doBindMobile2($verify) {
        //调用API绑定手机
        $result = callApi('User/bindMobile', array($verify));
        $this->ensureApiSuccess($result);

        //显示成功消息
        $this->success($result['message'],U('UserCenter/Index/index'));
    }

    public function unbookmark($favorite_id) {
        //调用API取消收藏
        $result = callApi('User/deleteFavorite', array($favorite_id));
        $this->ensureApiSuccess($result);

        //返回结果
        $this->success($result['message']);
    }

    public function changeAvatar() {
        $this->defaultTabHash('change-avatar');
        $this->display();
    }

    public function doCropAvatar($crop) {
        //调用上传头像接口改变用户的头像
        $result = callApi('User/applyAvatar', array($crop));
        $this->ensureApiSuccess($result);

        //显示成功消息
        $this->success($result['message']);
    }

    public function doUploadAvatar() {
        //调用上传头像接口
        $result = callApi('User/uploadTempAvatar');
        $this->ensureApiSuccess($result);

        //显示成功消息
        $this->ajaxReturn(apiToAjax($result));
    }
}