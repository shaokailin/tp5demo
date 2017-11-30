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
#import "LCUserLoginMessageModel.h"
#import "AppDelegate.h"
@interface LCLoginViewModel ()
@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACCommand *getUserMessageCommand;
@property (nonatomic, copy) NSString *phoneString;
@property (nonatomic, copy) NSString *passwordString;
@property (nonatomic, copy) NSString *codeString;
@property (nonatomic, copy) NSString *mchidString;
@property (nonatomic, copy) NSString *authString;
@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, strong) RACCommand *registerCommand;
@property (nonatomic, strong) RACCommand *codeCommand;
@property (nonatomic, strong) RACCommand *forgetStep1Command;
@property (nonatomic, strong) RACCommand *forgetStep2Command;
@end
@implementation LCLoginViewModel
- (void)loginEventClick {
    if (![self verifyPhoneAndPwd]) {
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.loginCommand execute:nil];
}
- (BOOL)verifyPhoneAndPwd {
    if (![self verifyPhone]) {
        return NO;
    }
    if (!KJudgeIsNullData(self.passwordString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入密码"];
        return NO;
    }
    if (self.passwordString.length < 6) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入至少6位密码"];
        return NO;
    }
    return YES;
}
- (BOOL)verifyPhone {
    if (!KJudgeIsNullData(self.phoneString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入手机号"];
        return NO;
    }
    if (![self.phoneString validateMobilePhone]) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入正确的手机号"];
        return NO;
    }
    
    return YES;
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
                    [self.getUserMessageCommand execute:nil];
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
        [_getUserMessageCommand.executionSignals.flatten subscribeNext:^(LCUserLoginMessageModel *model) {
            @strongify(self)
            
            if (model.code == 200) {
                [SKHUD dismiss];
                model.response.token = self.userToken;
                [kUserMessageManager saveUserMessage:model.response];
                [self sendSuccessResult:0 model:nil];
                [((AppDelegate *)[UIApplication sharedApplication].delegate) changeLoginState];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
            self.userToken = nil;
        }];
        [_getUserMessageCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            self.userToken = nil;
        }];
    }
    return _getUserMessageCommand;
}

#pragma mark 注册
- (void)bindRegisterSignal {
    [self bindLoginSignal];
    @weakify(self)
    [self.codeSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.codeString = x;
    }];
    [self.mchidSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.mchidString = x;
    }];
}
- (void)registerActionEvent {
    if (![self verifyPhoneAndPwd]) {
        return;
    }
    if (KJudgeIsNullData(self.mchidString) && self.mchidString.length != 6) {
        [SKHUD showMessageInView:self.currentView withMessage:@"码师ID为6位数字的格式~!"];
        return;
    }
    if (!KJudgeIsNullData(self.codeString) || self.codeString.length < 5) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入正确的验证码~!"];
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [ self.registerCommand execute:nil] ;
}
- (RACCommand *)registerCommand {
    if (!_registerCommand) {
        @weakify(self)
        _registerCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCLoginModuleAPI registerUserWithPhone:self.phoneString pwd:self.passwordString msid:self.mchidString code:self.codeString]];
        }];
        [_registerCommand.executionSignals.flatten subscribeNext:^(LCLoginMainModel *model) {
            @strongify(self)
            if (model.code == 200) {
                if (KJudgeIsNullData(model.response)) {
                    self.userToken = model.response;
                    [self.getUserMessageCommand execute:nil];
                }else {
                    [SKHUD showMessageInView:self.currentView withMessage:@"系统出错啦~!"];
                }
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _registerCommand;
}

- (void)getCodeEvent {
    if (![self verifyPhone]) {
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.codeCommand execute:nil];
}
- (RACCommand *)codeCommand {
    if (!_codeCommand) {
        @weakify(self)
        _codeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCLoginModuleAPI sendCodeWithPhone:self.phoneString]];
        }];
        [_codeCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD showMessageInView:self.currentView withMessage:@"验证码已发送，请注意查收"];
                [self sendSuccessResult:2 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _codeCommand;
}


#pragma mark 忘记密码
- (void)forgetActionEvent {
    if (![self verifyPhoneAndPwd]) {
        return;
    }
    if (![self.passwordString isEqualToString:self.mchidString]) {
        [SKHUD showMessageInView:self.currentView withMessage:@"输入的两次密码都不同~!"];
        return;
    }
    if (!KJudgeIsNullData(self.codeString) || self.codeString.length < 5) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入正确的验证码~!"];
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [ self.forgetStep1Command execute:nil] ;
}
- (void)bindForgetSignal {
    [self bindRegisterSignal];
}
- (RACCommand *)forgetStep1Command {
    if (!_forgetStep1Command) {
        @weakify(self)
        _forgetStep1Command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCLoginModuleAPI forgetPassword:self.phoneString code:self.codeString]];
        }];
        [_forgetStep1Command.executionSignals.flatten subscribeNext:^(LCLoginMainModel *model) {
            @strongify(self)
            if (model.code == 200) {
                if (KJudgeIsNullData(model.response)) {
                    self.authString = model.response;
                    [self.forgetStep2Command execute:nil];
                }else {
                    [SKHUD showMessageInView:self.currentView withMessage:@"系统出错啦~!"];
                }
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
        }];
    }
    return _forgetStep1Command;
}
- (RACCommand *)forgetStep2Command {
    if (!_forgetStep2Command) {
        @weakify(self)
        _forgetStep2Command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[LCLoginModuleAPI changePassword:self.phoneString passwod:self.passwordString auth:self.authString]];
        }];
        [_forgetStep2Command.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 200) {
                [SKHUD dismiss];
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.message];
            }
            self.authString = nil;
        }];
        [_forgetStep2Command.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            self.authString = nil;
        }];
    }
    return _forgetStep2Command;
}
@end
