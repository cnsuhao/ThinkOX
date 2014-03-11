<?php

function callApi($apiName, $args=array()) {
    //
    $paths = explode('/', $apiName);
    $controllerName = "Api\\Controller\\$paths[0]Controller";
    $controller = new $controllerName();
    $controller->setInternalCallApi();
    $function = $paths[1];
    $method = new ReflectionMethod($controllerName, $function);
    try {
        $method->invokeArgs($controller, $args);
    } catch(Api\Exception\ReturnException $ex) {
        return $ex->getResult();
    }
}

function apiToAjax($result) {
    $result['status'] = $result['success'];
    $result['info'] = $result['message'];
    unset($result['success']);
    unset($result['message']);
    return $result;
}