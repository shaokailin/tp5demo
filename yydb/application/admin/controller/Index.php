<?php
namespace app\admin\controller;

use think\Request;
class Index extends adminBaseController
{
    public function __construct(Request $request = null)
    {
        parent::__construct($request);
    }

    public function index()
    {
        $user_roleid = $this->request->user->roleid;

        $user_funcs_Arr = db('admin_function')->where("roleid",'like',"%$user_roleid%")->order('superid')->select();
        $tree = $this->sortTree($user_funcs_Arr);
        $this->assign('count',count($tree));
        $this->assign('funcsArray',$tree);
        return $this->fetch();
    }

    private function sortTree($data,$id='id',$pid='superid',$son='children')
    {
        if (isset($data)) {
            $tree = array();
            $tempMap = array();
            foreach ($data as $item) {
                $tempMap[$item[$id]] = $item;
            }
            foreach ($data as $item) {
                if (isset($tempMap[$item[$pid]])) {
                    $tempMap[$item[$pid]][$son][] = &$tempMap[$item[$id]];
                } else {
                    $tree[] = &$tempMap[$item[$id]];
                }
            }
            unset($tempMap);
            return $tree;
        }
    }
}
