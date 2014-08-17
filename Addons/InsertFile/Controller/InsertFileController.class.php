<?php
namespace Addons\InsertFile\Controller;

use Home\Controller\AddonsController;

class InsertFileController extends AddonsController
{
	//上传附件
	public function UpLoadFile(){
		$picname = $_FILES['attach']['name'];//文件名
		$pictype = pathinfo($picname,PATHINFO_EXTENSION);//文件类型
		$return  = array('status' => 1, 'name' => '', 'type' => '', 'pid' => '');
		/* 调用文件上传组件上传文件 */
		$File = D('File');
		$file_driver = C('DOWNLOAD_UPLOAD_DRIVER');
		
		/* 文件上传相关配置 */
		$DOWNLOAD_UPLOAD = array(
				'mimes'    => '', //允许上传的文件MiMe类型
				'maxSize'  => 5*1024*1024, //上传的文件大小限制 (0-不做限制)
				'exts'     => 'jpg,gif,png,jpeg,zip,rar,tar,gz,7z,doc,docx,txt,xml,xls', //允许上传的文件后缀
				'autoSub'  => true, //自动子目录保存文件
				'subName'  => array('date', 'Y-m-d'), //子目录创建方式，[0]-函数名，[1]-参数，多个参数使用数组
				'rootPath' => './Uploads/Download/', //保存根路径
				'savePath' => '', //保存路径
				'saveName' => array('uniqid', ''), //上传文件命名规则，[0]-函数名，[1]-参数，多个参数使用数组
				'saveExt'  => '', //文件保存后缀，空则使用原后缀
				'replace'  => false, //存在同名是否覆盖
				'hash'     => true, //是否生成hash编码
				'callback' => false, //检测文件是否存在回调函数，如果存在返回文件信息数组
		); //下载模型上传配置（文件上传类配置）
		
		$info = $File->upload($_FILES,$DOWNLOAD_UPLOAD,C('DOWNLOAD_UPLOAD_DRIVER'),C("UPLOAD_{$file_driver}_CONFIG"));
		/* 记录附件信息 */
		if($info){
			$_SESSION['Upload_File_ID'] = $info['attach'];
			$return['pid']  = $info['attach']['id'];
			$return['name'] = $info['attach']['name'];
			$return['type'] = $info['attach']['ext'];
		} else {
			$return['status'] = 0;
			$return['info']   = $File->getError();
		}
		echo json_encode($return);
	}
	
	//删除附件
	public function delFile(){
		$id = I('post.id');
		$File = D('File')->find($id);
		if($File){
	    	/* 删除文件*/
	    	@unlink('Uploads/Download/'.$File['savepath'].$File['savename']);
	    	if(D('File')->delete($id)){//删除保留数据
	    		echo 1;
	    	}else{
	    		echo 0;
	    	}
		}else{
			echo 0;
		}
	}
	
	//下载附件
	public function download(){
		$id = I('get.id');
		$File = D('File');
		$file_data = $File->field('rootPath')->find($id);
		$setting = C('DOWNLOAD_UPLOAD');
		return $File->download($setting['rootPath'].$file_data['savepath'],$id);
	}	
}

