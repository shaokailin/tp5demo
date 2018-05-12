//
//  LCSearchPostViewModel.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSearchPostViewModel.h"
#import "LCHomeModuleAPI.h"
@interface LCSearchPostViewModel ()
@property (nonatomic, strong) RACCommand *searchCommand;
@end
@implementation LCSearchPostViewModel
- (void)getSearchResult {
    [self.searchCommand execute: nil];
}
- (RACCommand *)searchCommand {
    if (!_searchCommand) {
        @weakify(self)
        _searchCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getSearchPostList:self.searchText page:self.page]];
        }];
        [_searchCommand.executionSignals.flatten subscribeNext:^(LCHomeHotListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self.page == 0 && self->_searchArray) {
                    [self->_searchArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.searchArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                [self loadError];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_searchCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _searchCommand;
}
- (void)loadError {
    if (self.page == 0 && _searchArray && _searchArray.count > 0) {
        [self.searchArray removeAllObjects];
    }
    if (self.page != 0) {
        self.page --;
    }
}
- (NSMutableArray *)searchArray {
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}
@end
