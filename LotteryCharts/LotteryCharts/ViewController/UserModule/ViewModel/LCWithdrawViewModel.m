//
//  LCWithdrawViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCWithdrawViewModel.h"
@interface LCWithdrawViewModel ()
@property (nonatomic, copy) NSString *money;
@property (nonatomic, strong) RACCommand *widthdrawCommand;
@end
@implementation LCWithdrawViewModel
- (void)bindSignal {
    @weakify(self)
    [self.moneySignal subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        self.money = x;
    }];
}
- (void)widthdrawActionEvent {
    if (!KJudgeIsNullData(self.money) || [self.money floatValue] <= 0) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入要提现的金额"];
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.widthdrawCommand execute:nil];
}
- (RACCommand *)widthdrawCommand {
    if (!_widthdrawCommand) {
        
    }
    return _widthdrawCommand;
}
@end
