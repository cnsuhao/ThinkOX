<?php
/**
 * 所属项目 thinkox.
 * 开发者: 陈一枭
 * 创建日期: 6/25/14
 * 创建时间: 9:30 AM
 * 版权所有 嘉兴想天信息技术有限公司(www.ourstu.com)
 */

//输出CSS
header ("content-type:text/css; charset: utf-8");
if(isset($_GET)) {
    $files = explode(",", $_GET['get']);
    $fc = '';
    foreach ($files as $key => $val){
        $fc .= file_get_contents(str_replace('\\','/',dirname(__FILE__).$val));
    }
/*    $fc = str_replace("\t", "", $fc); //清除空格
    $fc = str_replace("\r\n", "", $fc);
    $fc = str_replace("\n", "", $fc);
    $fc = preg_replace("/\/\*[^\/]*\*\//s", "", $fc);*/
    echo $fc;
}