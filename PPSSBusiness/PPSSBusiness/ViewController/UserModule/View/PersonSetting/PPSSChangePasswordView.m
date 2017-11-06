//
//  PPSSChangePasswordView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/22.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSChangePasswordView.h"

@implementation PPSSChangePasswordView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_WHITECOLOR;
        self.layer.cornerRadius = 5.0;
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIImageView *topIconImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"changpwd_icon")];
    [self addSubview:topIconImageView];
    WS(ws)
    [topIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(ws).with.offset(30);
    }];
    //密码
    PPSSLoginInputView *currentPasswordField = [[PPSSLoginInputView alloc]initInputViewWithType:LoginInputType_Password icon:@"login_psd_icon" placeholder:@"请输入当前密码"];
    self.currentPasswordField = currentPasswordField;
    [self addSubview:currentPasswordField];
    [currentPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topIconImageView.mas_bottom).with.offset(23);
        make.left.equalTo(ws).with.offset(22);
        make.right.equalTo(ws).with.offset(-22);
        make.height.mas_equalTo(50);
    }];
    //密码
    PPSSLoginInputView *passwordField = [[PPSSLoginInputView alloc]initInputViewWithType:LoginInputType_Password icon:@"login_psd_icon" placeholder:@"请输入新密码"];
    self.passwordField = passwordField;
    [self addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currentPasswordField.mas_bottom).with.offset(10);
        make.left.equalTo(currentPasswordField.mas_left);
        make.right.equalTo(currentPasswordField.mas_right);
        make.height.equalTo(currentPasswordField.mas_height);
    }];
    //密码
    PPSSLoginInputView *againPasswordField = [[PPSSLoginInputView alloc]initInputViewWithType:LoginInputType_Password icon:@"login_psd_icon" placeholder:@"请再次输入新密码"];
    self.againPasswordField = againPasswordField;
    [self addSubview:againPasswordField];
    [againPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordField.mas_bottom).with.offset(10);
        make.left.equalTo(passwordField.mas_left);
        make.right.equalTo(passwordField.mas_right);
        make.height.equalTo(passwordField.mas_height);
    }];

    UIButton *loginBtn = [PPSSPublicViewManager initAPPThemeBtn:@"确认修改" font:18 target:nil action:nil];
    self.sureBtn = loginBtn;
    ViewRadius(loginBtn, 5.0);
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(passwordField);
        make.top.equalTo(againPasswordField.mas_bottom).with.offset(WIDTH_RACE_6S(65));
        make.height.mas_equalTo(44);
    }];
}
@end
