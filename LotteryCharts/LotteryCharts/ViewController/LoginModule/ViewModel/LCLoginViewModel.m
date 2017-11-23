//
//  LCLoginViewModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/23.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCLoginViewModel.h"
#import "LCLoginModuleAPI.h"
#import "LCLoginMainModel.h"
#import "LCUserMessageModel.h"
@interface LCLoginViewModel ()
@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACCommand *getUserMessageCommand;
@property (nonatomic, copy) NSString *phoneString;
@property (nonatomic, copy) NSString *passwordString;
@property (nonatomic, copy) NSString *userToken;
@end
@implementation LCLoginViewModel
- (void)loginEventClick {
    if (!KJudgeIsNullData(self.phoneString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入手机号"];
        return;
    }
    if (!KJudgeIsNullData(self.passwordString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入密码"];
        return;
    }
    if (![self.phoneString validateMobilePhone]) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入正确的手机号"];
        return;
    }
    if (self.passwordString.length < 6) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入至少6位密码"];
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.loginCommand execute:nil];
}
- (void)bindLoginSignal {
    @weakify(self)
    [[self.phoneSignal skip:1] subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        self.phoneString = x;
    }];
    [[self.pwdSignal skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.passwordString = x;
    }];
}
- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        @weakify(self)
        _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCLoginModuleAPI loginUserWithPhone:self.phoneString pwd:self.passwordString]];
        }];
        [_loginCommand.executionSignals.flatten subscribeNext:^(LCLoginMainModel *model) {
            @strongify(self)
            if (model.code == 200) {
                if (KJudgeIsNullData(model.response)) {
                    self.userToken = model.response;
                }else {
                    [SKHUD showMessageInView:self.currentView withMessage:@"系统出错啦~!"];
                }
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _loginCommand;
}
- (void)getUserMessage {
    [self.getUserMessageCommand execute:nil];
}
- (RACCommand *)getUserMessageCommand {
    if (!_getUserMessageCommand) {
        @weakify(self)
        _getUserMessageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCLoginModuleAPI getUserMessageForLogin:self.userToken]];
        }];
        [_getUserMessageCommand.executionSignals.flatten subscribeNext:^(LCUserMessageModel *model) {
            @strongify(self)
            if (model.code == 200) {
                
            }else {
                self.userToken = nil;
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
        [_getUserMessageCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            self.userToken = nil;
        }];
    }
    return _getUserMessageCommand;
}
@end
