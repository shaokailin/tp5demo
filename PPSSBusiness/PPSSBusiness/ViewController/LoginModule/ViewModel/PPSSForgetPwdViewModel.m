//
//  PPSSForgetPwdViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSForgetPwdViewModel.h"
#import "PPSSLoginAPI.h"
#import "LSKBaseResponseModel.h"
@interface PPSSForgetPwdViewModel ()
@property (nonatomic, copy) NSString *passwordString;
@property (nonatomic, copy) NSString *accountString;
@property (nonatomic, copy) NSString *codeString;
@property (nonatomic, strong) RACCommand *changeCommand;
@property (nonatomic, strong) RACCommand *sendCodeCommand;
@end
@implementation PPSSForgetPwdViewModel
//绑定事件
- (void)bindForgetSignal {
    @weakify(self)
    [[_accountSignal skip:1] subscribeNext:^(NSString *account) {
        @strongify(self)
        self.accountString = account;
    }];
    [[_passwordSignal skip:1] subscribeNext:^(NSString *pwd) {
        @strongify(self)
        self.passwordString = pwd;
    }];
    [_codeSignal subscribeNext:^(NSString *code) {
        @strongify(self)
        self.codeString = code;
    }];
}
#pragma mark - 修改密码
- (void)ChangeForgetPwdEvent {
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
    if (!KJudgeIsNullData(self.codeString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入短信验证码~!"];
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.changeCommand execute:nil];
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
- (RACCommand *)changeCommand {
    if (!_changeCommand) {
        @weakify(self)
        _changeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSLoginAPI forgetPwdWithType:2 account:self.accountString oldPwd:nil password:self.passwordString code:self.codeString]];
        }];
        [_changeCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 0) {
                [SKHUD showMessageInView:self.currentView withMessage:@"修改密码成功!~"];
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
    }
    return _changeCommand;
}
#pragma mark - 获取验证码
- (void)sendForgetCode {
    if (![self validateMobile]) {
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.sendCodeCommand execute:nil];
}
- (RACCommand *)sendCodeCommand {
    if (!_sendCodeCommand) {
        @weakify(self)
        _sendCodeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSLoginAPI sendVerificationCodeWithType:@"2" phone:self.accountString]];
        }];
        [_sendCodeCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 0) {
                [KUserMessageManager startForgetTimer];
                [SKHUD showMessageInView:self.currentView withMessage:@"验证码已发送，请注意查收"];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
    }
    return _sendCodeCommand;
}
@end
