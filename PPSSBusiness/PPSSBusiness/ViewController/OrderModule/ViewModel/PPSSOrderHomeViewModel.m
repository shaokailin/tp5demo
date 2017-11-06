//
//  PPSSOrderHomeViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderHomeViewModel.h"
#import "PPSSOrderApi.h"
#import "PPSSShopListModel.h"
#import "PPSSOrderListModel.h"
@interface PPSSOrderHomeViewModel()
{
    BOOL _isLoadShopList;
}
@property (nonatomic, strong) RACCommand *shopListCommand;
@property (nonatomic, strong) RACCommand *orderListCommand;
@end

@implementation PPSSOrderHomeViewModel
- (BOOL)getShopList {
    if (!_isLoadShopList) {
        _isLoadShopList = YES;
        [SKHUD showLoadingDotInWindow];
        [self.shopListCommand execute:nil];
        return YES;
    }else {
        return NO;
    }
    
}
- (RACCommand *)shopListCommand {
    if (!_shopListCommand) {
        @weakify(self)
        _shopListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSOrderApi getShopList]];
        }];
        [_shopListCommand.executionSignals.flatten subscribeNext:^(PPSSShopListModel *model) {
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
        [_shopListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            _isLoadShopList = NO;
        }];
    }
    return _shopListCommand;
}


#pragma mark 订单列表
- (void)getOrderList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInWindow];
    }
    [self.orderListCommand execute:nil];
    
}
- (RACCommand *)orderListCommand {
    if (!_orderListCommand) {
        @weakify(self)
        self.page = 0;
        _shopId = nil;
        self.payStatus = -1;
        self.payType = -1;
        _searchText = nil;
        _orderListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSOrderApi getOrderListWithTime:[self timeTramformTimestamp] page:self.page shopId:self.shopId payType:self.payType payStatus:self.payStatus content:self.searchText]];
        }];
        [_orderListCommand.executionSignals.flatten subscribeNext:^(PPSSOrderListModel *model) {
            @strongify(self)
            if (model.code == 0) {
                if (self.page == 0) {
                    [self.orderListArray removeAllObjects];
                }
                if (model.data && [model.data isKindOfClass:[NSArray class]] && model.data.count > 0) {
                    [self.orderListArray addObjectsFromArray:model.data];
                }
                [self sendSuccessResult:1 model:nil];
            }else {
                [self loadError];
                [self sendFailureResult:1 error:nil];
            }
        }];
        [_orderListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:1 error:nil];
        }];
    }
    return _orderListCommand;
}
- (void)loadError {
    if (self.page != 0) {
        self.page --;
    }else {
        [self.orderListArray removeAllObjects];
    }
}
- (void)setSearchText:(NSString *)searchText {
    if (![_searchText isEqualToString:searchText]) {
        _searchText = searchText;
        self.page = 0;
    }
}
- (void)setShopId:(NSString *)shopId {
    if (![_shopId isEqualToString:shopId]) {
        _shopId = shopId;
        self.page = 0;
    }
}
- (NSInteger)timeTramformTimestamp {
    return [[NSDate stringTransToDate:self.dateString withFormat:@"yyyy-MM-dd"]timeIntervalSince1970];
}
- (NSMutableArray *)orderListArray {
    if (!_orderListArray) {
        _orderListArray = [NSMutableArray array];
    }
    return _orderListArray;
}
@end
