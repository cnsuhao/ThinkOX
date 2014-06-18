<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 14-6-18
 * Time: 上午10:07
 * @author 郑钟良<zzl@ourstu.com>
 */
namespace Admin\Controller;

use Admin\Builder\AdminConfigBuilder;
use Admin\Builder\AdminListBuilder;
use Admin\Builder\AdminTreeListBuilder;

use Think\Model;

/**
 * Class ShopController
 * @package Admin\controller
 * @郑钟良
 */
class ShopController extends AdminController
{

    protected $shopModel;
    protected $shop_configModel;
    protected $shop_categoryModel;

    function _initialize()
    {
        $this->shopModel = D('Shop/Shop');
        $this->shop_configModel=D('Shop/ShopConfig');
        $this->shop_categoryModel=D('Shop/ShopCategory');
        parent::_initialize();
    }

    /**商品分类
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function shopCategory()
    {
        //显示页面
        $builder = new AdminTreeListBuilder();
        $attr['class'] = 'btn ajax-post';
        $attr['target-form'] = 'ids';

        $tree = $this->shop_categoryModel->getTree(0, 'id,title,sort,pid,status');

        $builder->title('专辑管理')
            ->buttonNew(U('Shop/add'))
            ->data($tree)
            ->display();
    }


    public function add($id = 0, $pid = 0)
    {
        if (IS_POST) {
            if ($id != 0) {
                $category = $this->shop_categoryModel->create();
                if ($this->shop_categoryModel->save($category)) {

                    $this->success('编辑成功。',U('Shop/shopCategory'));
                } else {
                    $this->error('编辑失败。');
                }
            } else {
                $category = $this->shop_categoryModel->create();
                if ($this->shop_categoryModel->add($category)) {

                    $this->success('新增成功。',U('Shop/shopCategory'));
                } else {
                    $this->error('新增失败。');
                }
            }


        } else {
            $builder = new AdminConfigBuilder();
            $categorys = $this->shop_categoryModel->select();
            $opt = array();
            foreach ($categorys as $category) {
                $opt[$category['id']] = $category['title'];
            }
            if ($id != 0) {
                $category = $this->shop_categoryModel->find($id);
            } else {
                $category = array('pid' => $pid, 'status' => 1);
            }


            $builder->title('新增分类')->keyId()->keyText('title', '标题')->keySelect('pid', '父分类', '选择父级分类', array('0' => '顶级分类')+$opt)
                ->keyStatus()->keyCreateTime()->keyUpdateTime()
                ->data($category)
                ->buttonSubmit(U('Shop/add'))->buttonBack()->display();
        }

    }

    public function categoryTrash($page = 1, $r = 20)
    {
        //读取微博列表
        $map = array('status' => -1);
        $list =$this->shop_categoryModel->where($map)->page($page, $r)->select();
        $totalCount = $this->shop_categoryModel->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();
        $builder->title('专辑回收站')
            ->setStatusUrl(U('setStatus'))->buttonRestore()
            ->keyId()->keyText('title', '标题')->keyStatus()->keyCreateTime()
            ->data($list)
            ->pagination($totalCount, $r)
            ->display();
    }



    public function operate($type = 'move', $from = 0)
    {
        $builder = new AdminConfigBuilder();
        $from = D('Issue')->find($from);

        $opt = array();
        $categorys = $this->shop_categoryModel->select();
        foreach ($categorys as $category) {
            $opt[$category['id']] = $category['title'];
        }
        if ($type === 'move') {

            $builder->title('移动分类')->keyId()->keySelect('pid', '父分类', '选择父分类', $opt)->buttonSubmit(U('Shop/add'))->buttonBack()->data($from)->display();
        } else {

            $builder->title('合并分类')->keyId()->keySelect('toid', '合并至的分类', '选择合并至的分类', $opt)->buttonSubmit(U('Shop/doMerge'))->buttonBack()->data($from)->display();
        }

    }

    public function doMerge($id, $toid)
    {
        $effect_count=$this->shopModel->where(array('category_id'=>$id))->setField('category_id',$toid);
        $this->shop_categoryModel->where(array('id'=>$id))->setField('status',-1);
        $this->success('合并分类成功。共影响了'.$effect_count.'个内容。',$this->shop_categoryModel);
        //TODO 实现合并功能 shop_category
    }

    /**
     * 设置商品分类状态：删除=-1，禁用=0，启用=1
     * @param $ids
     * @param $status
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function setStatus($ids, $status){
        $builder = new AdminListBuilder();
        $builder->doSetStatus('shopCategory', $ids, $status);
    }

    /**
     * 设置商品状态：删除=-1，禁用=0，启用=1
     * @param $ids
     * @param $status
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function setGoodsStatus($ids, $status){
        $builder = new AdminListBuilder();
        $builder->doSetStatus('shop', $ids, $status);
    }

    public function goodsList($page=1,$r=20){
        $map['status']=array('egt',0);
        $goodsList=$this->shopModel->where($map)->order('changetime desc')->page($page,$r)->select();
        $totalCount=$this->shopModel->where($map)->count();
        $builder=new AdminListBuilder();
        $builder->title('商品列表');
        $builder->meta_title='商品列表';
        foreach($goodsList as &$val){
            $category=$this->shop_categoryModel->where('id='.$val['id'])->getField('title');
            $val['category']=$category;
            unset($category);
        }

        $builder->buttonNew(U('Shop/goodsEdit'))->buttonDelete(U('setGoodsStatus'))->setStatusUrl(U('setGoodsStatus'));
        $builder->keyId()->keyText('goods_name','商品名称')->keyText('category','商品分类')->keyText('goods_introduct','商品简介')
            ->keyText('tox_money_need','商品价格')->keyText('goods_num','商品余量')->keyStatus('status','出售状态')->keyUpdateTime('changetime')->keyCreateTime('createtime')->keyDoActionEdit('Shop/goodsEdit?id=###')->keyDoAction('Shop/setGoodsStatus?ids=###&status=-1','删除');
        $builder->data($goodsList);
        $builder->pagination($totalCount,$r);
        $builder->display();
    }

    public function goodsTrash($page=1, $r=10){
        //读取微博列表
        $map = array('status' => -1);
        $goodsList=$this->shopModel->where($map)->order('changetime desc')->page($page,$r)->select();
        $totalCount=$this->shopModel->where($map)->count();

        //显示页面
        $builder = new AdminListBuilder();
        $builder->title('商品回收站')
            ->setStatusUrl(U('setGoodsStatus'))->buttonRestore()
            ->keyId()->keyLink('goods_name', '标题','Shop/goodsEdit?id=###')->keyCreateTime()->keyStatus()
            ->data($goodsList)
            ->pagination($totalCount, $r)
            ->display();
    }

    /**
     * @param int $id
     * @param $goods_name
     * @param $goods_ico
     * @param $goods_introduct
     * @param $goods_detail
     * @param $tox_money_need
     * @param $goods_num
     * @param $status
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function goodsEdit($id=0,$goods_name='',$goods_ico='',$goods_introduct='',$goods_detail='',$tox_money_need='',$goods_num='',$status='',$category_id=0){
        $isEdit=$id?1:0;
        if(IS_POST){
            $goods['goods_name']=$goods_name;
            $goods['goods_ico']=$goods_ico;
            $goods['goods_introduct']=$goods_introduct;
            $goods['goods_detail']=$goods_detail;
            $goods['tox_money_need']=$tox_money_need;
            $goods['goods_num']=$goods_num;
            $goods['status']=$status;
            $goods['category_id']=$category_id;
            $goods['changetime']=time();
            if($isEdit){
                $rs=$this->shopModel->where('id='.$id)->save($goods);
            }else{
                $goods['createtime']=time();
                $rs=$this->shopModel->add($goods);
            }
            if($rs){
                $this->success($isEdit?'编辑成功':'添加成功',U('Shop/goodsList'));
            }else{
                $this->error($isEdit?'编辑失败':'添加失败');
            }
        }else{
            $builder=new AdminConfigBuilder();
            $builder->title($isEdit?'编辑商品':'添加商品');
            $builder->meta_title=$isEdit?'编辑商品':'添加商品';

            //获取分类列表
            $category_map['status']=array('egt',0);
            $goods_category_list=$this->shop_categoryModel->where($category_id)->order('pid desc')->select();
            $options=array_combine(array_column($goods_category_list,'id'),array_column($goods_category_list,'title'));
            $builder->keyId()->keyText('goods_name','商品名称')->keySingleImage('goods_ico','商品图标')->keySelect('category_id','商品分类','',$options)->keyText('goods_introduct','商品简介')->keyTextArea('goods_detail','商品详情')
                ->keyInteger('tox_money_need','商品价格')->keyInteger('goods_num','商品余量')->keyStatus('status','出售状态');
            if($isEdit){
                $goods=$this->shopModel->where('id='.$id)->find();
                $builder->data($goods);
                $builder->buttonSubmit(U('Shop/goodsEdit'));
                $builder->buttonBack();
                $builder->display();
            }else{
                $goods['status']=1;
                $builder->buttonSubmit(U('Shop/goodsEdit'));
                $builder->buttonBack();
                $builder->data($goods);
                $builder->display();
            }
        }
    }


    /**tox_money中文名称配置
     * @param int $id
     * @param string $cname
     * @author 郑钟良<zzl@ourstu.com>
     */
    public function toxMoneyConfig($id=0,$cname=''){
        if(IS_POST){
            if($cname==''){
                $this->error('中文名称不能为空');
            }
            $id=$id?$id:$this->shop_configModel->where('ename='."'tox_money'")->getField('id');
            $data['cname']=$cname;
            $data['changetime']=time();
            $rs=$this->shop_configModel->where('id='.$id)->save($data);
            if($rs){
                $this->success('保存成功');
            }else{
                $this->error('保存失败');
            }
        }else{
            $toxmoney=$this->shop_configModel->where('ename='."'tox_money'")->find();
            $builder=new AdminConfigBuilder();
            $builder->title('tox_money名称配置');
            $builder->meta_title='tox_money名称配置';
            $builder->keyId()->keyReadOnly('ename','标识')->keyText('cname','中文名称');
            $builder->data($toxmoney);
            $builder->buttonSubmit(U('Shop/toxMoneyConfig'),'保存');
            $builder->display();
        }
    }

}
