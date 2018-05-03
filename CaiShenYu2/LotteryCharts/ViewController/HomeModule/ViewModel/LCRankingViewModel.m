//
//  LCRankingViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRankingViewModel.h"
#import "LCHomeModuleAPI.h"
@interface LCRankingViewModel ()
@property (nonatomic, strong) RACCommand *postListCommand;
@property (nonatomic, strong) RACCommand *postupCommand;
@end
@implementation LCRankingViewModel
- (void)getRankingList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.postListCommand execute: nil];
}
- (RACCommand *)postListCommand {
    if (!_postListCommand) {
        @weakify(self)
        _page = 0;
        _postListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI getPostRanking:self.page type:self.showType]];
        }];
        [_postListCommand.executionSignals.flatten subscribeNext:^(LCHomeRankingListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self.page == 0 && self->_postArray) {
                    [self->_postArray removeAllObjects];
                }
//                if (self.showType == 1) {
//                    LCRankingRenListModel *ren = (LCRankingRenListModel *)model;
//                    self.topArray = ren.viptoplist;
//                }
                if (KJudgeIsArrayAndHasValue(model.list)) {
                    [self.postArray addObjectsFromArray:model.list];
                }
                [self sendSuccessResult:0 model:model];
            }else {
                [self loadError];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_postListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _postListCommand;
}
- (void)loadError {
    if (self.page == 0 && _postArray && _postArray.count > 0) {
        [self.postArray removeAllObjects];
    }
    if (self.page != 0) {
        self.page --;
    }
}
- (NSMutableArray *)postArray {
    if (!_postArray) {
        _postArray = [NSMutableArray array];
    }
    return _postArray;
}

- (RACCommand *)postupCommand {
    if (!_postupCommand) {
        @weakify(self)
        _postupCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCHomeModuleAPI upPostVipRanking:self.postId money:self.money]];
        }];
        [_postupCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:@"抢榜成功"];
                self.page = 0;
                [self.postListCommand execute:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _postupCommand;
}
- (void)upPostViewRanging {
    [SKHUD showLoadingDotInView:self.currentView];
    [self.postupCommand execute:nil];
}
@end
