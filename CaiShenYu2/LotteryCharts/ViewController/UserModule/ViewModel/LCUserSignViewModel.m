//
//  LCUserSignViewModel.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserSignViewModel.h"
#import "LCUserModuleAPI.h"
#import "LCUserSignMessageModel.h"
@interface LCUserSignViewModel()
@property (nonatomic, strong) RACCommand *signMessageCommand;
@property (nonatomic, strong) RACCommand *signCommand;
@end
@implementation LCUserSignViewModel
- (void)getSignMessage {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.signMessageCommand execute:nil];
}

- (RACCommand *)signMessageCommand {
    if (!_signMessageCommand) {
        @weakify(self)
        _signMessageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI userSignMessage]];
        }];
        [_signMessageCommand.executionSignals.flatten subscribeNext:^(LCUserSignMessageModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                self.messageModel = model;
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
        [_signMessageCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _signMessageCommand;
}

- (void)userSignClickEvent {
    [SKHUD showLoadingDotInWindow];
    [self.signCommand execute:nil];
}
- (RACCommand *)signCommand {
    if (!_signCommand) {
        @weakify(self)
        _signCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI userSignEvent]];
        }];
        [_signCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:@"签到成功"];
                [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kSign_Change_Notice object:nil];
                [self sendSuccessResult:10 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _signCommand;
}
@end
