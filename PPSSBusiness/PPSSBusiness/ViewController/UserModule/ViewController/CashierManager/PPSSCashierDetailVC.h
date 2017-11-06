//
//  PPSSCashierDetailVC.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/21.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
@class PPSSCashierModel;
typedef NS_ENUM(NSInteger ,CashierDetailType) {
    CashierDetailType_Add = 1,
    CashierDetailType_Exit = 2,
    CashierDetailType_Delete = 3
};
typedef void (^CashierEditBlock)(CashierDetailType actionType,PPSSCashierModel *model);
@interface PPSSCashierDetailVC : LSKBaseViewController
@property (nonatomic, copy) CashierEditBlock editBlock;
@property (nonatomic, strong) PPSSCashierModel *cashierModel;
@property (nonatomic, assign) CashierDetailType actionType;
@end
