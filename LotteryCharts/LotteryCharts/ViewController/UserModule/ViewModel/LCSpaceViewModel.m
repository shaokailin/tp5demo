//
//  LCSpaceViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpaceViewModel.h"
#import "LCUserModuleAPI.h"
#import "LCSpaceModel.h"
@interface LCSpaceViewModel ()
@property (nonatomic, strong) RACCommand *attentionCommand;
@property (nonatomic, strong) RACCommand *spaceCommand;
@end
@implementation LCSpaceViewModel
- (void)getSpaceData:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.spaceCommand execute:nil];
}
- (RACCommand *)spaceCommand {
    if (!_spaceCommand) {
        @weakify(self)
        _spaceCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI spaceMessageDataWith:self.uid page:self.page showType:self.showType]];
        }];
        [_spaceCommand.executionSignals.flatten subscribeNext:^(LCSpaceModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self.page == 0) {
                    [self.dataArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.data)) {
                    [self.dataArray addObjectsFromArray:model.data];
                }
                [self sendSuccessResult:0 model:model];
            }else {
                [self loadError];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_spaceCommand.errors subscribeNext:^(NSError * _Nullable x) {
           @strongify(self)
            [self loadError];
            [self sendFailureResult:1 error:nil];
        }];
    }
    return _spaceCommand;
}
- (void)loadError {
    if (self.page == 0 && _dataArray && _dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    if (self.page != 0) {
        self.page --;
    }
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)attentionUserClick {
    [SKHUD showLoadingDotInWindow];
    [self.attentionCommand execute:nil];
}
- (RACCommand *)attentionCommand {
    if (!_attentionCommand) {
        @weakify(self)
          _attentionCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
             @strongify(self)
              return [self requestWithPropertyEntity:[LCUserModuleAPI attentionUser:self.uid isCare:self.isCare]];
        }];
        [_attentionCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                if (self.isCare) {
                    [SKHUD showMessageInView:self.currentView withMessage:@"取消关注成功"];
                }else {
                    [SKHUD showMessageInView:self.currentView withMessage:@"关注成功"];
                }
                self.isCare = !self.isCare;
                [self sendSuccessResult:100 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _attentionCommand;
}
@end
