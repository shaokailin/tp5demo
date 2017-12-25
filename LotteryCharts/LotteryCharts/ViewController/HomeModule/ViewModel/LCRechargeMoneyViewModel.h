//
//  LCRechargeMoneyViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "LCRechargeMoneyListModel.h"
@interface LCRechargeMoneyViewModel : LSKBaseViewModel
@property (nonatomic, strong) NSArray *typeArray;
- (void)getRechargeType;
@property (nonatomic, copy) NSString *jinbi;
@property (nonatomic, assign) NSInteger payType;
- (void)payGlodEventClick;
@end
