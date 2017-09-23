//
//  PPSSLoginMainView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSLoginMainView.h"
@interface PPSSLoginMainView ()
@property (nonatomic, weak) UIButton *checkBtn;
@end
@implementation PPSSLoginMainView
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_WHITECOLOR;
        self.layer.cornerRadius = 5.0;
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIImageView *topIconImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"login_top_icon")];
    [self addSubview:topIconImageView];
    WS(ws)
    [topIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(ws).with.offset(30);
    }];
    //登录账号
    PPSSLoginInputView *accountField = [[PPSSLoginInputView alloc]initInputViewWithType:LoginInputType_Account icon:@"login_user_icon" placeholder:@"请输入账号"];
    self.accountField = accountField;
    [self addSubview:accountField];
    [accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topIconImageView.mas_bottom).with.offset(23);
        make.left.equalTo(ws).with.offset(22);
        make.right.equalTo(ws).with.offset(-22);
        make.height.mas_equalTo(50);
    }];
    //密码
    PPSSLoginInputView *passwordField = [[PPSSLoginInputView alloc]initInputViewWithType:LoginInputType_Password icon:@"login_psd_icon" placeholder:@"请输入密码"];
    self.passwordField = passwordField;
    [self addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountField.mas_bottom).with.offset(10);
        make.left.equalTo(accountField.mas_left);
        make.right.equalTo(accountField.mas_right);
        make.height.equalTo(accountField.mas_height);
    }];
    UIButton *checkBtn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:@"login_check_n" selectedImage:@"login_check_s" target:nil action:nil textfont:0 textColor:nil backgroundColor:nil backgroundImage:nil];
    self.checkBtn = checkBtn;
    checkBtn.selected = YES;
    self.rememberPwd = YES;
    [self addSubview:_checkBtn];
    [[_checkBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        ws.checkBtn.selected = !ws.checkBtn.selected;
        ws.rememberPwd = ws.checkBtn.selected;
    }];
    CGFloat btnWidth = 16 + 8;
    [_checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordField.mas_left);
        make.top.equalTo(passwordField.mas_bottom).with.offset(23);
        make.size.mas_equalTo (CGSizeMake(btnWidth,btnWidth));
    }];
    UILabel *checkTitleLbl = [LSKViewFactory initializeLableWithText:@"记住登录" font:12 textColor:ColorHexadecimal(Color_Text_6666, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:checkTitleLbl];
    [checkTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.checkBtn.mas_right);
        make.centerY.equalTo(ws.checkBtn.mas_centerY);
    }];
    UIButton *loginBtn = [PPSSPublicViewManager initAPPThemeBtn:@"登录" font:18 target:nil action:nil];
    self.loginBtn = loginBtn;
    ViewRadius(loginBtn, 5.0);
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(passwordField);
        make.top.equalTo(ws.checkBtn.mas_bottom).with.offset(42);
        make.height.mas_equalTo(44);
    }];
}
@end
