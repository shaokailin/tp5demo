<?php

/**
 * Created by PhpStorm.
 * User: hsPlan
 * Date: 2017/8/2
 * Time: 下午2:51
 */
namespace app\admin\model;
use think\Model;

class Admin extends Model
{
    public function checkLogin($account,$password) {
        $user = $this->field('userid,name')->where(['account_num'=> $account, 'password' => md5($password)])->find();
        return $user;
    }
}