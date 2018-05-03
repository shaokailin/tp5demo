//
//  LCRechargeMoneyViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRechargeMoneyViewModel.h"
#import "LCHomeModuleAPI.h"
#import "LCBaseResponseModel.h"

@interface LCRechargeMoneyViewModel ()
@property (nonatomic, strong) RACCommand *typeCommand;
@property (nonatomic, strong) RACCommand *aliPayCommand;
@property (nonatomic, strong) RACCommand *weixinPayCommand;
@end
@implementation LCRechargeMoneyViewModel
- (void)getRechargeType {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.typeCommand execute:nil];
}
- (RACCommand *)typeCommand {
    if (!_typeCommand) {
        @weakify(self)
        _typeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getPayTypeList]];
        }];
        [_typeCommand.executionSignals.flatten subscribeNext:^(LCRechargeMoneyListModel *model) {
            if (model.code == 200) {
                [SKHUD dismiss];
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    self.typeArray = model.response;
                }else {
                    self.typeArray = nil;
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_typeCommand.errors subscribeNext:^(NSError * _Nullable x) {
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _typeCommand;
}
- (void)payGlodEventClick {
    if (!KJudgeIsNullData(self.jinbi)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请选择要充值的金额"];
        return;
    }
    [SKHUD showLoadingDotInWindow];
    if (self.payType == 0) {
        [self.weixinPayCommand execute:nil];
    }else {
        [self.aliPayCommand execute:nil];
    }
}
- (RACCommand *)weixinPayCommand {
    if (!_weixinPayCommand) {
        @weakify(self)
        _weixinPayCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI wxPayMoney:self.jinbi]];
        }];
        [_weixinPayCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                [self sendSuccessResult:20 model:model];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _weixinPayCommand;
}
- (RACCommand *)aliPayCommand {
    if (!_aliPayCommand) {
        @weakify(self)
        _aliPayCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI aliPayMoney:self.jinbi]];
        }];
        [_aliPayCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                [self sendSuccessResult:10 model:model.response];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _aliPayCommand;
}
@end
