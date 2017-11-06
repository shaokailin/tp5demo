//
//  PPSSCashierHomeViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierHomeViewModel.h"
#import "PPSSCashierApi.h"
@interface PPSSCashierHomeViewModel()
@property (nonatomic, strong) RACCommand *userMessageCommand;
@end
@implementation PPSSCashierHomeViewModel
- (void)getUserMessageByToken:(BOOL)isPull {
    _isPull = isPull;
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.userMessageCommand execute:nil];
}
- (RACCommand *)userMessageCommand {
    if (!_userMessageCommand) {
        @weakify(self)
        _userMessageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSCashierApi getUserMessageRequest]];
        }];
        [_userMessageCommand.executionSignals.flatten subscribeNext:^(PPSSLoginModel *model) {
            @strongify(self)
            if (model.code == 0) {
                self.userMessageModel = model;
                [KUserMessageManager saveUserMessage:model];
                [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kUser_Module_Home_Notification object:nil];
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_userMessageCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _userMessageCommand;
}
@end
