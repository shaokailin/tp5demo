//
//  LCPushGuessViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/28.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPushGuessViewModel.h"
#import "LCGuessModuleAPI.h"
#import "LSKBaseResponseModel.h"
@interface LCPushGuessViewModel ()
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) RACCommand *pushCommand;
@end
@implementation LCPushGuessViewModel
- (void)pushGuessEvent:(NSString *)answer {
    if (!KJudgeIsNullData(self.title)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入标题"];
        return;
    }
    
    if (!KJudgeIsNullData(self.content)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入内容"];
        return;
    }
    if (!KJudgeIsNullData(answer)) {
        if (self.type == 3) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请选择要竞猜的大小"];
            return;
        }else {
            [SKHUD showMessageInView:self.currentView withMessage:@"请选择必杀的2个数字"];
            return;
        }
    }
    if (!KJudgeIsNullData(self.money) || [self.money integerValue] <= 0) {
        [SKHUD showMessageInView:self.currentView withMessage:@"竞猜金额要大于0金币"];
        return;
    }
    if (!KJudgeIsNullData(self.number) || [self.number integerValue] <= 0) {
        [SKHUD showMessageInView:self.currentView withMessage:@"竞猜份额要大于0"];
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.pushCommand execute:answer];
}
- (RACCommand *)pushCommand {
    if (!_pushCommand) {
        @weakify(self)
        _pushCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCGuessModuleAPI pushGuessEvent:self.type content:self.content answer:input money:self.money number:self.number title:self.title]];
        }];
        [_pushCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD showMessageInWindowWithMessage:@"发布成功~!"];
                [self.currentController.navigationController popViewControllerAnimated:YES];
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _pushCommand;
}
- (void)bindInputSignal {
    @weakify(self)
    [self.contentSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.content = x;
    }];
    [self.titleSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.title = x;
    }];
}
@end
