<?php

namespace Addons\InsertImage;
use Common\Controller\Addon;

/**
 * 插入图片插件
 * @author 想天软件工作室
 */

    class InsertImageAddon extends Addon{

        public $info = array(
            'name'=>'InsertImage',
            'title'=>'插入图片',
            'description'=>'微博上传图片',
            'status'=>1,
            'author'=>'想天软件工作室',
            'version'=>'0.1'
        );

        public function install(){
            return true;
        }

        public function uninstall(){
            return true;
        }

        //实现的InsertImage钩子方法
        public function InsertImage($param){
$this->display('insertImage');
        }

    }