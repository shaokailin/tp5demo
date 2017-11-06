//
//  PPSSForgetMainView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/11.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSForgetMainView.h"

@implementation PPSSForgetMainView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_WHITECOLOR;
        self.layer.cornerRadius = 5.0;
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIImageView *topIconImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"forget_icon")];
    [self addSubview:topIconImageView];
    WS(ws)
    [topIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.width.mas_equalTo(186 / 2.0);
        make.top.equalTo(ws).with.offset(30);
    }];
    //登录账号
    PPSSLoginInputView *accountField = [[PPSSLoginInputView alloc]initInputViewWithType:LoginInputType_Account icon:@"login_user_icon" placeholder:@"请输入账号"];
    self.accountField = accountField;
    [self addSubview:accountField];
    [accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topIconImageView.mas_bottom).with.offset(22);
        make.left.equalTo(ws).with.offset(22);
        make.right.equalTo(ws).with.offset(-22);
        make.height.mas_equalTo(50);
    }];
    PPSSLoginCodeView *codeField = [[PPSSLoginCodeView alloc]initWithType:LoginCodeType_Forget block:^(BOOL code) {
        ws.isGetCode = YES;
    }];
    self.codeField = codeField;
    [self addSubview:codeField];
    [codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountField.mas_bottom).with.offset(10);
        make.left.equalTo(accountField.mas_left);
        make.right.equalTo(accountField.mas_right);
        make.height.equalTo(accountField.mas_height);
    }];
    //密码
    PPSSLoginInputView *passwordField = [[PPSSLoginInputView alloc]initInputViewWithType:LoginInputType_Password icon:@"login_psd_icon" placeholder:@"请输入密码"];
    self.passwordField = passwordField;
    [self addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeField.mas_bottom).with.offset(10);
        make.left.equalTo(accountField.mas_left);
        make.right.equalTo(accountField.mas_right);
        make.height.equalTo(accountField.mas_height);
    }];
    
    UIButton *sureBtn = [PPSSPublicViewManager initAPPThemeBtn:@"确定提交" font:18 target:nil action:nil];
    self.sureBtn = sureBtn;
    ViewRadius(sureBtn, 5.0);
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(passwordField);
        make.top.equalTo(passwordField.mas_bottom).with.offset(WIDTH_RACE_6S(65));
        make.height.mas_equalTo(44);
    }];
}
@end
