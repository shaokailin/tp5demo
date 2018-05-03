//
//  LCTeamViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTeamViewModel.h"
#import "LCUserModuleAPI.h"
@interface LCTeamViewModel ()
@property (nonatomic, strong) RACCommand *teamListCommand;
@property (nonatomic, strong) RACCommand *teamTopCommand;
@property (nonatomic, strong) RACCommand *signTopCommand;
@end
@implementation LCTeamViewModel
- (void)getTeamList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    if (self.page == 0) {
        if (_showType == 0) {
            [self.teamTopCommand execute:nil];
        }else {
            [self.signTopCommand execute:nil];
        }
    }
    [self.teamListCommand execute: nil];
}
- (void)bindSinal {
    [[self.teamListCommand.executionSignals.flatten zipWith:self.teamTopCommand.executionSignals.flatten ] subscribeNext:^(RACTwoTuple<RACTwoTuple<NSNumber *,id> *,id> * _Nullable x) {
       [SKHUD dismiss];
    }];
    [[self.teamListCommand.executionSignals.flatten zipWith:self.signTopCommand.executionSignals.flatten ] subscribeNext:^(RACTwoTuple<RACTwoTuple<NSNumber *,id> *,id> * _Nullable x) {
        [SKHUD dismiss];
    }];
}
- (RACCommand *)teamListCommand {
    if (!_teamListCommand) {
        @weakify(self)
        _teamListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getUserTeamList:self.page type:self.showType]];
        }];
        [_teamListCommand.executionSignals.flatten subscribeNext:^(LCTeamListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                if (self.page == 0) {
                    [_teamArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.teamArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:model];
            }else {
                [self loadError];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_teamListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _teamListCommand;
}
- (void)loadError {
    if (self.page == 0 && _teamArray && _teamArray.count > 0) {
        [self.teamArray removeAllObjects];
    }
    if (self.page != 0) {
        self.page --;
    }
}
- (NSMutableArray *)teamArray {
    if (!_teamArray) {
        _teamArray = [NSMutableArray array];
    }
    return _teamArray;
}
- (RACCommand *)teamTopCommand {
    if (!_teamTopCommand) {
        @weakify(self)
        _teamTopCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getUserTeamCount]];
        }];
        [_teamTopCommand.executionSignals.flatten subscribeNext:^(LCTeamCountModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [self sendSuccessResult:1 model:model];
            }else {
                [self sendFailureResult:1 error:nil];
            }
        }];
        [_teamTopCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:1 error:nil];
        }];
    }
    return _teamTopCommand;
}
- (RACCommand *)signTopCommand {
    if (!_signTopCommand) {
        @weakify(self)
        _signTopCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getUserSignCount]];
        }];
        [_signTopCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [self sendSuccessResult:2 model:model.response];
            }else {
                [self sendFailureResult:2 error:nil];
            }
        }];
        [_signTopCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:2 error:nil];
        }];
    }
    return _signTopCommand;
}
@end
