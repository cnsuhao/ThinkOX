<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-14
 * Time: AM10:59
 */

namespace Admin\Controller;

use Think\Db;
use OT\Database;

class UpdateController extends AdminController
{
    protected $pack_db_path = 'QuickPacks/db.json';
    protected $pack_sql_dir = 'QuickPacks/sqls';

    public function update()
    {


        $this->success('升级成功。');
    }

    /*OneWX二次开发*/
    private function read_file($filename)
    {
        $db = '';
        if (!$file = fopen($filename, "r")) {
            $db = array();
        } else {
            //整读文件
            while (!feof($file)) {
                $db .= fgets($file);
            }
            fclose($file);
        }
        return $db;
    }

    public function quick()
    {
        $db = $this->read_file($this->pack_db_path);
        $db = json_decode($db);
        $db = $this->toArray($db);
        foreach ($db['packs'] as &$pack) {
            $file = $this->pack_sql_dir . '/' . $pack['title'] . '.sql';
            $pack['mtime'] = date('Y-m-d H:i:s', filemtime($file));
            $pack['size'] = filesize($file) . ' bytes';
        }
        unset($pack);
        $this->assign('db', $db);
        $title = '快捷操作'; //渲染模板
        $this->assign('meta_title', $title);
        $this->display();
    }

    public function view($title = '')
    {
        if (IS_POST) {
            if ($title == '') {
                exit;
            }
            exit($this->read_file($this->pack_sql_dir . "/{$title}.sql"));
        }
    }

    public function del_pack()
    {
        $title = trim($_GET['title']);
        if ($_GET['title']) {
            $myfile = $this->pack_sql_dir . "/{$title}.sql";
            if (file_exists($myfile)) {
                $db = $this->toArray(json_decode($this->read_file($this->pack_db_path)));
                foreach ($db['packs'] as $k => $pack) {
                    if ($pack['title'] === $title) {
                        unset($db['packs'][$k]);
                        $db_str = json_encode($db);
                        // 写入内容
                        //打开文件
                        if (!$fh = fopen($this->pack_db_path, 'w')) {
                            $this->error("不能创建文件 $this->pack_db_path");
                            exit;
                        }
                        if (fwrite($fh, $db_str) === FALSE) {
                            $this->error("不能写入到文件 $this->pack_db_path");
                            exit;
                        }

                        $result = unlink($myfile);

                        if ($result) {
                            $this->success('删除文件成功。');
                            exit;
                        }
                    }

                }

            } else {
                $this->error('删除失败。文件不存在。');
                exit;
            }


        } else {
            $this->error('未选择补丁。');
        }


    }

    /**json转换为数组
     * @param $stdclassobject
     * @return mixed
     */
    function toArray($stdclassobject)
    {

        $_array = is_object($stdclassobject) ? get_object_vars($stdclassobject) : $stdclassobject;

        foreach ($_array as $key => $value) {
            $value = (is_array($value) || is_object($value)) ? $this->toArray($value) : $value;
            $array[$key] = $value;
        }

        return $array;

    }

    /**
     * 新增补丁
     * @author 奕潇 <yixiao2020@qq.com>
     */
    public function addpack($title_old = '', $title = '', $sql = '', $des = '', $auth = '')
    {

        if (IS_POST) {
            if ($sql == '') {
                $this->error('必须填写Sql语句。');
            }
            $db = $this->toArray(json_decode($this->read_file($this->pack_db_path)));
            if ($title == '')
                $title = time();
            $pack['title'] = $title;

            //打开文件
            if (!$fh = fopen($this->pack_sql_dir . '/' . $title . '.sql', 'w')) {
                $this->error("不能创建文件 $this->pack_db_path");
                exit;
            }
            // 写入内容
            if (fwrite($fh, $sql) === FALSE) {
                $this->error("不能写入到文件 $this->pack_db_path");
                exit;
            }

            $pack['sql'] = $sql;
            $pack['des'] = $des;
            $pack['auth'] = $auth;
            if (trim($title_old) != '') {
                foreach ($db['packs'] as $key => $pack_t) {
                    if ($pack_t['title'] == $title_old) {
                        $db['packs'][$key] = $pack;
                    }
                }
            } else {
                $db['packs'][] = $pack;
            }

            if ($auth != '') {
                $db['auth'] = $auth; //更新作者资料
            }
            $db = json_encode($db);


            // 确定文件存在并且可写
            if (file_exists($this->pack_db_path))
                if (is_writable($this->pack_db_path)) {
                    //打开文件
                    if (!$fh = fopen($this->pack_db_path, 'w')) {
                        $this->error("不能打开文件 $this->pack_db_path");
                        exit;
                    }
                    // 写入内容
                    if (fwrite($fh, $db) === FALSE) {
                        $this->error("不能写入到文件 $this->pack_db_path");
                        exit;
                    }
                    fclose($fh);
                    if (trim($title_old != '')) {
                        $this->success("修改补丁成功。");
                    } else {
                        $this->success("新增补丁成功。");
                    }


                } else {
                    $this->error("文件 $this->pack_db_path 不可写");
                }
            else {
                //打开文件
                // $this->success($db);exit;
                if (!$fh = fopen($this->pack_db_path, 'w')) {
                    $this->error("不能创建文件 $this->pack_db_path");
                    exit;
                }
                // 写入内容
                if (fwrite($fh, $db) === FALSE) {
                    $this->error("不能写入到文件 $this->pack_db_path");
                    exit;
                }
                fclose($fh);
                $this->success("新增补丁成功。");
                exit;
            }
        } else {
            $db = $this->read_file($this->pack_db_path);
            $db = $this->toArray(json_decode($db));
            foreach ($db['packs'] as $key => $pack) {
                if ($pack['title'] == trim($title)) {
                    $this->assign('pack', $pack);

                    break;
                }
            }

            $this->meta_title = '新增补丁';
            $this->assign('db', $db);
            $this->display('addpack');
        }
    }

    public function use_pack($title = '')
    {
        if (IS_GET && $title != '') {


            //  $db = new Database(array('', $this->pack_sql_dir . "/{$title}.sql"), array(), 'import');
            $error = D('')->executeSqlFile($this->pack_sql_dir . "/{$title}.sql");
            //dump($error);exit;
            // $start = $db->import(0);
            /* if (!$error) {
                 $this->error('使用补丁出错。');
                 exit;
             }*/

            $this->success('使用补丁成功。');
        } else {
            $this->error('请选择补丁。');
        }
    }
    /*OneWX二次开发end*/


}