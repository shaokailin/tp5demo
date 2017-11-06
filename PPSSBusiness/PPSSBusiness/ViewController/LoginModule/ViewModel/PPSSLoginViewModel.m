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
#import "AppDelegate.h"

@interface PPSSLoginViewModel ()
@property (nonatomic, copy) NSString *passwordString;
@property (nonatomic, copy) NSString *accountString;
@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACCommand *loginCodeCommand;
@property (nonatomic, assign) BOOL isMemberPassword;
@end
@implementation PPSSLoginViewModel
- (instancetype)init {
    if (self = [super init]) {
        _loginErrorCount = 0;
    }
    return self;
}
//绑定事件
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
#pragma mark - 登录事件
- (void)userLoginClickEvent {
    if (![self validateMobile]) {
        return;
    }
    if (!KJudgeIsNullData(_passwordString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入密码~!"];
        return;
    }
    if (_passwordString.length < 6 || _passwordString.length > 20) {
        [SKHUD showMessageInView:self.currentView withMessage:@"密码个数是6-20位~!"];
        return;
    }
    if (self.loginErrorCount >= 5) {
        if (!KJudgeIsNullData(_codeString)) {
            [SKHUD showMessageInView:self.currentView withMessage:@"请输入短信验证码~!"];
            return;
        }
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.loginCommand execute:nil];
}
- (BOOL)validateMobile {
    if (!KJudgeIsNullData(_accountString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入账号~!"];
        return NO;
    }
    if (![_accountString validateMobilePhone]) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入正确的手机号码~!"];
        return NO;
    }
    return YES;
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        @weakify(self)
        _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSLoginAPI loginActionWith:self.accountString password:self.passwordString code:self.loginErrorCount >= 5 ? self.codeString:nil]];
        }];
        [_loginCommand.executionSignals.flatten subscribeNext:^(PPSSLoginModel *model) {
           @strongify(self)
            if (model.code == 0) {
                if (KJudgeIsNullData(model.token)) {
                    if (self.type == 1) {
                        if (![KUserMessageManager.phone isEqualToString:self.accountString]) {
                            [KUserMessageManager removeUserMessage];
                            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                            [delegate delectFontSettingTabbar];
                        }
                    }
                    [KUserMessageManager saveLoginNumber:self.accountString pwd:self.passwordString isSave:self.isMemberPassword];
                    KUserMessageManager.loginModel = model;
                    [KUserMessageManager saveUserMessage:model];
                    [KUserMessageManager loginPushWithAlias:model.userId];
                    [self sendSuccessResult:0 model:nil];
                    
                }else {
                    [SKHUD showMessageInView:self.currentView withMessage:@"登录验证失败!请重试"];
                }
            }else if (model.code == 11){
                self.loginErrorCount += 1;
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
    }
    return _loginCommand;
}
#pragma mark 发送验证码
- (void)sendLoginCode {
    if (![self validateMobile]) {
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.loginCodeCommand execute:nil];
}
- (RACCommand *)loginCodeCommand {
    if (!_loginCodeCommand) {
        @weakify(self)
        _loginCodeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSLoginAPI sendVerificationCodeWithType:@"1" phone:self.accountString]];
        }];
        [_loginCodeCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 0) {
                [KUserMessageManager startLoginTimer];
                [SKHUD showMessageInView:self.currentView withMessage:@"验证码已发送，请注意查收"];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
    }
    return _loginCodeCommand;
}
@end
