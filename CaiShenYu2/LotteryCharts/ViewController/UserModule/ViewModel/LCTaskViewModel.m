//
//  LCTaskViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTaskViewModel.h"
#import "LCUserModuleAPI.h"
#import "LCBaseResponseModel.h"
@interface LCTaskViewModel ()
@property (nonatomic, strong) RACCommand *taskCommand;
@property (nonatomic, strong) RACCommand *shareCommand;
@end
@implementation LCTaskViewModel
- (void)getTaskMessage {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.taskCommand execute:nil];
}
- (RACCommand *)taskCommand {
    if (!_taskCommand) {
        @weakify(self)
        _taskCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getTaskMessage]];
        }];
        [_taskCommand.executionSignals.flatten subscribeNext:^(LCTaskModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                self.taskModel = model;
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _taskCommand;
}
- (void)sendSuccessShare {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.shareCommand execute:nil];
}

- (RACCommand *)shareCommand {
    if (!_shareCommand) {
        @weakify(self)
        _shareCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI sendShareSuccess]];
        }];
        [_shareCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                [self sendSuccessResult:10 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _shareCommand;
}
@end
