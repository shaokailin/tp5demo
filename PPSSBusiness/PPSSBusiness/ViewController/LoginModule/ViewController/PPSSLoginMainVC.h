//
//  PPSSLoginMainVC.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef NS_ENUM(NSInteger, LoginMainInType) {
    LoginMainInType_Nornal,
    LoginMainInType_Token
};
@interface PPSSLoginMainVC : LSKBaseViewController
@property (nonatomic, assign) LoginMainInType inType;
@end
