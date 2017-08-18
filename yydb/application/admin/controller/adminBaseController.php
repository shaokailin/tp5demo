<?php
/**
 * Created by PhpStorm.
 * User: hsPlan
 * Date: 2017/8/2
 * Time: 下午2:42
 */

namespace app\admin\controller;


use app\admin\model\Admin;
use think\Controller;
use think\Request;
use think\Session;

class adminBaseController extends Controller
{
    public function __construct(Request $request = null)
    {
        parent::__construct($request);
        $userId = Session::get('user_id');
        if (!empty($userId)){
            $user = Admin::get($userId);;
            if ($user)
                Request::instance()->bind('user',$user);
            return;
        }
        $this->redirect('login/login');
    }
}