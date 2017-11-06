//
//  PPSSNoticeListViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSNoticeListViewModel.h"
#import "PPSSCashierApi.h"
@interface PPSSNoticeListViewModel ()
@property (nonatomic, strong) RACCommand *noticeListCommand;
@end
@implementation PPSSNoticeListViewModel
- (void)getNoticeList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.noticeListCommand execute:nil];
}
- (RACCommand *)noticeListCommand {
    if (!_noticeListCommand) {
        _page = 0;
        @weakify(self)
        _noticeListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSCashierApi getNoticeList:self.page]];
        }];
        [_noticeListCommand.executionSignals.flatten subscribeNext:^(PPSSNoticeListModel *model) {
            @strongify(self)
            if (model.code == 0) {
                if (self.page == 0) {
                    [self.noticeListArray removeAllObjects];
                }
                if (model.data && [model.data isKindOfClass:[NSArray class]] && model.data.count > 0) {
                    [self.noticeListArray addObjectsFromArray:model.data];
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
        [_noticeListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _noticeListCommand;
}
- (void)loadError {
    if (self.page != 0) {
        self.page --;
    }
}
- (NSMutableArray *)noticeListArray {
    if (!_noticeListArray) {
        _noticeListArray = [NSMutableArray array];
    }
    return _noticeListArray;
}
@end
