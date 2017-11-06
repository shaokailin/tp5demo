//
//  PPSSChangePwdViewModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/13.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSChangePwdViewModel.h"
#import "PPSSLoginAPI.h"
#import "LSKBaseResponseModel.h"
@interface PPSSChangePwdViewModel ()
@property (nonatomic, copy) NSString *passwordString;
@property (nonatomic, copy) NSString *oldString;
@property (nonatomic, copy) NSString *againPwdString;
@property (nonatomic, strong) RACCommand *changeCommand;
@end
@implementation PPSSChangePwdViewModel
//绑定事件
- (void)bindChangeSignal {
    @weakify(self)
    [[_oldSignal skip:1] subscribeNext:^(NSString *old) {
        @strongify(self)
        self.oldString = old;
    }];
    [[_passwordSignal skip:1] subscribeNext:^(NSString *pwd) {
        @strongify(self)
        self.passwordString = pwd;
    }];
    [_againPasswordSignal subscribeNext:^(NSString *againPwdString) {
        @strongify(self)
        self.againPwdString = againPwdString;
    }];
}

- (void)ChangePwdEvent {
    if (!KJudgeIsNullData(_oldString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入旧密码~!"];
        return;
    }
    if (_oldString.length < 6 || _oldString.length > 20) {
        [SKHUD showMessageInView:self.currentView withMessage:@"旧密码个数是6-20位~!"];
        return;
    }
    if (!KJudgeIsNullData(_passwordString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请输入新密码~!"];
        return;
    }
    if (_passwordString.length < 6 || _passwordString.length > 20) {
        [SKHUD showMessageInView:self.currentView withMessage:@"新密码个数是6-20位~!"];
        return;
    }
    if (!KJudgeIsNullData(self.againPwdString)) {
        [SKHUD showMessageInView:self.currentView withMessage:@"请再次输入新密码~!"];
        return;
    }
    if (![self.passwordString isEqualToString:self.againPwdString]) {
        [SKHUD showMessageInView:self.currentView withMessage:@"2次密码输入错误，请重新输入~!"];
        return;
    }
    [SKHUD showLoadingDotInView:self.currentView];
    [self.changeCommand execute:nil];
}
- (RACCommand *)changeCommand {
    if (!_changeCommand) {
        @weakify(self)
        _changeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[PPSSLoginAPI forgetPwdWithType:1 account:nil oldPwd:self.oldString password:self.passwordString code:nil]];
        }];
        [_changeCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.code == 0) {
                [SKHUD showMessageInView:self.currentView withMessage:@"修改密码成功!~"];
                NSString *oldPassword = [KUserMessageManager getLoginPassword];
                if (oldPassword) {
                    [KUserMessageManager setLoginPassword:self.passwordString];
                }
                [self sendSuccessResult:0 model:nil];
            }else {
                [SKHUD showMessageInView:self.currentView withMessage:model.msg];
            }
        }];
    }
    return _changeCommand;
}
@end
