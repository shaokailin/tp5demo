//
//  LCWithdrawViewModel.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface LCWithdrawViewModel : LSKBaseViewModel
@property (nonatomic, strong) RACSignal *moneySignal;
- (void)bindSignal;
- (void)widthdrawActionEvent;
@end
