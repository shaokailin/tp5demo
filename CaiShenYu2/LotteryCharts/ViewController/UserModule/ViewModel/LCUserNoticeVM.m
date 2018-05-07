//
//  LCUserNoticeVM.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCUserNoticeVM.h"
#import "LCUserModuleAPI.h"
@interface LCUserNoticeVM ()
@property (nonatomic, strong) RACCommand *noticeListCommand;
@end
@implementation LCUserNoticeVM
- (void)getUserNoticeList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInWindow];
    }
    [self.noticeListCommand execute:@(1) ];
}
- (void)getSystemNoticeList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInWindow];
    }
    [self.noticeListCommand execute:@(0)];
}
- (RACCommand *)noticeListCommand {
    if (!_noticeListCommand) {
        @weakify(self)
        _page = 0;
        _noticeListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getUserAndSystemNoticeList:self.page type:[input integerValue]]];
        }];
        [_noticeListCommand.executionSignals.flatten subscribeNext:^(LCUserMessageListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self.page == 0 && self->_listArray) {
                    [self.listArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.listArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                [self loadError];
                [self sendFailureResult:0 error:nil];
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
    if (self.page == 0 && _listArray && _listArray.count > 0) {
        [self.listArray removeAllObjects];
    }
    if (self.page != 0) {
        self.page --;
    }
}
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
@end
