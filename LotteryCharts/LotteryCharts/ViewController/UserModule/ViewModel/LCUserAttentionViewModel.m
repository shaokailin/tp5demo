//
//  LCUserAttentionViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserAttentionViewModel.h"
#import "LCUserModuleAPI.h"
@interface LCUserAttentionViewModel ()
@property (nonatomic, strong) RACCommand *attentionCommand;
@property (nonatomic, strong) RACCommand *userAttentionCommand;
@end
@implementation LCUserAttentionViewModel
- (void)getUserAttentionList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    if (KJudgeIsNullData(self.userId)) {
        [self.userAttentionCommand execute:nil];
    }else {
        [self.attentionCommand execute:nil];
    }
    
}
- (RACCommand *)attentionCommand {
    if (!_attentionCommand) {
        @weakify(self)
        _page = 0;
        _attentionCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getUserAttention:self.page]];
        }];
        [_attentionCommand.executionSignals.flatten subscribeNext:^(LCAttentionListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (_attentionArray && _page == 0) {
                    [_attentionArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.attentionArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                if (self.page != 0) {
                    self.page --;
                }
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_attentionCommand.errors subscribeNext:^(NSError * _Nullable x) {
           @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _attentionCommand;
}
- (NSMutableArray *)attentionArray {
    if (!_attentionArray) {
        _attentionArray = [NSMutableArray array];
    }
    return _attentionArray;
}
- (RACCommand *)userAttentionCommand {
    if (!_userAttentionCommand) {
        @weakify(self)
        _page = 0;
        _userAttentionCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getOtherAttention:self.page userId:self.userId]];
        }];
        [_userAttentionCommand.executionSignals.flatten subscribeNext:^(LCAttentionListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (_attentionArray && _page == 0) {
                    [_attentionArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.attentionArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                if (self.page != 0) {
                    self.page --;
                }
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_userAttentionCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _userAttentionCommand;
}
@end
