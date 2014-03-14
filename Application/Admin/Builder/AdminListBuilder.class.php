<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-12
 * Time: AM10:08
 */

namespace Admin\Builder;

class AdminListBuilder extends AdminBuilder {
    private $_title;
    private $_keyList = array();
    private $_buttonList = array();
    private $_pagination = array();
    private $_data = array();

    public function title($title) {
        $this->_title = $title;
        return $this;
    }

    public function button($title, $attr) {
        $this->_buttonList[] = array('title'=>$title, 'attr'=>$attr);
        return $this;
    }

    public function buttonNew($href, $title='新增', $attr=array()) {
        $attr['href'] = $href;
        return $this->button($title, $attr);
    }

    public function buttonSort($href, $title='排序', $attr=array()) {
        $attr['href'] = $href;
        return $this->button($title, $attr);
    }

    public function key($name, $title, $type, $opt=null) {
        $key = array('name'=>$name, 'title'=>$title, 'type'=>$type, 'opt'=>$opt);
        $this->_keyList[$name] = $key;
        return $this;
    }

    public function keyText($name, $title) {
        return $this->key($name, $title, 'text');
    }

    public function keyHtml($name, $title) {
        return $this->key($name, $title, 'html');
    }

    public function keyMap($name, $title) {
        return $this->key($name, $title, 'map');
    }

    public function keyId($name='id', $title='ID') {
        return $this->keyText($name, $title);
    }

    /**
     * @param $name
     * @param $title
     * @param $getUrl Closure|string
     * 可以是函数或U函数解析的字符串。如果是字符串，该函数将附带一个id参数
     *
     * @return $this
     */
    public function keyLink($name, $title, $getUrl) {
        //如果getUrl是一个字符串，则表示getUrl是一个U函数解析的字符串
        if(is_string($getUrl)) {
            $getUrl = function($item) use($getUrl){
                return U($getUrl, array('id'=>$item['id']));
            };
        }

        //添加key
        return $this->key($name, $title, 'link', $getUrl);
    }

    public function keyStatus($name='status', $title='状态') {
        $map = array(-1=>'删除', 0=>'禁用', 1=>'启用', 2=>'未审核');
        return $this->key($name, $title, 'map', $map);
    }

    public function keyTime($name, $title) {
        return $this->key($name, $title, 'time');
    }

    public function keyCreateTime($name='create_time', $title='创建时间') {
        return $this->keyTime($name, $title);
    }

    public function keyUpdateTime($name='update_time', $title='更新时间') {
        return $this->keyTime($name, $title);
    }

    public function keyUid($name='uid', $title='用户') {
        return $this->key($name, $title, 'uid');
    }

    public function keyTitle($name='title', $title='标题') {
        return $this->keyText($name, $title);
    }

    public function pagination($totalCount, $listRows=10) {
        $this->_pagination = array('totalCount'=>$totalCount, 'listRows'=>$listRows);
        return $this;
    }

    public function data($list) {
        $this->_data = $list;
        return $this;
    }

    public function display() {
        //key类型的等价转换
        //map转换成text
        $this->convertKey('map', 'text', function($value, $key){
            return $key['opt'][$value];
        });

        //uid转换成text
        $this->convertKey('uid', 'text', function($value){
            $value = query_user(array('username','uid'), $value);
            return "[{$value[uid]}]".$value['username'];
        });

        //time转换成text
        $this->convertKey('time', 'text', function($value) {
            return time_format($value);
        });

        //text转换成html
        $this->convertKey('text', 'html', function($value){
            return htmlspecialchars($value);
        });

        //link转换为html
        $this->convertKey('link','html', function($value, $key, $item){
            $value = htmlspecialchars($value);
            $getUrl = $key['opt'];
            $url = $getUrl($item);
            return "<a href=\"$url\">$value</a>";
        });

        //如果html为空
        $this->convertKey('html', 'html', function($value){
            if($value === '') {
                return '<span style="color:#bbb;">（空）</span>';
            }
            return $value;
        });

        //编译buttonList中的属性
        foreach($this->_buttonList as &$button) {
            $button['tag'] = isset($button['attr']['href']) ? 'a' : 'button';
            $this->addDefaultCssClass($button);
            $button['attr'] = $this->compileHtmlAttr($button['attr']);
        }

        //显示页面
        $this->assign('title', $this->_title);
        $this->assign('keyList', $this->_keyList);
        $this->assign('buttonList', $this->_buttonList);
        $this->assign('pagination', $this->_pagination);
        $this->assign('list', $this->_data);
        parent::display('admin_list');
    }

    private function convertKey($from, $to, $convertFunction) {
        foreach($this->_keyList as &$key) {
            if($key['type'] == $from) {
                $key['type'] = $to;
                foreach($this->_data as &$data) {
                    $value = &$data[$key['name']];
                    $value = $convertFunction($value, $key, $data);
                    unset($value);
                }
                unset($data);
            }
        }
        unset($key);
    }

    private function addDefaultCssClass(&$button) {
        if(!isset($button['attr']['class'])){
            $button['attr']['class'] = 'btn';
        } else {
            $button['attr']['class'] .= ' btn';
        }
    }
}