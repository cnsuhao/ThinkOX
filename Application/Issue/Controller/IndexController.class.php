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

    public function doPost($id=0,$cover_id = 0, $title = '', $content = '', $issue_id = 0)
    {

        if(!is_login())
        {
            $this->error('请登陆后再投稿。');
        }
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

        if($id){
            $rs = D('IssueContent')->save($content);
            if ($rs) {
                $this->success('编辑成功。',U('issueContentDetail',array('id'=>$content['id'])));
            } else {
                $this->success('编辑失败。', '');
            }
        }else{
            $rs = D('IssueContent')->add($content);
            if ($rs) {
                $this->success('投稿成功。', 'refresh');
            } else {
                $this->success('投稿失败。', '');
            }
        }



    }
    public function issueContentDetail($id=0){

        $issue_content=D('IssueContent')->find($id);
        if(!$issue_content){
            $this->error('404 not found');
        }
        D('IssueContent')->where(array('id'=>$id))->setInc('view_count');
        $issue=D('Issue')->find($issue_content['issue_id']);

        $this->assign('top_issue',$issue['pid']==0?$issue['id']:$issue['pid']);
        $this->assign('issue_id',$issue['id']);
        $issue_content['user']=query_user(array('id','username','space_url','space_link','avatar64','rank_html','signature'),$issue_content['uid']);
        $this->assign('content',$issue_content);
        $this->display();
    }

    public function selectDropdown($pid)
    {
        $issues = D('Issue')->where(array('pid' => $pid, 'status' => 1))->limit(999)->select();
        exit(json_encode($issues));


    }

    public function edit($id){
        $issue_content=D('IssueContent')->find($id);
        if(!$issue_content){
            $this->error('404 not found');
        }
        $issue=D('Issue')->find($issue_content['issue_id']);

        $this->assign('top_issue',$issue['pid']==0?$issue['id']:$issue['pid']);
        $this->assign('issue_id',$issue['id']);
        $issue_content['user']=query_user(array('id','username','space_url','space_link','avatar64','rank_html','signature'),$issue_content['uid']);
        $this->assign('content',$issue_content);
        $this->display();
    }
}