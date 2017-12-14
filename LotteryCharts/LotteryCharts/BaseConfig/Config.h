//
//  Config.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#ifndef Config_h
#define Config_h

// 圆角效果 view 10
#define ViewBoundsRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]\

#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
//layer颜色用来调试视图
#define ViewBorderLayer(View,Color,Width)\
\
View.layer.borderWidth = (Width);\
View.layer.borderColor = (Color).CGColor\

#define kUserMessageManager [LCUserMessageManager sharedLCUserMessageManager]
static NSString * const kUserModule_HomeChangeMessageNotice = @"HomeChangeMessageNotice";
static NSString * const kPushPost_Alter = @"PushPost_Alter";
static NSString * const kWallet_Change_Notice = @"Wallet_Change_Notice";
static NSString * const kLoginOutChange_Notice = @"LoginOutChange_Notice";
static NSString * const kSign_Change_Notice = @"Sign_Change_Notice";
#endif /* Config_h */
