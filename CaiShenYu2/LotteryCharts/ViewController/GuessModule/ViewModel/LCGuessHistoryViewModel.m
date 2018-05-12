//
//  LCGuessHistoryViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessHistoryViewModel.h"
#import "LCGuessModuleAPI.h"
@interface LCGuessHistoryViewModel ()
@property (nonatomic, strong) RACCommand *guessHistoryCommand;
@end
@implementation LCGuessHistoryViewModel
- (void)getGuessHistoryList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.guessHistoryCommand execute:nil];
}
- (RACCommand *)guessHistoryCommand {
    if (!_guessHistoryCommand) {
        @weakify(self)
        _page = 0;
        _guessHistoryCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCGuessModuleAPI guessOldList:self.page]];
        }];
        [_guessHistoryCommand.executionSignals.flatten subscribeNext:^(LCGuessMainListModel *model) {
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
        [_guessHistoryCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _guessHistoryCommand;
}
- (NSMutableArray *)guessArray {
    if (!_guessArray) {
        _guessArray = [NSMutableArray array];
    }
    return _guessArray;
}
@end
