//
//  PPSSLoginAPI.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPSSLoginAPI : NSObject
/**
 登录

 @param account 登录账号
 @param pwd 登录密码
 @param code 登录验证码，当5次失败后才需要短信验证
 @return 参数
 */
+ (LSKParamterEntity *)loginActionWith:(NSString *)account password:(NSString *)pwd code:(NSString *)code;
/**
 发送短信验证码

 @param type 类型 1.登录、2修改密码
 @param phone 电话号码
 @return 参数
 */
+ (LSKParamterEntity *)sendVerificationCodeWithType:(NSString *)type phone:(NSString *)phone;

/**
 忘记、修改密码

 @param account 手机号
 @param type 1 修改密码，2忘记密码
 @param oldPwd 旧密码
 @param pwd 新密码
 @param code 验证码
 @return 参数
 */
+ (LSKParamterEntity *)forgetPwdWithType:(NSInteger)type account:(NSString *)account oldPwd:(NSString *)oldPwd password:(NSString *)pwd code:(NSString *)code;
@end
