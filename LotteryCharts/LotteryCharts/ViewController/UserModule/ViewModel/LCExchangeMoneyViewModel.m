//
//  LCExchangeMoneyViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/2.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCExchangeMoneyViewModel.h"
@interface LCExchangeMoneyViewModel ()
@property (nonatomic, strong) RACCommand *exchangeCommand;
@end
@implementation LCExchangeMoneyViewModel
- (void)glodExchangeSilverEvent {
    [SKHUD showLoadingDotInWindow];
    [self.exchangeCommand execute:nil];
}
@end
