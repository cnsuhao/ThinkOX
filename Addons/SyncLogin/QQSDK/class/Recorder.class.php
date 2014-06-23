<?php
/* PHP SDK
 * @version 2.0.0
 * @author connect@qq.com
 * @copyright © 2013, Tencent Corporation. All rights reserved.
 */

require_once(CLASS_PATH."ErrorCase.class.php");
class Recorder{
    private static $data;
    private $inc;
    private $error;

    public function __construct(){
        $this->error = new ErrorCase();
        //-------读取配置文件
        $incFileContents = file(ROOT."comm/inc.php");
        $incFileContents = $incFileContents[1];
        $this->inc = json_decode($incFileContents);
        $config =  D('addons')->where(array('name'=>'SyncLogin'))->find();
        $config   =   json_decode($config['config'], true);
        $this->inc->appid = $config['QQKEY'];
        $this->inc->appkey = $config['QQSecret'];
        //  $this->inc->callback = getRootUrl().'/index.php?s=/Home/Addons/execute/_addons/SyncLogin/_controller/QQ/_action/qqlogin.html';
        $this->inc->callback = ' http://oxqq.ourstu.com/index.php?s=/Home/User/qqlogin.html';
        if(empty($this->inc)){
            $this->error->showError("20001");
        }

        if(empty($_SESSION['QC_userData'])){
            self::$data = array();
        }else{
            self::$data = $_SESSION['QC_userData'];
        }
    }

    public function write($name,$value){
        self::$data[$name] = $value;
    }

    public function read($name){
        if(empty(self::$data[$name])){
            return null;
        }else{
            return self::$data[$name];
        }
    }

    public function readInc($name){
        if(empty($this->inc->$name)){
            return null;
        }else{
            return $this->inc->$name;
        }
    }

    public function delete($name){
        unset(self::$data[$name]);
    }

    function __destruct(){
        $_SESSION['QC_userData'] = self::$data;
    }
}
