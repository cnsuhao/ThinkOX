<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-14
 * Time: PM1:36
 */

namespace Common\Model;

use Think\Model;

class SeoRuleModel extends Model
{
    public function getMetaOfCurrentPage()
    {
        // G('begin');
        //$result = $this->getMeta(MODULE_NAME, CONTROLLER_NAME, ACTION_NAME);
        // G('end');
        // dump(G('begin','end'));exit;
        return null; // $result;
    }

    private function getMeta($module, $controller, $action)
    {
        //获取相关的规则
        $rules = $this->getRelatedRules($module, $controller, $action);

        //按照排序计算最终结果
        $title = '';
        $keywords = '';
        $description = '';
        foreach ($rules as $e) {
            if (!$title && $e['seo_title']) {
                $title = $e['seo_title'];
            }
            if (!$keywords && $e['seo_keywords']) {
                $keywords = $e['seo_keywords'];
            }
            if (!$description && $e['seo_description']) {
                $description = $e['seo_description'];
            }
        }

        //返回结果
        return array('title' => $title, 'keywords' => $keywords, 'description' => $description);
    }

    private function getRelatedRules($module, $controller, $action)
    {
        //防止SQL注入
        $module = mysql_real_escape_string($module);
        $controller = mysql_real_escape_string($controller);
        $action = mysql_real_escape_string($action);

        //查询与当前页面相关的SEO规则
        $map = array();
        $map['_string'] = "(app='' or app='$module') and (controller='' or controller='$controller') and (action='' or action='$action') and status=1";
        $rules = $this->where($map)->order('sort asc')->select();

        //返回规则列表
        return $rules;
    }
}