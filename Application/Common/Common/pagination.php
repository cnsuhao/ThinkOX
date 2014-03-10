<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-10
 * Time: PM7:40
 */

function getPagination($totalCount, $countPerPage=10) {
    $pageKey = 'page';
    //获取当前页码
    $currentPage = $_REQUEST[$pageKey] ? $_REQUEST[$pageKey] : 1;
    //计算总页数
    $pageCount = ceil($totalCount / $countPerPage);
    //如果只有1页，就没必要翻页了
    if($pageCount <= 1) {
        return '';
    }
    //定义返回结果
    $html = '';
    //添加头部
    $html .= '<div class="pagination">';
    //添加上一页的按钮
    if($currentPage>1) {
        $prevUrl = addUrlParam(getCurrentUrl(), array($pageKey=>$currentPage-1));
        $html .= "<li><a class=\"\" href=\"{$prevUrl}\">&laquo;</a></li>";
    } else {
        $html .= "<li class=\"disabled\"><a>&laquo;</a></li>";
    }
    //添加各页面按钮
    for($i=1;$i<=$pageCount;$i++){
        $pageUrl = addUrlParam(getCurrentUrl(), array($pageKey=>$i));
        if($i==$currentPage) {
            $html .= "<li class=\"active\"><a class=\"active\" href=\"{$pageUrl}\">{$i}</a></li>";
        } else {
            $html .= "<li><a class=\"\" href=\"{$pageUrl}\">{$i}</a></li>";
        }
    }
    //添加下一页按钮
    if($currentPage < $pageCount) {
        $nextUrl = addUrlParam(getCurrentUrl(), array($pageKey=>$currentPage+1));
        $html .= "<li><a class=\"\" href=\"{$nextUrl}\">&raquo;</a></li>";
    } else {
        $html .= "<li class=\"disabled\"><a>&raquo;</a></li>";
    }
    //收尾
    $html .= '</div>';
    return $html;
}


function addUrlParam($url, $params) {
    //添加一个前缀，然后进行URL解析
    $parse = parse_url('http://localhost'.$url);
    //合并URL参数
    $query = $parse['query'];
    if(!$query) $query = array();
    $query2 = array();
    parse_str($query, $query2);
    $query = $query2;
    $query = array_merge($query,$params);
    //重建QUERY参数
    $query = http_build_query($query);
    //重建URL
    if($query) $query = '?'.$query;
    $fragment = $parse['fragment'] ? '#'.$parse['fragment'] : '';
    $url = $parse['path'].$query.$fragment;
    //返回结果
    return $url;
}

function getCurrentUrl() {
    return $_SERVER['REQUEST_URI'];
}