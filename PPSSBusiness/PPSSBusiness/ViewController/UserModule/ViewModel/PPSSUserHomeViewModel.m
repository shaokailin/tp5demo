//
//  PPSSUserHomeViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSUserHomeViewModel.h"
#import "PPSSUserApi.h"
@interface PPSSUserHomeViewModel ()
@property (nonatomic, assign) BOOL isPull;
@property (nonatomic, strong) RACCommand *messageCommand;
@end
@implementation PPSSUserHomeViewModel
- (void)getUserHomeMessageEvent:(BOOL)isPull {
    _isPull = isPull;
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.messageCommand execute:nil];
}
- (RACCommand *)messageCommand {
    if (!_messageCommand) {
        @weakify(self)
        _messageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSUserApi getUserHomeMessage]];
        }];
        [_messageCommand.executionSignals.flatten subscribeNext:^(PPSSUserHomeMessageModel *model) {
            @strongify(self)
            if (model.code == 0) {
                [KUserMessageManager saveUserName:model.userName power:model.userPower phone:model.userPhone];
                [self sendSuccessResult:self.isPull model:model];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
                [self sendFailureResult:self.isPull error:nil];
            }
        }];
        [_messageCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:self.isPull error:nil];
        }];
    }
    return _messageCommand;
}
@end
