var HTTPUtil = {};

const SERVER_URL = "https://toolapi.d1xz.net/v2/rili/";
const SERVER_URL_2 = "https://toolapi2.d1xz.net/v1/";
const appId = 13;
// request_time
HTTPUtil.get = function (api,params,isServer2){
    let url = (isServer2?SERVER_URL_2:SERVER_URL) + api;
    let paramsNew = HTTPUtil.editParam(params);


}
HTTPUtil.editParam = function(params){
    var newParams = params == null ? {}:params;
    newParams.append(request_time,new Date().getTime());
    newParams.append(app_id,appId);
    return newParams;
}

/**
 * 基于 fetch 封装的 GET请求
 * @param url
 * @param params {}
 * @param headers
 * @returns {Promise}
 */
HTTPUtil.get = function(url, params, headers) {
    if (params) {
        let paramsArray = [];
        //encodeURIComponent
        Object.keys(params).forEach(key => paramsArray.push(key + '=' + params[key]))
        if (url.search(/\?/) === -1) {
            url += '?' + paramsArray.join('&')
        } else {
            url += '&' + paramsArray.join('&')
        }
    }
    return new Promise(function (resolve, reject) {
        fetch(url, {
            method: 'GET',
            headers: headers,
        })
            .then((response) => {
                if (response.ok) {
                    return response.json();
                } else {
                    reject({status:response.status})
                }
            })
            .then((response) => {
                resolve(response);
            })
            .catch((err)=> {
                reject({status:-1});
            })
    })
}


/**
 * 基于 fetch 封装的 POST请求  FormData 表单数据
 * @param url
 * @param formData
 * @param headers
 * @returns {Promise}
 */
HTTPUtil.post = function(url, formData, headers) {
    return new Promise(function (resolve, reject) {
        fetch(url, {
            method: 'POST',
            headers: headers,
            body:formData,
        })
            .then((response) => {
                if (response.ok) {
                    return response.json();
                } else {
                    reject({status:response.status})
                }
            })
            .then((response) => {
                resolve(response);
            })
            .catch((err)=> {
                reject({status:-1});
            })
    })
}

export default HTTPUtil;