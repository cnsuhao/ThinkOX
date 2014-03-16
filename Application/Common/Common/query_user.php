<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-10
 * Time: PM7:40
 */

/**
 * 支持的字段有
 * member表中的所有字段，ucenter_member表中的所有字段
 * 头衔：title
 * 头像：avatar32 avatar64 avatar128 avatar256 avatar512
 * 个人中心地址：space_url
 * 认证图标：icons_html
 *
 * @param $fields
 * @param null $uid
 * @return array|null
 */
function query_user($fields, $uid = null)
{
    //默认获取自己的资料
    $uid = $uid ? $uid : is_login();
    if (!$uid) {
        return null;
    }

    //查询缓存，过滤掉已缓存的字段
    $cachedFields = array();
    $cacheResult = array();
    foreach ($fields as $field) {
        $cache = read_query_user_cache($uid, $field);
        if (!empty($cache)) {
            $cacheResult[$field] = $cache;
            $cachedFields[] = $field;
        }
    }
    //去除已经缓存的字段
    $fields = array_diff($fields, $cachedFields);

    //获取两张用户表格中的所有字段
    $homeModel = M('Member');
    $ucenterModel = M('UcenterMember');
    $homeFields = $homeModel->getDbFields();
    $ucenterFields = $ucenterModel->getDbFields();

    //分析每个表格分别要读取哪些字段
    $avatarFields = array('avatar32', 'avatar64', 'avatar128', 'avatar256', 'avatar512');
    $avatarFields = array_intersect($avatarFields, $fields);
    $homeFields = array_intersect($homeFields, $fields);
    $ucenterFields = array_intersect($ucenterFields, $fields);

    //查询需要的字段
    $homeResult = array();
    $ucenterResult = array();
    if ($homeFields) {
        $homeResult = D('Home/Member')->where(array('uid' => $uid))->field($homeFields)->find();
    }
    if ($ucenterFields) {
        $model = D('User/UcenterMember');
        $ucenterResult = $model->where(array('id' => $uid))->field($ucenterFields)->find();
    }

    //读取头像数据
    $result = array();
    $avatarAddon = new \Addons\Avatar\AvatarAddon();
    foreach ($avatarFields as $e) {
        $avatarSize = intval(substr($e, 6));
        $avatarPath = $avatarAddon->getAvatarPath($uid);
        $avatarUrl = getImageUrlByPath('.' . $avatarPath, $avatarSize);
        $result[$e] = $avatarUrl;
    }

    //读取头衔数据
    if (in_array('title', $fields)) {
        $titleModel = D('Usercenter/Title');
        $title = $titleModel->getTitle($uid);
        $result['title'] = $title;
    }

    //获取个人中心地址
    $spaceUrlResult = array();
    if (in_array('space_url', $fields)) {
        $result['space_url'] = U('UserCenter/Index/index', array('uid' => $uid));
    }

    //获取昵称链接
    $spaceUrlResult = array();
    if (in_array('space_link', $fields)) {
        $result['space_link'] = '<a ucard="' . $uid . '" href="' . U('UserCenter/Index/index', array('uid' => $uid)) . '">' . $ucenterResult['username'] . '</a>';
    }

    //获取用户认证图标
    if (in_array('icons_html', $fields)) {
        //判断是否有手机图标
        $static = C('TMPL_PARSE_STRING.__STATIC__');
        $iconUrls = array();
        $user = query_user(array('mobile'), $uid);
        if ($user['mobile']) {
            $iconUrls[] = "$static/oneplus/images/mobile-bind.png";
        }

        //生成结果
        $result['icons_html'] = '<span class="usercenter-verify-icon-list">';
        foreach ($iconUrls as $e) {
            $result['icons_html'] .= "<img src=\"{$e}\" title=\"对方已绑定手机\"/>";
        }
        $result['icons_html'] .= '</span>';
    }

    //合并结果，不包括缓存
    $result = array_merge($ucenterResult, $homeResult, $spaceUrlResult, $result);

    //写入缓存
    foreach ($result as $field => $value) {
        write_query_user_cache($uid, $field, $value);
    }

    //合并结果，包括缓存
    $result = array_merge($result, $cacheResult);

    //返回结果
    return $result;
}

function read_query_user_cache($uid, $field)
{
    return S("query_user_{$uid}_{$field}");
}

function write_query_user_cache($uid, $field, $value)
{
    return S("query_user_{$uid}_{$field}", $value);
}

function clean_query_user_cache($uid, $field)
{
    if(is_array($field)){
        foreach($field as $field_item){
            S("query_user_{$uid}_{$field_item}", null);
        }
    }
    S("query_user_{$uid}_{$field}", null);
}