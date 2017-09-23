//
//  PPSSCashierDetailVC.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef NS_ENUM(NSInteger ,CashierDetailType) {
    CashierDetailType_Add,
    CashierDetailType_Exit
};
@interface PPSSCashierDetailVC : LSKBaseViewController
@property (nonatomic, assign) CashierDetailType actionType;
@end
