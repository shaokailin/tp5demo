
var HTTPUtil = {};

const SERVER_URL = "https://toolapi2.d1xz.net/v1/";
const appId = 11;
const TOKEN_ = '28Yojo9YqssouYQucaga7ZHGw12iZplf';
// request_time
HTTPUtil.get = function (api,params){
    let paramsNew = HTTPUtil.editParam(params);
    let signParamString = HTTPUtil.signForGeg(paramsNew);
    let url = encodeURI(SERVER_URL + api + '?' + signParamString);
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
                reject(null);
            }
        }).then((response)=> {
            console.log(response);
            if(response.status == 0) {
                if(response.erroe_code == 10002){

                }else {

                }
                reject(null);
            }else {
                resolve(response.data);
            }

        }).catch((err)=>{

            reject(null);
        })
    }) ;
}

HTTPUtil.post = function(api,params) {
    let paramsNew = HTTPUtil.editParam(params);
    let url = SERVER_URL + HTTPUtil.signForPost(api,paramsNew);
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
    newParams.request_time = Math.floor(new Date().getTime() / 1000.0);
     newParams.app_id = appId;
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
    let content = dataArray.join('').toLocaleLowerCase() + TOKEN_;
    var md5 = require('crypto-js');
    let md5Content = md5.MD5(content);
    var paramString = '';
    for (var index in dataArray) {
        paramString += (dataArray[index] + '&');
    }
    paramString += ('sign='+ md5Content.toString());
    return paramString;
}
/*
* 编辑post的URL参数
* */
HTTPUtil.signForPost = function(api,param) {
    let apiParams = 'app_id='+ param['app_id']+'request_time='+ param['request_time']+TOKEN_;
    var md5 = require('crypto-js');
    let apiParamsMd5 = md5.MD5(apiParams).toString();
    return api+'?request_time='+ param['request_time'] + '&app_id=' + param['app_id'] + '&sign=' + apiParamsMd5;
}

export default HTTPUtil;