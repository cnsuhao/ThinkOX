<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 14-3-11
 * Time: PM5:41
 */

namespace Admin\Controller;

class ForumController extends AdminController {

    public function index() {
        redirect(U('forum'));
    }

    public function forum($page) {
        
    }
}
