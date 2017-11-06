//
//  PPSSPayMoneyViewModel.h
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface PPSSPayMoneyViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *totalPay;
@property (nonatomic, copy) NSString *realPay;
@property (nonatomic, copy) NSString *qcode;
- (void)payMoneyEvent;
@end
