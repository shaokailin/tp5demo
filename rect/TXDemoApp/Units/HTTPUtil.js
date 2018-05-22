
import md5 from 'react-native-md5';
var HTTPUtil = {};

const SERVER_URL = "https://toolapi.d1xz.net/v2/rili/";
const SERVER_URL_2 = "https://toolapi2.d1xz.net/v1/";
const appId = 13;
const TOKEN_ = '28Yojo9YqssouYQucaga7ZHGw12iZplf';
// request_time
HTTPUtil.get = function (api,params,isServer2){
    let paramsNew = HTTPUtil.editParam(params);
    let signParamString = HTTPUtil.signForGeg(paramsNew);
    let url = (isServer2?SERVER_URL_2:SERVER_URL) + api + '?' + signParamString;
    return new Promise(function(resolve,reject){
        fetch(url,{
            method:'GET',
            headers:{
                'Content-Type':'text/html',
            }
        }).then((response)=>{
            if(response.ok) {
                return response.json();
            }else {
                reject({status:response.status});
            }
        }).then((response)=> {
            resolve(response);
        }).catch((err)=>{
            reject({status:-1});
        })
    }) ;

}

HTTPUtil.post = function(api,params,isServer2) {
    let paramsNew = HTTPUtil.editParam(params);
    let url = (isServer2?SERVER_URL_2:SERVER_URL) + HTTPUtil.signForPost(api,paramsNew);
    return new Promise(function(resolve,reject){
        fetch(url,{
            method:'POST',
        }).then((response)=>{
            if(response.ok) {
                return response.json();
            }else {
                reject({status:response.status});
            }
        }).then((response)=>{
            resolve(response);
        }).catch((err)=>{
            reject({status:-1});
        })
    });
}

/*
* 添加额外的参数
* */
HTTPUtil.editParam = function(params){
    var newParams = params == null ? {}:params;
    newParams.append('request_time',Math.floor(new Date().getTime() / 1000.0));
    newParams.append('app_id',appId);
    return newParams;
}
/*
* 编辑get的参数
* */
HTTPUtil.signForGeg = function(params) {
    var dataArray = new Array();
    for(var key in params) {
        dataArray.push(key + '=' + params[key]);
    }
    dataArray.sort();
    let content = dataArray.join().toLocaleLowerCase() + TOKEN_;
    let md5Content = md5.str_md5(content);
    // params.append('sign',md5Content);

    var paramString = '';
    for (var value in dataArray) {
        paramString += (value + '&');
    }
    paramString += md5Content;
    return paramString;
}
/*
* 编辑post的URL参数
* */
HTTPUtil.signForPost = function(api,param) {
    let apiParams = 'app_id='+ param['app_id']+'request_time='+ param['request_time']+TOKEN_;
    let apiParamsMd5 = md5.str_md5(apiParams);
    return api+'?request_time='+ param['request_time'] + '&app_id=' + param['app_id'] + '&sign=' + apiParamsMd5;
}

export default HTTPUtil;