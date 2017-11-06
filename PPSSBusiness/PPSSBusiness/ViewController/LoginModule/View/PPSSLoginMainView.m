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
@property (nonatomic, weak) UILabel *errorLbl;
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
        make.width.mas_equalTo(75);
        make.top.equalTo(ws).with.offset(30);
    }];
    //登录账号
    PPSSLoginInputView *accountField = [[PPSSLoginInputView alloc]initInputViewWithType:LoginInputType_Account icon:@"login_user_icon" placeholder:@"请输入账号"];
    self.accountField = accountField;
    self.accountField.text = [KUserMessageManager getLoginAccount];
    [self addSubview:accountField];
    [accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topIconImageView.mas_bottom).with.offset(22);
        make.left.equalTo(ws).with.offset(22);
        make.right.equalTo(ws).with.offset(-22);
        make.height.mas_equalTo(50);
    }];
    //密码
    PPSSLoginInputView *passwordField = [[PPSSLoginInputView alloc]initInputViewWithType:LoginInputType_Password icon:@"login_psd_icon" placeholder:@"请输入密码"];
    self.passwordField = passwordField;
    self.passwordField.text = [KUserMessageManager getLoginPassword];
    [self addSubview:passwordField];
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountField.mas_bottom).with.offset(10);
        make.left.equalTo(accountField.mas_left);
        make.right.equalTo(accountField.mas_right);
        make.height.equalTo(accountField.mas_height);
    }];
    
    UILabel *errorLbl = [LSKViewFactory initializeLableWithText:@"用户名或密码错误" font:12 textColor:ColorHexadecimal(0xfd5162, 1.0) textAlignment:1 backgroundColor:nil];
    errorLbl.hidden = YES;
    self.errorLbl = errorLbl;
    [self addSubview:errorLbl];
    [errorLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(passwordField.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *checkBtn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:@"login_check_n" selectedImage:@"login_check_s" target:nil action:nil textfont:0 textColor:nil backgroundColor:nil backgroundImage:nil];
    self.checkBtn = checkBtn;
    if (KJudgeIsNullData(self.passwordField.text)) {
        checkBtn.selected = YES;
        self.rememberPwd = YES;
    }else {
        checkBtn.selected = NO;
        self.rememberPwd = NO;
    }
    [self addSubview:_checkBtn];
    [[_checkBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        ws.checkBtn.selected = !ws.checkBtn.selected;
        ws.rememberPwd = ws.checkBtn.selected;
    }];
    CGFloat btnWidth = 30;
    [_checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordField.mas_left);
        make.top.equalTo(errorLbl.mas_bottom);
        make.size.mas_equalTo (CGSizeMake(btnWidth,btnWidth));
    }];
    UILabel *checkTitleLbl = [LSKViewFactory initializeLableWithText:@"记住登录密码" font:12 textColor:ColorHexadecimal(Color_Text_6666, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:checkTitleLbl];
    [checkTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.checkBtn.mas_right);
        make.centerY.equalTo(ws.checkBtn.mas_centerY);
    }];
    
    UIButton *forgetBtn = [LSKViewFactory initializeButtonWithTitle:@"忘记密码" nornalImage:nil selectedImage:nil target:nil action:nil textfont:12 textColor:ColorHexadecimal(0x3c9efa, 1.0) backgroundColor:nil backgroundImage:nil];
    self.forgetBtn = forgetBtn;
    [self addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(passwordField.mas_right);
        make.height.mas_equalTo(btnWidth);
        make.centerY.equalTo(checkBtn);
    }];
    
    UIButton *loginBtn = [PPSSPublicViewManager initAPPThemeBtn:@"登录" font:18 target:nil action:nil];
    self.loginBtn = loginBtn;
    ViewRadius(loginBtn, 5.0);
    [self addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(passwordField);
        make.top.equalTo(ws.checkBtn.mas_bottom).with.offset(27);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *phoneLbl = [PPSSPublicViewManager initLblForColor6666:NSStringFormat(@"客服电话：%@",kCompanyService_Phone)];
    [self addSubview:phoneLbl];
    [phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottom).with.offset(-28);
        make.centerX.equalTo(ws);
    }];
    UILabel *copyrightLbl = [PPSSPublicViewManager initLblForColor9999:kCompanyCopyright_Title];
    [self addSubview:copyrightLbl];
    [copyrightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(phoneLbl.mas_top).with.offset(-8);
        make.centerX.equalTo(phoneLbl);
    }];
    
}

- (PPSSLoginCodeView *)codeField {
    if (!_codeField) {
        WS(ws)
        PPSSLoginCodeView *codeField = [[PPSSLoginCodeView alloc]initWithType:LoginCodeType_Login block:^(BOOL code) {
            ws.isGetCode = YES;
        }];
        _codeField = codeField;
        [self addSubview:codeField];
        [codeField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.passwordField.mas_bottom).with.offset(10);
            make.left.equalTo(ws.accountField.mas_left);
            make.right.equalTo(ws.accountField.mas_right);
            make.height.equalTo(ws.accountField.mas_height);
        }];
        [self.errorLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws);
            make.top.equalTo(codeField.mas_bottom);
            make.height.mas_equalTo(30);
        }];
    }
    return _codeField;
}

- (void)bindErrorSignal:(RACSignal *)loginErrorSignal{
    [loginErrorSignal subscribeNext:^(NSNumber *count) {
        NSInteger countInt = [count integerValue];
        if (countInt == 5) {
            self.codeField.hidden = NO;
        }
        self.errorLbl.hidden = NO;
        [self performSelector:@selector(hidenError) withObject:nil afterDelay:1.5];
    }];
}
- (void)hidenError {
    self.errorLbl.hidden = YES;
}
@end
