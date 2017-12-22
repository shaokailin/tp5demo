//
//  LCExchangeMoneyViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/2.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCExchangeMoneyViewModel.h"
#import "LCUserModuleAPI.h"
#import "LCBaseResponseModel.h"
@interface LCExchangeMoneyViewModel ()
@property (nonatomic, strong) RACCommand *exchangeCommand;
@property (nonatomic, strong) RACCommand *exchangeRateCommand;
@end
@implementation LCExchangeMoneyViewModel
- (void)glodExchangeSilverEvent {
    if (self.glodMoney <= 0) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入要兑换的金币数，并且要大于0"];
        return;
    }
    if (self.glodMoney > [kUserMessageManager.money integerValue]) {
        [SKHUD showMessageInView:self.currentView withMessage:@"要兑换的金币数不能大于已有的金币数"];
        return;
    }
    [SKHUD showLoadingDotInWindow];
    [self.exchangeCommand execute:nil];
}
- (RACCommand *)exchangeCommand {
    if (!_exchangeCommand) {
        @weakify(self)
        _exchangeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI glodExchangeSilver:self.glodMoney]];
        }];
        [_exchangeCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                NSInteger glod = [kUserMessageManager.money integerValue];
                glod -= self.glodMoney;
                kUserMessageManager.money = NSStringFormat(@"%zd",glod);
                NSInteger sliver = [kUserMessageManager.yMoney integerValue];
                sliver += (self.glodMoney * self.rate);
                kUserMessageManager.yMoney = NSStringFormat(@"%zd",sliver);
                [SKHUD showMessageInView:self.currentView withMessage:@"兑换成功"];
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _exchangeCommand;
}
- (void)getExchangeRate {
    [SKHUD showLoadingDotInWindow];
    [self.exchangeRateCommand execute:nil];
}
- (RACCommand *)exchangeRateCommand {
    if (!_exchangeRateCommand) {
        @weakify(self)
        _exchangeRateCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getExchangeRate]];
        }];
        [_exchangeRateCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                [self sendSuccessResult:0 model:model.response];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _exchangeRateCommand;
}
@end
