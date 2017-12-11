//
//  LCHomeMainViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeMainViewModel.h"
#import "LCHomeModuleAPI.h"
#import "LCBaseResponseModel.h"
@interface LCHomeMainViewModel ()
@property (nonatomic, strong) RACCommand *onlineCommand;
@property (nonatomic, strong) RACCommand *headerMessageCommand;
@property (nonatomic, strong) RACCommand *hotCommand;
@end
@implementation LCHomeMainViewModel
- (void)getHomeMessage:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInWindow];
    }
    if (self.page == 0) {
        [self.onlineCommand execute:nil];
        [self.headerMessageCommand execute:nil];
    }
    [self.hotCommand execute:nil];
}
- (void)bindSinal {
    _page = 0;
    [[[self.onlineCommand.executionSignals.flatten zipWith:self.headerMessageCommand.executionSignals.flatten]zipWith:self.hotCommand.executionSignals.flatten] subscribeNext:^(RACTwoTuple<RACTwoTuple<NSNumber *,id> *,id> * _Nullable x) {
        [SKHUD dismiss];
    }];
}
- (RACCommand *)hotCommand {
    if (!_hotCommand) {
        @weakify(self)
        _hotCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getHotPostList:self.page]];
        }];
        [_hotCommand.executionSignals.flatten subscribeNext:^(LCHomeHotListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (_hotPostArray && _page == 0) {
                    [_hotPostArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.hotPostArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                if (self.page != 0) {
                    self.page --;
                }
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_hotCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _hotCommand;
}
- (NSMutableArray *)hotPostArray {
    if (!_hotPostArray) {
        _hotPostArray = [NSMutableArray array];
    }
    return _hotPostArray;
}
- (RACCommand *)onlineCommand {
    if (!_onlineCommand) {
        @weakify(self)
        _onlineCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getOnLineAll]];
        }];
        [_onlineCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [self sendSuccessResult:10 model:model.response];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _onlineCommand;
}
- (RACCommand *)headerMessageCommand {
    if (!_headerMessageCommand) {
        @weakify(self)
        _headerMessageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getHomeHeaderMessage]];
        }];
        [_headerMessageCommand.executionSignals.flatten subscribeNext:^(LCHomeHeaderMessageModel *model) {
            @strongify(self)
            if (model.code == 200) {
                self.messageModel = model;
                [self sendSuccessResult:20 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _headerMessageCommand;
}
@end
