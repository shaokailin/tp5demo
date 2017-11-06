//
//  PPSSMemberDetailViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSMemberDetailViewModel.h"
#import "PPSSCashierApi.h"

@interface PPSSMemberDetailViewModel()
@property (nonatomic, strong) RACCommand *memberDetailCommand;
@end
@implementation PPSSMemberDetailViewModel
- (void)getMemberDetail:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.memberDetailCommand execute:nil];
}
- (RACCommand *)memberDetailCommand {
    if (!_memberDetailCommand) {
        @weakify(self)
        _memberDetailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSCashierApi getMemberDetail:self.userId]];
        }];
        [_memberDetailCommand.executionSignals.flatten subscribeNext:^(PPSSMemberDetailModel *model) {
            @strongify(self)
            if (model.code == 0) {
                self.memberDetailModel = model;
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_memberDetailCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _memberDetailCommand;
}
@end
