//
//  LCHistoryOrderViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHistoryOrderViewModel.h"
#import "LCUserModuleAPI.h"
@interface LCHistoryOrderViewModel ()
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) RACCommand *historyListCommand;
@end
@implementation LCHistoryOrderViewModel
- (void)getHistoryOrderList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.historyListCommand execute: nil];
}
- (RACCommand *)historyListCommand {
    if (!_historyListCommand) {
        @weakify(self)
        _page = 0;
        _showType = 0;
        _historyListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getHisttoryOrderWith:self.period_id page:self.page showType:self.showType]];
        }];
        [_historyListCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self.page == 0 && self->_historyArray) {
                    [self->_historyArray removeAllObjects];
                }
                NSArray *array = nil;
                if (self.showType == 0) {
                    array = ((LCHistoryOrderListModel *)model).response;
                }else {
                    array = ((LCOrderHistoryGuessModel *)model).response;
                }
                if (KJudgeIsArrayAndHasValue(array)) {
                    [self.historyArray addObjectsFromArray:array];
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
@end
