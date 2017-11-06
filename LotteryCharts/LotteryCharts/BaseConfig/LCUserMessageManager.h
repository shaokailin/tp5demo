//
//  LCUserMessageManager.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKMessageManage.h"

@interface LCUserMessageManager : LSKMessageManage
+ (LCUserMessageManager *)sharedLCUserMessageManager;

@property (nonatomic, assign, readonly, getter=isLogin) BOOL login;

// 短信倒计时
@property(nonatomic, assign) NSInteger loginCodeTime;
@property(nonatomic, assign) NSInteger forgetCodeTime;
- (void)startLoginTimer;
- (void)startForgetTimer;

//界面是否有提示框
- (void)showAlertView:(id)alertView weight:(NSInteger)weight;
- (void)hidenAlertView;
@end
