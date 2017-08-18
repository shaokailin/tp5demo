<?php

function jsonReturnError($code = 0,$message = ''){
    return json_encode(['code' => $code,'msg' => $message]);
}

function jsonReturnSuccess($code = 0,$message='',$data=[]){
    return json_encode(['code' => $code,'msg'=>$message,'data'=>$data]);
}
