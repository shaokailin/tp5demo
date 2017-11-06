//
//  PPSSWithdrawApplyViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSWithdrawApplyViewModel.h"
#import "PPSSUserApi.h"
@interface PPSSWithdrawApplyViewModel ()
@property (nonatomic, strong) RACCommand *withdrawListCommand;
@property (nonatomic, strong) RACCommand *applyCommand;
@end
@implementation PPSSWithdrawApplyViewModel
- (void)withdrawApplyEvent {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.applyCommand execute:nil];
}
- (RACCommand *)applyCommand {
    if (!_applyCommand) {
        @weakify(self)
        _applyCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSUserApi withdrawApplyEvent:self.withdrawMoney]];
        }];
        [_applyCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            if (model.code == 0) {
                [SKHUD showMessageInView:self.currentView withMessage:@"申请提现成功"];
                [self sendSuccessResult:1 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
    }
    return _applyCommand;
}

#pragma mark - 提现列表
- (void)getWithdrawList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.withdrawListCommand execute:nil];
}
- (RACCommand *)withdrawListCommand {
    if (!_withdrawListCommand) {
        _page = 0;
        @weakify(self)
        _withdrawListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSUserApi getWithdrawListWithPage:self.page]];
        }];
        [_withdrawListCommand.executionSignals.flatten subscribeNext:^(PPSSWithdrawListModel *model) {
            @strongify(self)
            if (model.code == 0) {
                self.totalMoney = KNullTransformMoney(model.shopFee);
                if (self.page == 0) {
                    [self.withdrawListArray removeAllObjects];
                }
                if (model.data && [model.data isKindOfClass:[NSArray class]] && model.data.count > 0) {
                    [self.withdrawListArray addObjectsFromArray:model.data];
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
        [_withdrawListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _withdrawListCommand;
}
- (void)loadError {
    if (self.page != 0) {
        self.page --;
    }
}
- (NSMutableArray *)withdrawListArray {
    if (!_withdrawListArray) {
        _withdrawListArray = [NSMutableArray array];
    }
    return _withdrawListArray;
}
@end
