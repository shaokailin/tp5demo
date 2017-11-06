//
//  PPSSPayMoneyViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSPayMoneyViewModel.h"
#import "PPSSCashierApi.h"
#import "LSKBaseResponseModel.h"
@interface PPSSPayMoneyViewModel ()
@property (nonatomic, strong) RACCommand *payCommand;
@end
@implementation PPSSPayMoneyViewModel
- (void)payMoneyEvent {
    [SKHUD showLoadingDotInWindow];
    [self.payCommand execute:nil];
}
- (RACCommand *)payCommand {
    if (!_payCommand) {
        @weakify(self)
        _payCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSCashierApi payMoneyEventWithTotal:self.totalPay realPay:self.realPay qcode:self.qcode]];
        }];
        [_payCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            if (model.code == 0) {
                [SKHUD showMessageInView:self.currentView withMessage:@"收款成功"];
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_payCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _payCommand;
}
@end
