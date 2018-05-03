//
//  LCGuessUserModel.m
//  LotteryCharts
//
//  Created by 程磊 on 2018/3/26.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCGuessUserModel.h"
#import "UserListModel.h"

@interface LCGuessUserModel ()
@property (nonatomic, strong) RACCommand *guessUserCommand;
@end

@implementation LCGuessUserModel

- (NSMutableArray *)attentionArray {
    if (!_attentionArray) {
        _attentionArray = [NSMutableArray array];
    }
    return _attentionArray;
}

- (void)getUserAttentionList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.guessUserCommand execute:nil];
}


- (RACCommand *)guessUserCommand {
    if (!_guessUserCommand) {
        @weakify(self)
        _page = 0;
        _guessUserCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI getlistUserModel:self.page userId:self.quiz_id]];
        }];
        [_guessUserCommand.executionSignals.flatten subscribeNext:^(UserListModel *model) {
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
        [_guessUserCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _guessUserCommand;
}
@end
