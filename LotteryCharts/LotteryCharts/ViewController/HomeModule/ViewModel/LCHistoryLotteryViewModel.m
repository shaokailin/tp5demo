//
//  LCHistoryLotteryViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHistoryLotteryViewModel.h"
#import "LCHomeModuleAPI.h"
@interface LCHistoryLotteryViewModel ()
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) RACCommand *historyListCommand;
@end
@implementation LCHistoryLotteryViewModel
- (void)getHistoryLotteryList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.historyListCommand execute: nil];
}
- (RACCommand *)historyListCommand {
    if (!_historyListCommand) {
        @weakify(self)
        _page = 0;
        self.limitRow = 0;
        _historyListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getkHistoryLotteryList:self.page limitRow:self.pageSize period_id:self.period_id]];
        }];
        [_historyListCommand.executionSignals.flatten subscribeNext:^(LCHistoryLotteryListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self.page == 0 && _historyArray) {
                    [_historyArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.historyArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                [self loadError];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_historyListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _historyListCommand;
}
- (void)loadError {
    if (self.page == 0 && _historyArray && _historyArray.count > 0) {
        [self.historyArray removeAllObjects];
    }
    if (self.page != 0) {
        self.page --;
    }
}
- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}
- (void)setPeriod_id:(NSString *)period_id {
    if (![_period_id isEqualToString:period_id]) {
        _period_id = period_id;
        self.page = 0;
    }
}
- (void)setLimitRow:(NSInteger)limitRow {
    if (_limitRow != limitRow) {
        _page = 0;
        if (limitRow == 0) {
            _pageSize = 10;
        }else {
            _pageSize = 5;
        }
    }
}
@end
