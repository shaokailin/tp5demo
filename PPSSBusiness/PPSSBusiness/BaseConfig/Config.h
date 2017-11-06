//
//  Config.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/8.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#ifndef Config_h
#define Config_h

typedef NS_ENUM(NSInteger, OrderHomeSearchClickType) {
    OrderHomeSearchClickType_Search,
    OrderHomeSearchClickType_Date,
    OrderHomeSearchClickType_Shop
};
typedef NS_ENUM(NSInteger, CollectMoneyInType){
    CollectMoneyInType_Input,
    CollectMoneyInType_SaoYiSao
};
typedef void(^OrderHomeSearchClickBlock) (OrderHomeSearchClickType type);

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

static const NSInteger LINEVIEW_WIDTH = 1.0;

#define COLOR_WHITECOLOR [UIColor whiteColor]
static const NSInteger kMAX_LIMIT_NUMS = 1000;

#define KUserMessageManager [PPSSUserMessageManager sharedPPSSUserMessageManager]


static NSString * const kUser_Module_Home_Notification = @"User_Module_Home_Notification";
static NSString * const kCashier_Module_Home_Notification = @"Cashier_Module_Home_Notification";
static NSString * const kSystemNoticeSetting_Voice = @"SystemNoticeSetting_Voice";
static NSString * const kOrder_Module_Home_Notification = @"Order_Module_Home_Notification";

static NSString * const kAboutUSWebUrl = @"http://testmall.huashengplan.com/aboutus";
static NSString * const kProblemWebUrl = @"http://testmall.huashengplan.com/problem";;
static NSString * const kPoundageWebUrl = @"http://testmall.huashengplan.com/poundage";;

#endif /* Config_h */
