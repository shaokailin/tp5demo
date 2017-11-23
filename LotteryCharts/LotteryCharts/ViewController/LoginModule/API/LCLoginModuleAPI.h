//
//  LCLoginModuleAPI.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/23.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCLoginModuleAPI : NSObject
//发送验证码
+ (LSKParamterEntity *)sendCodeWithPhone:(NSString *)phone;
//注册用户
+ (LSKParamterEntity *)registerUserWithPhone:(NSString *)phone pwd:(NSString *)pwd msid:(NSString *)msid code:(NSString *)code;
//登录
+ (LSKParamterEntity *)loginUserWithPhone:(NSString *)phone pwd:(NSString *)pwd;
//退出登录
+ (LSKParamterEntity *)loginOutEvent:(NSString *)token;
//找回密码
+ (LSKParamterEntity *)forgetPassword:(NSString *)phone code:(NSString *)code;
//修改密码
+ (LSKParamterEntity *)changePassword:(NSString *)phone passwod:(NSString *)pwd auth:(NSString *)auth;
//获取用户信息
+ (LSKParamterEntity *)getUserMessageForLogin:(NSString *)token;
@end
