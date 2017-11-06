//
//  PPSSUserMessageManager.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKMessageManage.h"
@class PPSSLoginModel;
@interface PPSSUserMessageManager : LSKMessageManage

+ (PPSSUserMessageManager *)sharedPPSSUserMessageManager;
//userMessage
@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *power;//等级1店长2收银员
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *qcode;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, assign) BOOL isRegisterAlia;
@property (nonatomic, strong) PPSSLoginModel *loginModel;
- (void)saveLoginNumber:(NSString *)account pwd:(NSString *)pwd isSave:(BOOL)isSave;
- (NSString *)getLoginAccount;
- (NSString *)getLoginPassword;
- (void)setLoginPassword:(NSString *)password;
//判断用户是否登录
- (BOOL)isLogin;
//移除用户的保存信息
- (void)removeUserMessage;
- (void)saveUserMessage:(PPSSLoginModel *)model;
- (void)saveUserName:(NSString *)userName power:(NSString *)power phone:(NSString *)phone;
// 短信倒计时
@property(nonatomic, assign) NSInteger loginCodeTime;
@property(nonatomic, assign) NSInteger forgetCodeTime;
- (void)startLoginTimer;
- (void)startForgetTimer;
#pragma mark setting push Alias
- (void)loginPushWithAlias:(NSString *)userId;
- (void)isHasRegisterAlias;
- (void)cleanAlias;
//界面是否有提示框
- (void)showAlertView:(id)alertView weight:(NSInteger)weight;
- (void)hidenAlertView;
@end
