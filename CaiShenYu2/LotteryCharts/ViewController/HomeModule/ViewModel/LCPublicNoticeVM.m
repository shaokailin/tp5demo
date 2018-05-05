//
//  LCPublicNoticeVM.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCPublicNoticeVM.h"
#import "LCHomeModuleAPI.h"
#import "LSKBaseResponseModel.h"
@interface LCPublicNoticeVM ()
@property (nonatomic, strong) RACCommand *noticeListCommand;
@end
@implementation LCPublicNoticeVM
- (void)getPublicData:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.noticeListCommand execute:nil ];
}
- (RACCommand *)noticeListCommand {
    if (!_noticeListCommand) {
        @weakify(self)
        _page = 0;
        _noticeListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getPublicNoticeList:self.page]];
        }];
        [_noticeListCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self.page == 0 && self->_listArray) {
                    [self->_listArray removeAllObjects];
                }
//                if (KJudgeIsArrayAndHasValue(model.list)) {
//                    [self.postArray addObjectsFromArray:model.list];
//                }
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
