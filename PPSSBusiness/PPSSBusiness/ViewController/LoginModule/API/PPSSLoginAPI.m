//
//  PPSSLoginAPI.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSLoginAPI.h"
#import "PPSSLoginModel.h"
//登录接口
static NSString * const kLoginApi = @"login/loginUserPassword";
//登录通过短信与密码接口
static NSString * const kLoginForCodeApi = @"login/loginUserPhoneCode";
//发送短信验证码
static NSString * const kMessageVerificationCode = @"login/sendPhoneCode";
//修改密码
static NSString * const kChangePassword = @"login/updatePassword";
@implementation PPSSLoginAPI
+ (LSKParamterEntity *)loginActionWith:(NSString *)account password:(NSString *)pwd code:(NSString *)code {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    account = KNullTransformString(account);
    pwd = [NSString MD5:NSStringFormat(@"%@hsplan",KNullTransformString(pwd))];
    [entity.params setObject:account forKey:@"username"];
    [entity.params setObject:pwd forKey:@"password"];
    if (KJudgeIsNullData(code)) {
        entity.requestApi = kLoginForCodeApi;
        [entity.params setObject:code forKey:@"phoneCode"];
        [entity initializeSignWithParams:account,pwd,code, nil];
    }else {
        entity.requestApi = kLoginApi;
        [entity initializeSignWithParams:account,pwd, nil];
    }
    entity.responseObject = [PPSSLoginModel class];
    return entity;
}

+ (LSKParamterEntity *)sendVerificationCodeWithType:(NSString *)type phone:(NSString *)phone {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    phone = KNullTransformString(phone);
    entity.requestApi = kMessageVerificationCode;
    entity.responseObject = [LSKBaseResponseModel class];
    [entity.params setObject:type forKey:@"phoneType"];
    [entity.params setObject:phone forKey:@"phone"];
    [entity initializeSignWithParams:phone,type, nil];
    return entity;
}
+ (LSKParamterEntity *)forgetPwdWithType:(NSInteger)type account:(NSString *)account oldPwd:(NSString *)oldPwd password:(NSString *)pwd code:(NSString *)code {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    pwd = [NSString MD5:NSStringFormat(@"%@hsplan",KNullTransformString(pwd))];;
    entity.requestApi = kChangePassword;
   entity.responseObject = [LSKBaseResponseModel class];
    [entity.params setObject:pwd forKey:@"passwordNew"];
    if (type == 1) {//原始密码
        [entity.params setObject:[NSString MD5:NSStringFormat(@"%@hsplan",KNullTransformString(oldPwd))] forKey:@"passwordOld"];
        [entity.params setObject:KUserMessageManager.userToken forKey:@"token"];
        [entity initializeSignWithParams:KUserMessageManager.userToken,pwd, nil];
    }else if (type == 2){//忘记密码短信
        code = KNullTransformString(code);
        account = KNullTransformString(account);
        [entity.params setObject:account forKey:@"phone"];
        [entity.params setObject:code forKey:@"phoneCode"];
        [entity initializeSignWithParams:account,pwd, nil];
    }
    [entity.params setObject:@(type) forKey:@"updateType"];
    return entity;
}
@end
