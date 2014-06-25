<?php
/**
 * 所属项目 thinkox.
 * 开发者: 陈一枭
 * 创建日期: 6/25/14
 * 创建时间: 9:25 AM
 * 版权所有 想天软件工作室(www.ourstu.com)
 */
header ("Content-type:application/x-javascript; Charset: utf-8");
if(isset($_GET)) {
    $files = explode(",", $_GET['get']);
    $str = '';
    foreach ($files as $key => $val){
        $str .= file_get_contents(str_replace('\\','/',dirname(__FILE__).$val));
    }
    //TODO 对获取到的js进行注释
    $str = preg_replace('#\/\*.*\*\/#isU','',$str);//块注释
    $str = preg_replace('#\/\/[^\n]*#','',$str);//行注释
    $str = str_replace("\t","",$str);//tab
    $str = preg_replace('#\s?(=|>=|\?|:|==|\+|\|\||\+=|>|<|\/|\-|,|\()\s?#','$1',$str);//字符前后多余空格
    $str = str_replace("\t","",$str);//tab
   // $str = str_replace("\r\n","",$str);//回车
   // $str = str_replace("\r","",$str);//换行
   // $str = str_replace("\n","",$str);//换行
    $str = trim($str," ");

    echo $str;
}
