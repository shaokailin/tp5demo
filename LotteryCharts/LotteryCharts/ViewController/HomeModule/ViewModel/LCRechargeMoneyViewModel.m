//
//  LCRechargeMoneyViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRechargeMoneyViewModel.h"
#import "LCHomeModuleAPI.h"
@interface LCRechargeMoneyViewModel ()
@property (nonatomic, strong) RACCommand *typeCommand;
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
@end
