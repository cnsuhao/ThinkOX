<?php


namespace Issue\Controller;

use Think\Controller;


class IndexController extends Controller
{
    /**
     * 业务逻辑都放在 WeiboApi 中
     * @var
     */
    public function _initialize()
    {
        $tree = D('Issue')->getTree();
        $this->assign('tree', $tree);
    }

    public function index($page=1,$issue_id=0)
    {
        $issue=D('Issue')->find($issue_id);
        if(!$issue_id==0){
            $issue_id=intval($issue_id);
            $issues=D('Issue')->where('id='.$issue_id.' OR pid='.$issue_id)->limit(999)->select();
            $ids=array();
            foreach($issues as $v)
            {
                $ids[]=$v['id'];
            }
            $map['issue_id']=array('in',implode(',',$ids));
        }
        $map['status']=1;
        $content=D('IssueContent')->where($map)->order('create_time desc')->page($page,16)->select();
        $totalCount=D('IssueContent')->where($map)->count();
        foreach($content as &$v){
            $v['user']=query_user(array('id','username','space_url','space_link','avatar128','rank_html'),$v['uid']);
        }
        unset($v);
        $this->assign('contents',$content);
        $this->assign('totalPageCount',$totalCount);
        $this->assign('top_issue',$issue['pid']==0?$issue['id']:$issue['pid']);

        $this->display();
    }

    public function doPost($cover_id = 0, $title = '', $content = '', $issue_id = 0)
    {
        if (!$cover_id) {
            $this->error('请上传封面。');
        }
        if (trim(op_t($title)) == '') {
            $this->error('请输入标题。');
        }
        if (trim(op_h($content)) == '') {
            $this->error('请输入内容。');
        }
        if ($issue_id == 0) {
            $this->error('请选择分类。');
        }
        $content = D('IssueContent')->create();
        $rs = D('IssueContent')->add($content);
        if ($rs) {
            $this->success('投稿成功。', 'refresh');
        } else {
            $this->success('投稿失败。', '');
        }

    }

    public function selectDropdown($pid)
    {
        $issues = D('Issue')->where(array('pid' => $pid, 'status' => 1))->limit(999)->select();
        exit(json_encode($issues));


    }
}