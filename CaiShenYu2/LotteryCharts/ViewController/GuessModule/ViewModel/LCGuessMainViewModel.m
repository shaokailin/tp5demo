//
//  LCGuessMainViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessMainViewModel.h"
#import "LCGuessModuleAPI.h"
@interface LCGuessMainViewModel ()
@property (nonatomic, strong) RACCommand *guessMainCommand;
@property (nonatomic, strong) RACCommand *guessMoreCommand;
@end
@implementation LCGuessMainViewModel
- (void)getGuessMianList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInWindow];
    }
    [self.guessMainCommand execute:nil];
}
- (RACCommand *)guessMainCommand {
    if (!_guessMainCommand) {
        @weakify(self)
        _page = 0;
        _guessMainCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCGuessModuleAPI guessMainList:self.page]];
        }];
        [_guessMainCommand.executionSignals.flatten subscribeNext:^(LCGuessMainListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (_guessArray && _page == 0) {
                    [_guessArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.guessArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                if (self.page != 0) {
                    self.page --;
                }
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_guessMainCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _guessMainCommand;
}
- (NSMutableArray *)guessArray {
    if (!_guessArray) {
        _guessArray = [NSMutableArray array];
    }
    return _guessArray;
}

- (void)getGuessMainMoreList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.guessMoreCommand execute:nil];
}
- (RACCommand *)guessMoreCommand {
    if (!_guessMoreCommand) {
        @weakify(self)
        _page = 0;
        _guessMoreCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCGuessModuleAPI guessMainMoreList:self.page period_id:self.period_id]];
        }];
        [_guessMoreCommand.executionSignals.flatten subscribeNext:^(LCGuessMainMoreModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self->_guessArray && self->_page == 0) {
                    [self->_guessArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.guessArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                if (self.page != 0) {
                    self.page --;
                }
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_guessMoreCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _guessMoreCommand;
}
@end
