//
//  LCUserMessageManager.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKMessageManage.h"
static NSString * const kUserMessage_Birthday = @"user_Birthday";
static NSString * const kUserMessage_Sex = @"user_Sex";
static NSString * const kUserMessage_Mobile = @"user_Mobile";

@class LCUserMessageModel;
@interface LCUserMessageManager : LSKMessageManage
+ (LCUserMessageManager *)sharedLCUserMessageManager;

@property (nonatomic, assign, readonly, getter=isLogin) BOOL login;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *yMoney;
@property (nonatomic, copy) NSString *sMoney;
@property (nonatomic, copy) NSString *bglogo;
@property (nonatomic, copy) NSString *mch_no;
- (void)removeUserMessage;
- (void)saveUserMessage:(LCUserMessageModel *)model isLogin:(BOOL)isLogin;

@property (nonatomic, assign) BOOL isShowReply;
@property (nonatomic, assign) BOOL isShowShang;
@property (nonatomic, assign) BOOL isShowCare;
@property (nonatomic, assign) BOOL isShowSystem;

// 短信倒计时
@property(nonatomic, assign) NSInteger loginCodeTime;
@property(nonatomic, assign) NSInteger forgetCodeTime;
- (void)startLoginTimer;
- (void)startForgetTimer;

//界面是否有提示框
- (void)showAlertView:(id)alertView weight:(NSInteger)weight;
- (void)hidenAlertView;
@end
