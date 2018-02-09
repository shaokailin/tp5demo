//
//  LCLoginModuleAPI.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/23.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCLoginModuleAPI.h"
#import "LCLoginMainModel.h"
#import "LCUserLoginMessageModel.h"
#import "LCBaseResponseModel.h"
static NSString * const kSendCodeApi = @"Public/sendCode.html";
static NSString * const kRegisterUserApi = @"Public/reg.html";
static NSString * const kLoginUserApi = @"Public/login.html";
static NSString * const kLoginThirdApi = @"Public/thridLogin.html";
static NSString * const kLoginOutApi = @"Public/logout.html";
static NSString * const kForgetPwd = @"Public/findForgetPassword.html";
static NSString * const kChangePwd = @"Public/updateForgetPassword.html";
static NSString * const kGetUserMessage = @"User/getUserInfo.html";
@implementation LCLoginModuleAPI
+ (LSKParamterEntity *)sendCodeWithPhone:(NSString *)phone {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kSendCodeApi;
    entity.responseObject = [LSKBaseResponseModel class];
    entity.params = @{@"mobile":phone};
    return entity;
}
+ (LSKParamterEntity *)registerUserWithPhone:(NSString *)phone pwd:(NSString *)pwd msid:(NSString *)msid code:(NSString *)code {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kRegisterUserApi;
    entity.responseObject = [LCLoginMainModel class];
    entity.params = @{@"mobile":phone,@"password":pwd,@"mchid":msid,@"code":code};
    return entity;
}

+ (LSKParamterEntity *)loginUserWithPhone:(NSString *)phone pwd:(NSString *)pwd {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kLoginUserApi;
    entity.responseObject = [LCLoginMainModel class];
    entity.params = @{@"mobile":phone,@"password":pwd};
    return entity;
}
+ (LSKParamterEntity *)loginThirdWithParams:(NSDictionary *)param {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kLoginThirdApi;
    entity.responseObject = [LCBaseResponseModel class];
    entity.params = param;
    return entity;
}
+ (LSKParamterEntity *)loginOutEvent:(NSString *)token {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kLoginOutApi;
    entity.responseObject = [LSKBaseResponseModel class];
    entity.params = @{@"token":token};
    return entity;
}
+ (LSKParamterEntity *)forgetPassword:(NSString *)phone code:(NSString *)code {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kForgetPwd;
    entity.responseObject = [LCLoginMainModel class];
    entity.params = @{@"mobile":phone,@"code":code};
    return entity;
}
+ (LSKParamterEntity *)changePassword:(NSString *)phone passwod:(NSString *)pwd auth:(NSString *)auth {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kChangePwd;
    entity.responseObject = [LSKBaseResponseModel class];
    entity.params = @{@"mobile":phone,@"password":pwd,@"auth_sign":auth};
    return entity;
}
+ (LSKParamterEntity *)getUserMessageForLogin:(NSString *)token {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kGetUserMessage;
    entity.responseObject = [LCUserLoginMessageModel class];
    entity.params = @{@"token":token};
    return entity;
}
@end
