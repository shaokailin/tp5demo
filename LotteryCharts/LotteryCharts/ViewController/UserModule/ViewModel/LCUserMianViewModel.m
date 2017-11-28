//
//  LCUserMianViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/28.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMianViewModel.h"
#import "LCLoginModuleAPI.h"
#import "LSKBaseResponseModel.h"
#import "AppDelegate.h"
@interface LCUserMianViewModel()
@property (nonatomic, strong) RACCommand *loginOutCommand;
@end
@implementation LCUserMianViewModel
- (void)loginOutClickEvent {
    [SKHUD showLoadingDotInWindow];
    [self.loginOutCommand execute:nil];
}
- (RACCommand *)loginOutCommand {
    if (!_loginOutCommand) {
        @weakify(self)
        _loginOutCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCLoginModuleAPI loginOutEvent:kUserMessageManager.token]];
        }];
        [_loginOutCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [kUserMessageManager removeUserMessage];
                [SKHUD showMessageInWindowWithMessage:@"退出成功~!"];
                [((AppDelegate *)[UIApplication sharedApplication].delegate)changeLoginState];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _loginOutCommand;
}
@end
