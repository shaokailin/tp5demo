<?php
/**
 * Created by PhpStorm.
 * User: hsPlan
 * Date: 2017/8/2
 * Time: 下午2:46
 */

namespace app\admin\controller;

use app\admin\model\Admin;
use think\Controller;
use think\Session;

class login extends Controller
{
    function index () {
       return $this->fetch('login');
    }
    public function login () {

        return $this->fetch();
    }
    public function loginCheck (){
        $account = $this->request->param('account','');
        $password = $this->request->param('password','');
        if (empty($account) || empty($password)){
            return jsonReturnError(1002,'请完善信息');
            die();
        }
        $user = new Admin();
        $result = $user->checkLogin($account,$password);
        if ($result){
            Session::set('user_id',$result['userid']);
            Session::set('name',$result['name']);
            return jsonReturnSuccess(1000,'登录成功');
            die();
        }else {
            return jsonReturnError(1001,'账号或者密码错误！');
            die();
        }
    }
}