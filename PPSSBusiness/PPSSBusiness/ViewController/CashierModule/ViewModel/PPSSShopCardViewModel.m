//
//  PPSSShopCardViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//
#import "LSKBaseResponseModel.h"
#import "PPSSShopCardViewModel.h"
#import "PPSSCashierApi.h"
@interface PPSSShopCardViewModel()
@property (nonatomic, strong) RACCommand *applyCommand;
@end
@implementation PPSSShopCardViewModel
- (void)applyShopCardEvent {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.applyCommand execute:nil];
}
- (RACCommand *)applyCommand {
    if (!_applyCommand) {
        @weakify(self)
        _applyCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSCashierApi applyShopCard]];
        }];
        [_applyCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 0) {
                [SKHUD showMessageInView:self.currentView withMessage:@"申请成功~!"];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
            [self sendSuccessResult:0 model:nil];
        }];
    }
    return _applyCommand;
}
@end
