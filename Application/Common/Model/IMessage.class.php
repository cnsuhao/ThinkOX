<?php
/**
 * 所属项目 OnePlus.
 * 开发者: 想天
 * 创建日期: 3/18/14
 * 创建时间: 8:59 AM
 * 版权所有 想天工作室(www.ourstu.com)
 */

namespace Common\Model;


interface IMessage
{

    public function getData($id, $source_id, $type);

    public function postMessage($source_message, $content, $uid, $type = 'reply');


} 