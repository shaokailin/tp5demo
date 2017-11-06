//
//  PPSSOrderDetailViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/17.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderDetailViewModel.h"
#import "PPSSOrderApi.h"
@interface PPSSOrderDetailViewModel()
@property (nonatomic, strong) RACCommand *orderDetailCommand;
@end
@implementation PPSSOrderDetailViewModel
- (void)getOrderDetail {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.orderDetailCommand execute:nil];
}
- (RACCommand *)orderDetailCommand {
    if (!_orderDetailCommand) {
        @weakify(self)
        _orderDetailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSOrderApi getOrderDetailWithId:self.orderNo]];
        }];
        [_orderDetailCommand.executionSignals.flatten subscribeNext:^(PPSSOrderDetailModel *model) {
            @strongify(self)
            if (model.code == 0) {
                self.orderDetailModel = model;
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
    }
    return _orderDetailCommand;
}
@end
