//
//  LCHomeMainViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeMainViewModel.h"
#import "LCHomeModuleAPI.h"
#import "LCBaseResponseModel.h"
#import "LCHomeHotListModel.h"
#import "LCLotteryFiveModel.h"
#import "LCGuessModuleAPI.h"
@interface LCHomeMainViewModel ()
@property (nonatomic, strong) RACCommand *onlineCommand;
@property (nonatomic, strong) RACCommand *headerMessageCommand;
@property (nonatomic, strong) RACCommand *hotCommand;
@property (nonatomic, strong) RACCommand *lotteryFiveCommand;

@property (nonatomic, strong) RACCommand *searchCommand;
@property (nonatomic, strong) RACCommand *searchUserId;
@property (nonatomic, strong) RACCommand *searchPost;
@property (nonatomic, strong) RACCommand *searchGuess;
@end
@implementation LCHomeMainViewModel
- (void)getHomeMessage:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInWindow];
    }
    if (self.page == 0) {
        [self.onlineCommand execute:nil];
        [self.headerMessageCommand execute:nil];
        [self.lotteryFiveCommand execute:nil];
    }
    [self.hotCommand execute:nil];
}
- (void)bindSinal {
    _page = 0;
    [[[self.onlineCommand.executionSignals.flatten zipWith:self.headerMessageCommand.executionSignals.flatten]zipWith:self.hotCommand.executionSignals.flatten] subscribeNext:^(RACTwoTuple<RACTwoTuple<NSNumber *,id> *,id> * _Nullable x) {
        [SKHUD dismiss];
    }];
}
- (RACCommand *)hotCommand {
    if (!_hotCommand) {
        @weakify(self)
        _hotCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getHotPostList:self.page]];
        }];
        [_hotCommand.executionSignals.flatten subscribeNext:^(LCHomeHotListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self->_hotPostArray && self->_page == 0) {
                    [self->_hotPostArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.hotPostArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                if (self.page != 0) {
                    self.page --;
                }
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_hotCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            if (self.page != 0) {
                self.page --;
            }
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _hotCommand;
}
- (NSMutableArray *)hotPostArray {
    if (!_hotPostArray) {
        _hotPostArray = [NSMutableArray array];
    }
    return _hotPostArray;
}
- (RACCommand *)onlineCommand {
    if (!_onlineCommand) {
        @weakify(self)
        _onlineCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getOnLineAll]];
        }];
        [_onlineCommand.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [self sendSuccessResult:10 model:model.response];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _onlineCommand;
}
- (RACCommand *)lotteryFiveCommand {
    if (!_lotteryFiveCommand) {
        @weakify(self)
        _lotteryFiveCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getLastLotteryFive]];
        }];
        [_lotteryFiveCommand.executionSignals.flatten subscribeNext:^(LCLotteryFiveModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [self sendSuccessResult:80 model:model];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _lotteryFiveCommand;
    
}
- (RACCommand *)headerMessageCommand {
    if (!_headerMessageCommand) {
        @weakify(self)
        _headerMessageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getHomeHeaderMessage]];
        }];
        [_headerMessageCommand.executionSignals.flatten subscribeNext:^(LCHomeHeaderMessageModel *model) {
            @strongify(self)
            if (model.code == 200) {
                self.messageModel = model;
                [self sendSuccessResult:20 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _headerMessageCommand;
}
- (void)searchPostEvent:(NSString *)test {
    self.searchText = [test stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!KJudgeIsNullData(self.searchText)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入搜索内容"];
        return;
    }
    [SKHUD showLoadingDotInWindow];
    if (self.searchType == 0) {
        [self.searchCommand execute:nil];
    }else if (self.searchType == 1){
        [self.searchUserId execute:nil];
    }else if(self.searchType == 2) {
        [self.searchPost execute:nil];
    }else {
        [self.searchGuess execute:nil];
    }
}
- (RACCommand *)searchPost {
    if (!_searchPost) {
        @weakify(self)
        _searchPost = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getPostDetail:self.searchText]];
        }];
        [_searchPost.executionSignals.flatten subscribeNext:^(LCPostDetailModel *model) {
            @strongify(self)
            if (model.code == 200 && KJudgeIsNullData(model.post_id)) {
                [SKHUD dismiss];
                [self sendSuccessResult:70 model:model];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:@"查无数据"];
            }
        }];
    }
    return _searchPost;
}
- (RACCommand *)searchGuess {
    if (!_searchGuess) {
        @weakify(self)
        _searchGuess = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCGuessModuleAPI getGuessDetail:self.searchText]];
        }];
        [_searchGuess.executionSignals.flatten subscribeNext:^(LCGuessDetailModel *model) {
            @strongify(self)
            if (model.code == 200 && KJudgeIsNullData(model.response.quiz_id)) {
                [SKHUD dismiss];
                [self sendSuccessResult:90 model:model.response];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:@"查无数据"];
            }
        }];
    }
    return _searchGuess;
}
- (RACCommand *)searchCommand {
    if (!_searchCommand) {
        @weakify(self)
        _searchCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getSearchPostList:self.searchText page:0]];
        }];
        [_searchCommand.executionSignals.flatten subscribeNext:^(LCHomeHotListModel *model) {
            @strongify(self)
            if (model.code == 200 && KJudgeIsArrayAndHasValue(model.response)) {
                [SKHUD dismiss];
                [self sendSuccessResult:60 model:model.response];
            }else {
                 [SKHUD showMessageInView:self.currentView withMessage:@"查无数据"];
            }
        }];
    }
    return _searchCommand;
}
- (RACCommand *)searchUserId {
    if (!_searchUserId) {
        @weakify(self)
        _searchUserId = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getUserUid:self.searchText]];
        }];
        [_searchUserId.executionSignals.flatten subscribeNext:^(LCBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200 && KJudgeIsNullData(model.response)) {
                [SKHUD dismiss];
                [self sendSuccessResult:50 model:model.response];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:@"查无数据"];
            }
        }];
    }
    return _searchUserId;
}
@end
