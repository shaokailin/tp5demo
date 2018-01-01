//
//  LCGuessDetailViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessDetailViewModel.h"
#import "LCGuessModuleAPI.h"

@interface LCGuessDetailViewModel ()
@property (nonatomic, strong) RACCommand *replyListCommand;
@property (nonatomic, strong) RACCommand *sendReplyCommand;
@property (nonatomic, strong) RACCommand *betGuessCommand;
@end
@implementation LCGuessDetailViewModel
- (void)getReplyList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.replyListCommand execute:nil];
}
- (void)sendReplyClick:(NSString *)message {
    if (!KJudgeIsNullData([message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]])) {
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.sendReplyCommand execute:message];
}
- (void)betGuessWithCount:(NSString *)count {
    if (!KJudgeIsNullData(count) || [count integerValue] <= 0) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入要挑战的份额"];
        return;
    }
    [self.betGuessCommand execute:count];
}
- (RACCommand *)replyListCommand {
    if (!_replyListCommand) {
        @weakify(self)
        _page = 0;
        _replyListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCGuessModuleAPI getGuessDetail:self.quiz_id page:self.page]];
        }];
        [_replyListCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (_replyArray && _page == 0) {
                    [_replyArray removeAllObjects];
                }
                NSArray *data = nil;
                if (self.page == 0) {
                    LCGuessDetailModel *model1 = (LCGuessDetailModel *)model;
                    data = model1.response.reply;
                }else {
                    LCGuessReplyListModel *model1 = (LCGuessReplyListModel *)model;
                    data = model1.reply;
                }
                if (KJudgeIsArrayAndHasValue(data)) {
                    [self.replyArray addObjectsFromArray:data];
                }
                if (self.page == 0 ) {
                    [self sendSuccessResult:0 model:model];
                }else {
                    [self sendSuccessResult:0 model:nil];
                }
                
            }else {
                
                if (self.page != 0) {
                    self.page --;
                }else {
                    [SKHUD showMessageInView:self.currentView withMessage:model.message];
                }
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_replyListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _replyListCommand;
}
- (NSMutableArray *)replyArray {
    if (!_replyArray) {
        _replyArray = [NSMutableArray array];
    }
    return _replyArray;
}
- (RACCommand *)sendReplyCommand {
    if (!_sendReplyCommand) {
        @weakify(self)
        _sendReplyCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCGuessModuleAPI sendGuessComment:self.quiz_id message:input]];
        }];
        [_sendReplyCommand.executionSignals.flatten subscribeNext:^(LCReplySuccessModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                [self.replyArray insertObject:model.response atIndex:0];
                [self sendSuccessResult:10 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _sendReplyCommand;
}
- (RACCommand *)betGuessCommand {
    if (!_betGuessCommand) {
        @weakify(self)
        _betGuessCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCGuessModuleAPI betGuessMessage:self.quiz_id period_id:self.period_id betting_num:input]];
        }];
        [_betGuessCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
                [self sendSuccessResult:20 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _betGuessCommand;
}
@end
