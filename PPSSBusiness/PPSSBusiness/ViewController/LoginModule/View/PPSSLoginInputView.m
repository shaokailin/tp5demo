//
//  PPSSLoginInputView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/14.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSLoginInputView.h"
static const NSInteger kPHONELIMITLENGTH = 10;
static const NSInteger kPASSWORDLIMITLENGTH = 19;
@implementation PPSSLoginInputView
{
    LoginInputType _type;
}
- (instancetype)initInputViewWithType:(LoginInputType)type icon:(NSString *)iconImage placeholder:(NSString *)placeholder {
    if (self = [super init]) {
        self.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
        _type = type;
        self.layer.cornerRadius = 5.0;
        self.delegate = self;
        self.placeholder = placeholder;
        [self customLeftView:iconImage];
        [self _layoutMainView];
        [self customRightView];
        [self bindSignal];
    }
    return self;
}
- (void)bindSignal {
    _textSignal = [self.rac_textSignal merge:RACObserve(self, text)];
}
- (void)_layoutMainView {
    self.font = FontNornalInit(12);
    [self setValue:ColorHexadecimal(Color_Text_9999, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
    self.textColor = ColorHexadecimal(Color_Login_Input, 1.0);
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textAlignment = 0;
    self.borderStyle = UITextBorderStyleNone;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if (_type == LoginInputType_Account) {
        self.returnKeyType = UIReturnKeyNext;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }else {
        self.returnKeyType = UIReturnKeyDone;
        self.keyboardType = UIKeyboardTypeAlphabet;
        self.secureTextEntry = YES;
    }
}
- (void)customRightView {
    self.rightViewMode = UITextFieldViewModeWhileEditing;
    UIButton *closeBtn = [PPSSPublicViewManager initBtnWithNornalImage:@"login_close" target:self action:@selector(cleanTextInput)];
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 39, 50)];
    closeBtn.frame = CGRectMake(12, (50 - 15) / 2.0, 15, 15);
    [rightView addSubview:closeBtn];
    self.rightView = rightView;
}
- (void)customLeftView:(NSString *)iconImage {
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 49, 50)];
    leftView.layer.cornerRadius = 5.0;
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:ImageNameInit(iconImage)];
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
- (void)cleanTextInput {
    self.text = @"";
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if (range.length != 1) {
        if (_type == LoginInputType_Account) {
            if (range.location > kPHONELIMITLENGTH) {
                return NO;
            }
        }else {
            if (range.location > kPASSWORDLIMITLENGTH) {
                return NO;
            }
        }
    }
    return YES;
}
@end
