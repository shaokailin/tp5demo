//
//  PPSSIncomeViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSIncomeViewModel.h"
#import "PPSSCashierApi.h"
#import "PPSSOrderApi.h"
#import "PPSSShopListModel.h"
@interface PPSSIncomeViewModel()
{
    BOOL _isLoadShopList;
}
@property (nonatomic, strong) RACCommand *shopListCommond;
@property (nonatomic, strong) RACCommand *incomeCommand;
@end
@implementation PPSSIncomeViewModel
- (void)getShopIncomeEvent:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.incomeCommand execute:nil];
}
- (RACCommand *)incomeCommand {
    if (!_incomeCommand) {
        @weakify(self)
        _incomeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSCashierApi getAllIncomeWithTimestamp:[self timeTramformTimestamp] shopId:self.shopId]];
        }];
        [_incomeCommand.executionSignals.flatten subscribeNext:^(PPSSIncomeModel *model) {
            @strongify(self)
            if (model.code == 0) {
                self.incomeModel = model;
                [self sendSuccessResult:1 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
                [self sendFailureResult:1 error:nil];
            }
        }];
        [_incomeCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:1 error:nil];
        }];
    }
    return _incomeCommand;
}
- (NSInteger)timeTramformTimestamp {
    return [[NSDate stringTransToDate:self.timeDate withFormat:@"yyyy-MM-dd"]timeIntervalSince1970];
}

- (BOOL)getShopList {
    if (!_isLoadShopList) {
        _isLoadShopList = YES;
        [SKHUD showLoadingDotInWindow];
        [self.shopListCommond execute:nil];
        return YES;
    }
    return NO;
    
}
- (RACCommand *)shopListCommond {
    if (!_shopListCommond) {
        @weakify(self)
        _shopListCommond = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSOrderApi getShopList]];
        }];
        [_shopListCommond.executionSignals.flatten subscribeNext:^(PPSSShopListModel *model) {
            @strongify(self)
            if (model.code == 0 || model.code == 11) {
                if (model.data && [model.data isKindOfClass:[NSArray class]] && model.data.count > 0) {
                    self.shopListArray = model.data;
                }else {
                    self.shopListArray = nil;
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                _isLoadShopList = NO;
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
        [_shopListCommond.errors subscribeNext:^(NSError * _Nullable x) {
            _isLoadShopList = NO;
        }];
    }
    return _shopListCommond;
}
@end
