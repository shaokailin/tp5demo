//
//  LCContactViewModel.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCContactViewModel.h"
#import "LCUserModuleAPI.h"
@interface LCContactViewModel ()
@property (nonatomic, strong) RACCommand *contactCommand;
@end
@implementation LCContactViewModel
- (void)getContactList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.contactCommand execute:nil];
}
- (RACCommand *)contactCommand {
    if (!_contactCommand) {
        @weakify(self)
        _page = 0;
        _contactCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getContactList:self.page]];
        }];
        [_contactCommand.executionSignals.flatten subscribeNext:^(LCCantactListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self->_contactArray && self->_page == 0) {
                    [self->_contactArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.contactArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                if (self.page != 0) {
                    self.page --;
                }
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_contactCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _contactCommand;
}
- (NSMutableArray *)contactArray {
    if (!_contactArray) {
        _contactArray = [NSMutableArray array];
    }
    return _contactArray;
}
@end
