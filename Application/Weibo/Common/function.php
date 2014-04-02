<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 4/2/14
 * Time: 2:46 PM
 */

function parse_weibo_content($content){
    $content = parse_expression($content);
    return $content;
}

function parse_comment_content($content) {
    $content = parse_expression($content);
    return $content;
}

function parse_expression($content) {
    return preg_replace_callback("/(\[.+?\])/is",'parse_expression_callback',$content);
}

function parse_expression_callback($data) {
    if(preg_match("/#.+#/i",$data[0])) {
        return $data[0];
    }
    $allexpression = D('Weibo/Expression')->getAllExpression();
    $info = $allexpression[$data[0]];
    if($info) {
        return preg_replace("/\[.+?\]/i","<img src='".__ROOT__."/Public/static/image/expression/miniblog/".$info['filename']."' />",$data[0]);
    }else {
        return $data[0];
    }
}