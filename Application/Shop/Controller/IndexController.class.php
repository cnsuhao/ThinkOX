<?php


namespace Shop\Controller;

use Think\Controller;


class IndexController extends Controller
{
    public function _goods_initialize(){
        $tree = D('shopCategory')->getTree();
        $this->assign('tree', $tree);
        $tox_money_cname=getToxMoneyName();
        $this->assign('tox_money_cname',$tox_money_cname);
    }

    public function _myGoods_initialize(){
        if(!is_login()){
            $this->error('请先登录！');
        }
        $this->assign('type','my');
        $tox_money_cname=getToxMoneyName();
        $this->assign('tox_money_cname',$tox_money_cname);
    }

    public function index($page = 1, $category_id = 0)
    {
        $this->_goods_initialize();
        $category_id=intval($category_id);
        $goods_category = D('shopCategory')->find($category_id);
        if ($category_id != 0) {
            $category_id = intval($category_id);
            $goods_categorys = D('shop_category')->where("id=%d OR pid=%d",array($category_id,$category_id))->limit(999)->select();
            $ids = array();
            foreach ($goods_categorys as $v) {
                $ids[] = $v['id'];
            }
            $map['category_id'] = array('in', implode(',', $ids));
        }
        $map['status'] = 1;
        $goods_list = D('shop')->where($map)->order('createtime desc')->page($page, 16)->select();
        $totalCount = D('shop')->where($map)->count();
        foreach ($goods_list as &$v) {
            $v['category']=D('shopCategory')->field('id,title')->find($v['category_id']);
        }
        unset($v);
        $this->assign('contents', $goods_list);
        $this->assign('totalPageCount', $totalCount);
        $this->assign('top_category', $goods_category['pid'] == 0 ? $goods_category['id'] : $goods_category['pid']);
        $this->assign('category_id',$category_id);
        $this->display();
    }

    public function goodsDetail($id = 0)
    {
        $this->_goods_initialize();
        $goods = D('shop')->find($id);
        if (!$goods) {
            $this->error('404 not found');
        }
        $category = D('shopCategory')->find($goods['category_id']);
        $this->assign('top_category', $category['pid'] == 0 ? $category['id'] : $category['pid']);
        $this->assign('category_id', $category['id']);
        $this->assign('category_title',$category['title']);
        $this->assign('content', $goods);
        $this->assign('my_tox_money',getMyToxMoney());
        $this->display();
    }
    public function goodsBuy($id=0,$num=1){
        if(!is_login()){
            $this->error('请先登录！');
        }
        $goods=D('shop')->where('id='.$id)->find();
        if($goods){
            //判断商品余量
            if($num>$goods['goods_num']){
                $this->error('商品余量不足');
            }
            $data['goods_id']=$id;
            $data['goods_num']=$num;
            $data['status']=-1;
            $data['uid']=is_login();
            $data['createtime']=time();

            //扣tox_money
            $tox_money_need=$num*$goods['tox_money_need'];
            $my_tox_money=getMyToxMoney();
            if($tox_money_need>$my_tox_money){
                $this->error('你的'.getToxMoneyName().'不足');
            }
            D('member')->where('uid='.is_login())->setDec('tox_money',$tox_money_need);
            $res=D('shop_buy')->add($data);
            if($res){
                D('shop')->where('id='.$id)->setDec('goods_num',$num);
                $this->success('购买成功！花费了'.$tox_money_need.getToxMoneyName(),U('Index/myGoods',array('status'=>-1)));
            }else{
                $this->error('购买失败！');
            }
        }else{
            $this->error('请选择要购买的商品');
        }
    }

    public function myGoods($page = 1,$status=-1){
        $this->_myGoods_initialize();
        $map['status'] = $status;
        $map['uid']=is_login();
        $goods_buy_list=D('shop_buy')->where($map)->page($page,16)->order('createtime desc')->select();
        $totalCount =D('shop_buy')->where($map)->count();
        foreach ($goods_buy_list as &$v) {
            $v['goods']=D('shop')->where('id='.$v['goods_id'])->find();
            $v['category']=D('shopCategory')->field('id,title')->find($v['goods']['category_id']);
        }
        unset($v);
        $this->assign('contents', $goods_buy_list);
        $this->assign('totalPageCount', $totalCount);
        $this->assign('status',$status);
        $this->display();
    }

    public function applyGoods($id=0){
        if(!is_login()){
            $this->error('请先登录！');
        }
        $goods_buy = D('shop_buy')->find($id);
        if (!$goods_buy) {
            $this->error('404 not found');
        }
        $data['applytime']=time();
        $data['status']=0;
        $res=D('shop_buy')->where('id='.$id)->save($data);
        if($res){
            $this->success('申领成功，请等待管理员发货',U('myGoods'));
        }else{
            $this->error('申领失败！');
        }
    }
}