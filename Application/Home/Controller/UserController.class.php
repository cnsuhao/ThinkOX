<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.onethink.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: 麦当苗儿 <zuojiazi@vip.qq.com> <http://www.zjzit.cn>
// +----------------------------------------------------------------------

namespace Home\Controller;

use User\Api\UserApi;

/**
 * 用户控制器
 * 包括用户中心，用户登录及注册
 */
class UserController extends HomeController
{

    /* 用户中心首页 */
    public function index()
    {

    }

    /* 注册页面 */
    public function register($username = '', $password = '', $repassword = '', $email = '', $verify = '')
    {

        if (!C('USER_ALLOW_REGISTER')) {
            $this->error('注册已关闭');
        }
        if (IS_POST) { //注册用户
            /* 检测验证码 */
            if (C('VERIFY_OPEN') == 1 or C('VERIFY_OPEN') == 2) {
                if (!check_verify($verify)) {
                    $this->error('验证码输入错误11');
                }
            }
            /**@茉莉清茶57143976@qq.com
             * 检测系统禁止用户名
             */
            $limit_username = explode(',', C('USER_NAME_BAOLIU'));
            foreach ($limit_username as $k => $v) {
                if (stristr($username, $v)) {
                    $this->error("包含系统禁止注册的词汇:" . $v);
                    return false;
                }
            }
            /* 检测密码 */
            if ($password != $repassword) {
                $this->error('密码和重复密码不一致！');
            }
            /**@茉莉清茶57143976@qq.com
             * 同IP注册时间限制
             */
            if (C('USER_REG_TIME')) { //注册时间限制
                /* 调用注册接口注册用户 */
                $User = new UserApi;
                $regip = get_client_ip(1);
                $reg_limrt = C('USER_REG_TIME') * 60;
                $users = $User->infos($regip);
                $check_time = time() - $users;
                $ch_time = $check_time - $reg_limrt;
                $cq_time = ceil(($reg_limrt - $check_time) / 60);
                if ($ch_time < 0) {
                    $this->error(("先休息一下,请" . $cq_time . "分钟后再来注册！"));
                    return false;
                }
            }

            $uid = $User->register($username, $password, $email);
            if (0 < $uid) { //注册成功
                //TODO: 发送注册成功邮件
                send_mail($email, C('WEB_SITE') . "注册成功", "尊敬的《" . $username . "》你好：<br/>您已在" . C('WEB_SITE') . "成功注册，您的用户名为：" . $username . "  您的密码为:" . $password . "<br/>" . C('MAIL_USER_REG') . "<br/><p style='text-align:right;'>" . C('WEB_SITE') . "系统自动发送--请勿直接回复<br/>" . date('Y-m-d H:i:s', TIME()) . "</p>");
                $this->success('成功注册,正在转入登录页面！', U('login'));
            } else { //注册失败，显示错误信息
                $this->error($this->showRegError($uid));
            }

        } else { //显示注册表单
            if (is_login()) {
                redirect(U('Weibo/Index/index'));
            }
            $this->display();
        }
    }

    /* 登录页面 */
    public function login($username = '', $password = '', $verify = '')
    {
        if (IS_POST) { //登录验证
            /* 检测验证码 */
            if (C('VERIFY_OPEN') == 1 or C('VERIFY_OPEN') == 3) {
                if (!check_verify($verify)) {
                    $this->error('验证码输入错误12');
                }
            }

            /* 调用UC登录接口登录 */
            $user = new UserApi;
            $uid = $user->login($username, $password);
            if (0 < $uid) { //UC登录成功
                /* 登录用户 */
                $Member = D('Member');
                if ($Member->login($uid)) { //登录用户
                    //TODO:跳转到登录前页面
                    $this->success('登录成功！', U('Home/Index/index'));
                } else {
                    $this->error($Member->getError());
                }

            } else { //登录失败
                switch ($uid) {
                    case -1:
                        $error = '用户不存在或被禁用！';
                        break; //系统级别禁用
                    case -2:
                        $error = '密码错误！';
                        break;
                    default:
                        $error = '未知错误27！';
                        break; // 0-接口参数错误（调试阶段使用）
                }
                $this->error($error);
            }

        } else { //显示登录表单
            if (is_login()) {
                redirect(U('Weibo/Index/index'));
            }
            $this->display();
        }
    }

    /* 退出登录 */
    public function logout()
    {
        if (is_login()) {
            D('Member')->logout();
            $this->success('退出成功！', U('User/login'));
        } else {
            $this->redirect('User/login');
        }
    }

    /* 验证码，用于登录和注册 */
    public function verify()
    {
        $verify = new \Think\Verify();
        $verify->entry(1);
    }

    /* 用户密码找回首页 */
    public function mi($username = '', $email = '', $verify = '')
    {
        if (IS_POST) { //登录验证
            /* 检测验证码 */
            if (C('VERIFY_OPEN')) {
                if (!check_verify($verify)) {
                    $this->error('验证码输入错误13');
                }
            }
            /* 调用UC登录接口 */
            $user = new UserApi;
            $uids = $user->lomi($username, $email);
            if (0 < $uids['id']) { //UC登录成功
                //TODO: 发送密码找回邮件
                $urls = think_ucenter_md5($uids['id'] . "+" . $uids['last_login_time'], UC_AUTH_KEY);
                $urlss = 'http://' . $_SERVER['HTTP_HOST'] . U('Home/User/reset?uid=' . $uids['id'] . '&activation=' . $urls);
                $urlsss = C('USER_RESPASS') . "<br/>" . $urlss . "<br/>" . C('WEB_SITE') . "系统自动发送--请勿直接回复<br/>" . date('Y-m-d H:i:s', TIME()) . "</p>";

                send_mail($email, C('WEB_SITE') . "密码找回", $urlsss);
                $this->success('密码找回邮件发送成功！', U('User/login'));

            } else { //登录失败
                switch ($uids) {
                    case -1:
                        $error = '用户不存在或被禁用！！！';
                        break; //系统级别禁用
                    case -2:
                        $error = '用户名不存在或和邮箱不符！';
                        break;
                    default:
                        $error = '未知错误28！';
                        break; // 0-接口参数错误（调试阶段使用）
                }
                $this->error($error);
            }
        } else {
            if (is_login()) {
                redirect(U('Weibo/Index/index'));
            }
            $this->display();
        }
    }

    /**
     * 重置密码
     */
    public function reset()
    {

        if (IS_POST) {
            //获取参数
            $uid = I('post.uid');
            $repassword = I('post.repassword');
            $data['password'] = I('post.password');
            empty($uid) && $this->error('参数有误14');
            empty($data['password']) && $this->error('请输入新密码15');
            empty($repassword) && $this->error('请输入确认密码16');

            if ($data['password'] !== $repassword) {
                $this->error('您输入的新密码与确认密码不一致17');
            }

            $Api = new UserApi();
            $ress = $Api->updateInfos($uid, $data);
            if ($ress['status']) {
                $this->success('重置密码成功！', U('User/login'));
            } else {
                $this->error($ress['info']);
            }
        } else {
            if (is_login()) {
                redirect(U('Weibo/Index/index'));
            }
            //检测链接合法性
            $uts = I('get.uid');
            $ats = I('get.activation');
            if (!$uts || !$ats) {
                $this->error('地址有误不能为空18', U('User/login'));
            }
            /* 调用UC登录接口 */
            $user = new UserApi;
            $uidss = $user->reset($uts);
            if ($ats != think_ucenter_md5($uidss['id'] . "+" . $uidss['last_login_time'], UC_AUTH_KEY)) {
                $this->error('地址无效错误参数19', U('User/login'));
            }
            $this->display();
        }
    }

    /**
     * 获取用户注册错误信息
     * @param  integer $code 错误编码
     * @return string        错误信息
     */
    private function showRegError($code = 0)
    {
        switch ($code) {
            case -1:
                $error = '用户名长度必须在16个字符以内！';
                break;
            case -2:
                $error = '用户名被禁止注册！';
                break;
            case -3:
                $error = '用户名被占用！';
                break;
            case -4:
                $error = '密码长度必须在6-30个字符之间！';
                break;
            case -5:
                $error = '邮箱格式不正确！';
                break;
            case -6:
                $error = '邮箱长度必须在1-32个字符之间！';
                break;
            case -7:
                $error = '邮箱被禁止注册！';
                break;
            case -8:
                $error = '邮箱被占用！';
                break;
            case -9:
                $error = '手机格式不正确！';
                break;
            case -10:
                $error = '手机被禁止注册！';
                break;
            case -11:
                $error = '手机号被占用！';
                break;
            default:
                $error = '未知错误24';
        }
        return $error;
    }


    /**
     * 修改密码提交
     * @author huajie <banhuajie@163.com>
     */
    public function profile()
    {
        if (!is_login()) {
            $this->error('您还没有登陆', U('User/login'));
        }
        if (IS_POST) {
            //获取参数
            $uid = is_login();
            $password = I('post.old');
            $repassword = I('post.repassword');
            $data['password'] = I('post.password');
            empty($password) && $this->error('请输入原密码');
            empty($data['password']) && $this->error('请输入新密码');
            empty($repassword) && $this->error('请输入确认密码');

            if ($data['password'] !== $repassword) {
                $this->error('您输入的新密码与确认密码不一致');
            }

            $Api = new UserApi();
            $res = $Api->updateInfo($uid, $password, $data);
            if ($res['status']) {
                $this->success('修改密码成功！');
            } else {
                $this->error($res['info']);
            }
        } else {
            $this->display();
        }
    }

}