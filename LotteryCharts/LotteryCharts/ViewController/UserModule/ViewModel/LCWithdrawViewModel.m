//
//  LCWithdrawViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCWithdrawViewModel.h"
#import "LCUserModuleAPI.h"
@interface LCWithdrawViewModel ()
@property (nonatomic, copy) NSString *money;
@property (nonatomic, strong) RACCommand *widthdrawCommand;
@property (nonatomic, strong) RACCommand *recordCommand;
@end
@implementation LCWithdrawViewModel
- (void)bindSignal {
    @weakify(self)
    [self.moneySignal subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        self.money = x;
    }];
}
- (void)widthdrawActionEvent {
    if (!KJudgeIsNullData(self.money) || [self.money floatValue] <= 0) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入要提现的金额"];
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.widthdrawCommand execute:nil];
}
- (RACCommand *)widthdrawCommand {
    if (!_widthdrawCommand) {
        @weakify(self)
        _widthdrawCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI widthdrawMoney:self.money]];
        }];
        [_widthdrawCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD showMessageInWindowWithMessage:@"提交成功~!"];
                kUserMessageManager.sMoney = NSStringFormat(@"%zd",[kUserMessageManager.sMoney integerValue] - [self.money integerValue]);
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _widthdrawCommand;
}

- (void)getWidthdrawRecord:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.recordCommand execute: nil];
}
- (RACCommand *)recordCommand {
    if (!_recordCommand) {
        @weakify(self)
        _page = 0;
        _mouth = -1;
        _year = -1;
        _recordCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCUserModuleAPI widthdrawRecordList:self.page month:self.mouth year:self.year]];
        }];
        [_recordCommand.executionSignals.flatten subscribeNext:^(LCWithdrawRecordListModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                if (self.page == 0 && _historyArray) {
                    [_historyArray removeAllObjects];
                }
                if (KJudgeIsArrayAndHasValue(model.response)) {
                    [self.historyArray addObjectsFromArray:model.response];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                [self loadError];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_recordCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self loadError];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _recordCommand;
}
- (void)loadError {
    if (self.page == 0 && _historyArray && _historyArray.count > 0) {
        [self.historyArray removeAllObjects];
    }
    if (self.page != 0) {
        self.page --;
    }
}
- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSMutableArray array];
    }
    return _historyArray;
}


@end
