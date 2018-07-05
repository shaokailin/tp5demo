//
//  LCPostDetailViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostDetailViewModel.h"
#import "LCHomeModuleAPI.h"
#import "LCUserModuleAPI.h"
#import "LCGuessModuleAPI.h"
@interface LCPostDetailViewModel ()
@property (nonatomic, strong) RACCommand *isPayCommand;
@property (nonatomic, strong) RACCommand *postDetailCommand;
@property (nonatomic, strong) RACCommand *replyListCommand;
@property (nonatomic, strong) RACCommand *sendReplyCommand;
@property (nonatomic, strong) RACCommand *rewardCommand;
@property (nonatomic, strong) RACCommand *attentionCommand;
@property (nonatomic, strong) RACCommand *payCommand;
@property (nonatomic, strong) RACCommand *commentCommand;
@property (nonatomic, strong) RACCommand *guessSendReplyConmand;
@property (nonatomic, strong) RACCommand *zanCommand;
@property (nonatomic, assign) BOOL flag;

@end
@implementation LCPostDetailViewModel
- (void)getPostDetail:(BOOL)isPull {
    _page = 0;
    self.flag = isPull;
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.postDetailCommand execute:nil];
}
- (void)payForShowEvent {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.payCommand execute:nil];
}
- (void)getReplyList {
    _page += 1;
    if (self.flag) {
        _page = 0;
    }
    self.flag =NO;
    [self.replyListCommand execute:nil];
}
- (void)sendReplyText:(NSString *)content {
    NSString *message = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!KJudgeIsNullData(message)) {
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    if (self.replyType == 0) {
        [self.sendReplyCommand execute:message];
    }else {
        [self.guessSendReplyConmand execute:message];
    }
    
}
- (void)rewardPostMoney:(NSString *)money {
    if (!KJudgeIsNullData(money) || [money integerValue] <= 0) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入要打赏的金额"];
        return;
    }
    [self.rewardCommand execute:money];
}

- (RACCommand *)isPayCommand {
    if (!_isPayCommand) {
        @weakify(self)
        _isPayCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI needPayForShowPost:self.postId]];
        }];
        [_isPayCommand.executionSignals.flatten subscribeNext:^(LCPostDetailMessageModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [self.postDetailCommand execute:nil];
            }else {
                [SKHUD dismiss];
                [self sendSuccessResult:200 model:model.response];
            }
        }];
    }
    return _isPayCommand;
}
- (RACCommand *)postDetailCommand {
    if (!_postDetailCommand) {
        @weakify(self)
        _postDetailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getPostDetail:self.postId]];
        }];
        [_postDetailCommand.executionSignals.flatten subscribeNext:^(LCPostDetailModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self->_replyArray && self->_replyArray.count > 0) {
                    [self->_replyArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.reply_list)) {
                    [self.replyArray addObjectsFromArray:model.reply_list];
                }
                [self sendSuccessResult:0 model:model];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
                [self sendFailureResult:1 error:nil];
            }
        }];
    }
    return _postDetailCommand;
}
- (RACCommand *)replyListCommand {
    if (!_replyListCommand) {
        @weakify(self)
        _page = 0;
        
        _replyListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
         
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getPostReplyList:self.page postId:self.postId]];
        }];
        [_replyListCommand.executionSignals.flatten subscribeNext:^(LCPostReplyListModel *model) {
            @strongify(self)
            if (model.code == 200) {
//                [SKHUD dismiss];
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.replyArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:1 model:nil];
                
            }else {
                if (self.page != 0) {
                    self.page --;
                }
                [self sendFailureResult:1 error:nil];
            }
        }];
        [_replyListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:1 error:nil];
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
            return [self requestWithPropertyEntity:[LCHomeModuleAPI sendPostReply:input type:self.type targetId:self.target postId:self.postId]];
        }];
        [_sendReplyCommand.executionSignals.flatten subscribeNext:^(LCPostReplySuccessModel *model) {
            @strongify(self)
            if (model.code == 200) {
                if (self.isNeedSend) {
                    [self.postDetailCommand execute:nil];
                }else {
                    [SKHUD dismiss];
                }
                if (self.type == 0) {
                     [self getPostDetail:YES];
                }else {
                    [self.replyArray addObject:model.response];
                    [self sendSuccessResult:10 model:nil];
                }
               

            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _sendReplyCommand;
}
- (RACCommand *)rewardCommand {
    if (!_rewardCommand) {
        @weakify(self)
        _rewardCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI rewardPostMoney:input postId:self.postId]];
        }];
        [_rewardCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:@"打赏成功~!"];
                [self sendSuccessResult:20 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _rewardCommand;
}
- (void)attentionPost:(BOOL)isAttention {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.attentionCommand execute:@(isAttention)];
}
- (RACCommand *)attentionCommand {
    if (!_attentionCommand) {
        @weakify(self)
        _attentionCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI attentionUser:self.userId isCare:[input boolValue]]];
        }];
        [_attentionCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
                [self sendSuccessResult:30 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _attentionCommand;
}
- (RACCommand *)payCommand {
    if (!_payCommand) {
        @weakify(self)
        _payCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI payPostForShow:self.postId]];
        }];
        [_payCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [self.postDetailCommand execute:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
                [self sendFailureResult:0 error:nil];
            }
        }];
    }
    return _payCommand;
}

- (void)getCommentReplyList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.commentCommand execute:nil];
}
- (RACCommand *)commentCommand {
    if (!_commentCommand) {
        @weakify(self)
        _page = 0;
        _commentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            if (self.replyType == 0) {
                return [self requestWithPropertyEntity:[LCHomeModuleAPI getReplyList:self.page commentId:self.target]];
            }else {
                return [self requestWithPropertyEntity:[LCGuessModuleAPI getReplyGuessList:self.page commentId:self.target]];
            }
            
        }];
        [_commentCommand.executionSignals.flatten subscribeNext:^(LCPostReplyListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self.page == 0) {
                    [self.replyArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.replyArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:1 model:nil];
                
            }else {
                if (self.page != 0) {
                    self.page --;
                }
                [self sendFailureResult:1 error:nil];
            }
        }];
        [_commentCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:1 error:nil];
        }];
    }
    return _commentCommand;
}

- (RACCommand *)guessSendReplyConmand {
    if (!_guessSendReplyConmand) {
        @weakify(self)
        _guessSendReplyConmand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCGuessModuleAPI sendGuessComment:self.postId target_id:self.target target_type:self.type message:input]];
        }];
        [_guessSendReplyConmand.executionSignals.flatten subscribeNext:^(LCPostReplySuccessModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self.page == 0) {
                    [self.replyArray removeAllObjects];
                }
                [self.replyArray addObject:model.response];
                [self sendSuccessResult:10 model:nil];
                
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _guessSendReplyConmand;
}

- (void)zanClick {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.zanCommand execute:nil];
}
- (RACCommand *)zanCommand {
    if (!_zanCommand) {
        @weakify(self)
        _zanCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI zanPost:self.postId]];
        }];
        [_zanCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
                [self sendSuccessResult:50 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _zanCommand;
}
@end
