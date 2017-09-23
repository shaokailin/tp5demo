//
//  PPSSLoginViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/15.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSLoginViewModel.h"
#import "PPSSLoginAPI.h"
#import "PPSSLoginModel.h"
@interface PPSSLoginViewModel ()
@property (nonatomic, copy) NSString *passwordString;
@property (nonatomic, copy) NSString *accountString;
@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, assign) BOOL isMemberPassword;
@end
@implementation PPSSLoginViewModel
- (void)userLoginClickEvent {
    if (![_accountString isHasValue]) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入账号"];
        return;
    }
    if (![_passwordString isHasValue]) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入密码"];
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.loginCommand execute:nil];
}
- (void)bindLoginSignal {
    @weakify(self)
    [[_accountSignal skip:1] subscribeNext:^(NSString *account) {
        @strongify(self)
        self.accountString = account;
    }];
    [[_passwordSignal skip:1] subscribeNext:^(NSString *pwd) {
        @strongify(self)
        self.passwordString = pwd;
    }];
    [_rememberSignal subscribeNext:^(NSNumber *isRemember) {
        @strongify(self)
        self.isMemberPassword = [isRemember boolValue];
    }];
}
- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        @weakify(self)
        _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSLoginAPI loginActionWith:self.accountString password:self.passwordString]];
        }];
        [_loginCommand.executionSignals.flatten subscribeNext:^(id  _Nullable x) {
           @strongify(self)
            LSKLog(@"%d",self.isMemberPassword);
        }];
    }
    return _loginCommand;
}

@end
