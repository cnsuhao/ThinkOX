<?php
/**
 * Created by PhpStorm.
 * User: caipeichao
 * Date: 4/2/14
 * Time: 11:59 AM
 */

namespace Common\Exception;
use Think\Exception;

class ApiException extends Exception {
    public function __construct($message, $code) {
        parent::__construct($message, $code);
    }
}