//
//  PPSSActivityListViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityListViewModel.h"
#import "PPSSActivityListModel.h"
#import "PPSSCashierApi.h"

@interface PPSSActivityListViewModel ()
@property (nonatomic, strong) RACCommand *activityListCommand;
@property (nonatomic, assign) BOOL isSuccess;
@end
@implementation PPSSActivityListViewModel
- (void)getActivityList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.activityListCommand execute:nil];
}
- (RACCommand *)activityListCommand {
    if (!_activityListCommand) {
        _page = 0;
        _state = 1;
        @weakify(self)
        _activityListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSCashierApi getActivityList:self.page state:self.state needPromotion:2]];
        }];
        [_activityListCommand.executionSignals.flatten subscribeNext:^(PPSSActivityListModel *model) {
            @strongify(self)
            if (model.code == 0) {
                self.isSuccess = YES;
                if (self.page == 0) {
                    [self.activityListArray removeAllObjects];
                }
                if (model.data && [model.data isKindOfClass:[NSArray class]] && model.data.count > 0) {
                    [self.activityListArray addObjectsFromArray:model.data];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                if (model.code == 11) {
                    self.isSuccess = YES;
                }
                [self loadError];
                [self sendFailureResult:0 error:nil];
                if (self.page == 0) {
                    [SKHUD showMessageInView:self.currentView withMessage:model.msg];
                }
            }
        }];
        [_activityListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _activityListCommand;
}

- (void)setState:(NSInteger)state {
    if (_state != state) {
        _state = state;
        _page = 0;
        [self getActivityList:NO];
    }
}
- (void)loadError {
    if (self.page != 0) {
        self.page --;
    }else {
        [self.activityListArray removeAllObjects];
    }
}
- (NSMutableArray *)activityListArray {
    if (!_activityListArray) {
        _activityListArray = [NSMutableArray array];
    }
    return _activityListArray;
}
@end
