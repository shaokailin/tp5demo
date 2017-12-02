//
//  LCExchangeMoneyViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/2.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface LCExchangeMoneyViewModel : LSKBaseViewModel
@property (nonatomic, copy) NSString *glodMoney;
- (void)glodExchangeSilverEvent;
@end
