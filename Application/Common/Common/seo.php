<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-27
 * Time: PM3:06
 */

//读取SEO规则
function get_seo_meta() {
    return D('Common/SeoRule')->getMetaOfCurrentPage();
}