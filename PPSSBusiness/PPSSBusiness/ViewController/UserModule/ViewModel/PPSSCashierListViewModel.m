//
//  PPSSCashierListViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCashierListViewModel.h"
#import "PPSSCashiersListModel.h"
#import "PPSSUserApi.h"
#import "PPSSCashierModel.h"
@interface PPSSCashierListViewModel ()
@property (nonatomic, strong) RACCommand *cashierListCommand;
@property (nonatomic, assign) BOOL isSuccess;
@end
@implementation PPSSCashierListViewModel
- (void)getCashierList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.cashierListCommand execute:nil];
}
- (RACCommand *)cashierListCommand {
    if (!_cashierListCommand) {
        _page = 0;
        @weakify(self)
        _cashierListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSUserApi getCashierList:self.page searchText:self.searchText]];
        }];
        [_cashierListCommand.executionSignals.flatten subscribeNext:^(PPSSCashiersListModel *model) {
            @strongify(self)
            if (model.code == 0) {
                self.isSuccess = YES;
                if (self.page == 0) {
                    [self.cashierListArray removeAllObjects];
                }
                if (model.data && [model.data isKindOfClass:[NSArray class]] && model.data.count > 0) {
                    [self.cashierListArray addObjectsFromArray:model.data];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                [self loadError];
                [self sendFailureResult:0 error:nil];
                if (self.page == 0) {
                    [SKHUD showMessageInView:self.currentView withMessage:model.msg];
                }
            }
        }];
        [_cashierListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _cashierListCommand;
}
- (void)loadError {
    if (self.page != 0) {
        self.page --;
    }else {
        [self.cashierListArray removeAllObjects];
    }
}
- (NSMutableArray *)cashierListArray {
    if (!_cashierListArray) {
        _cashierListArray = [NSMutableArray array];
    }
    return _cashierListArray;
}
- (void)setSearchText:(NSString *)searchText {
    if (![_searchText isEqualToString:searchText]) {
        self.page = 0;
    }
    _searchText = searchText;
}
@end
