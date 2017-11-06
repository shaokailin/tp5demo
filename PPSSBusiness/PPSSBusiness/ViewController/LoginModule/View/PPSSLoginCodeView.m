//
//  PPSSLoginCodeView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/11.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSLoginCodeView.h"
static const NSInteger kCodeLIMITLENGTH = 5;
@implementation PPSSLoginCodeView
{
    UIButton *_codeBtn;
    LoginCodeType _codeType;
    VerifiCodeBlock _block;
}
- (instancetype)initWithType:(LoginCodeType)type block:(VerifiCodeBlock )block {
    if (self = [super init]) {
        _codeType = type;
        _block = block;
        [self _layoutMainView];
        
    }
    return self;
}
- (void)_layoutMainView {
    self.layer.cornerRadius = 5.0;
    self.placeholder = @"短信验证码";
    self.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
    self.font = FontNornalInit(12);
    [self setValue:ColorHexadecimal(Color_Text_9999, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    self.textColor = ColorHexadecimal(Color_Login_Input, 1.0);
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textAlignment = 0;
    self.borderStyle = UITextBorderStyleNone;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.returnKeyType = UIReturnKeyDone;
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.delegate = self;
    [self customLeftView];
    [self customRightView];
    [self bindCodeSignal];
}
- (void)bindCodeSignal {
    @weakify(self)
    if (_codeType == LoginCodeType_Login) {
        [RACObserve(KUserMessageManager, loginCodeTime) subscribeNext:^(id x) {
            @strongify(self)
            NSInteger second = [x integerValue];
            [self changeBtnTitle:second];
        }];
    }else {
        [RACObserve(KUserMessageManager, forgetCodeTime)subscribeNext:^(id x) {
            @strongify(self)
            NSInteger second = [x integerValue];
            [self changeBtnTitle:second];
        }];
    }
}
- (void)changeBtnTitle:(NSInteger)second {
    if (second <= 0) {
        _codeBtn.userInteractionEnabled = YES;
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else
    {
        _codeBtn.userInteractionEnabled = NO;
        [_codeBtn setTitle:[NSString stringWithFormat:@"%lds后可重发",(long)second] forState:UIControlStateNormal];
    }
}
- (void)customRightView {
    self.rightViewMode = UITextFieldViewModeAlways;
    UIButton *codeBtn = [PPSSPublicViewManager initAPPThemeBtn:@"获取验证码" font:12 target:self action:@selector(getCodeClick)];
    ViewRadius(codeBtn, 5.0);
    _codeBtn = codeBtn;
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    _codeBtn.frame = CGRectMake(10, (50 - 30) / 2.0, 80, 30);
    [rightView addSubview:_codeBtn];
    self.rightView = rightView;
}
- (void)customLeftView {
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 49, 50)];
    leftView.layer.cornerRadius = 5.0;
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"login_code_icon")];
    [leftView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftView);
        make.left.equalTo(leftView).with.offset(12.5);
        make.width.mas_equalTo(15);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = ColorHexadecimal(Color_Login_Line, 1.0);
    [leftView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageView.mas_right).with.offset(12.5);
        make.centerY.equalTo(leftView);
        make.size.mas_equalTo(CGSizeMake(LINEVIEW_WIDTH, 17));
    }];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftView;
}
- (void)getCodeClick {
    if (_block) {
        _block(YES);
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if (range.length != 1) {
        if (range.location > kCodeLIMITLENGTH) {
                return NO;
        }
    }
    return YES;
}
@end
