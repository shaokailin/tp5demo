//
//  PPSSMemberHomeViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSMemberHomeViewModel.h"
#import "PPSSMemberListModel.h"
#import "PPSSCashierApi.h"
@interface PPSSMemberHomeViewModel ()
@property (nonatomic, strong) RACCommand *memberListCommand;
@end
@implementation PPSSMemberHomeViewModel
- (void)getMemberList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.memberListCommand execute:nil];
}
- (RACCommand *)memberListCommand {
    if (!_memberListCommand) {
        _page = 0;
        @weakify(self)
        _memberListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSCashierApi getMemberListWithPage:self.page searchText:self.searchText]];
        }];
        [_memberListCommand.executionSignals.flatten subscribeNext:^(PPSSMemberListModel *model) {
            @strongify(self)
            if (model.code == 0) {
                if (self.page == 0) {
                    [self.memberListArray removeAllObjects];
                }
                if (model.data && [model.data isKindOfClass:[NSArray class]] && model.data.count > 0) {
                    [self.memberListArray addObjectsFromArray:model.data];
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
        [_memberListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _memberListCommand;
}
- (void)loadError {
    if (self.page != 0) {
        self.page --;
    }else {
        [self.memberListArray removeAllObjects];
    }
}
- (NSMutableArray *)memberListArray {
    if (!_memberListArray) {
        _memberListArray = [NSMutableArray array];
    }
    return _memberListArray;
}
- (void)setSearchText:(NSString *)searchText {
    if (![_searchText isEqualToString:searchText] && self.page != 0) {
        self.page = 0;
    }
    _searchText = searchText;
}

@end
