//
//  LCForgetPWDView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCForgetPWDView.h"
@interface LCForgetPWDView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end
@implementation LCForgetPWDView
- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.sureBtn, 5.0);
    ViewRadius(self.codeBtn, 5.0);
    UIButton *eyeBtn = [LSKViewFactory initializeButtonNornalImage:@"login_show" selectedImage:@"pwdnoshow" target:self action:@selector(changeEyeType:)];
    eyeBtn.frame = CGRectMake(0, (45 - 30) / 2.0, 30, 30);
    self.passwordFild.rightViewMode = UITextFieldViewModeAlways;
    self.passwordFild.rightView = eyeBtn;
    self.passwordFild.delegate = self;
    self.codeField.delegate = self;
    self.accountField.delegate = self;
    @weakify(self)
    [RACObserve(kUserMessageManager, forgetCodeTime) subscribeNext:^(id x) {
        @strongify(self)
        NSInteger second = [x integerValue];
        [self changeBtnTitle:second];
    }];
}
- (void)changeBtnTitle:(NSInteger)second {
    if (second <= 0) {
        _codeBtn.userInteractionEnabled = YES;
        [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else
    {
        _codeBtn.userInteractionEnabled = NO;
        [_codeBtn setTitle:[NSString stringWithFormat:@"%lds后可重发",(long)second] forState:UIControlStateNormal];
    }
}
- (void)changeEyeType:(UIButton *)btn {
    if (!btn.selected) {
        btn.selected = YES;
        self.passwordFild.secureTextEntry = YES;
        [self.passwordFild becomeFirstResponder];
    }else {
        btn.selected = NO;
        self.passwordFild.secureTextEntry = NO;
        [self.passwordFild becomeFirstResponder];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)eventActionClick:(NSInteger)type {
    [self endEditing:YES];
    if (self.forgetBlock) {
        self.forgetBlock(type);
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
        if (textField == self.passwordFild || textField == self.againPwdField) {
            if (range.location > 23) {
                return NO;
            }
        }else if(textField == self.accountField) {
            if (range.location > 10) {
                return NO;
            }
        }else if (textField == self.codeField){
            if (range.location > 5) {
                return NO;
            }
        }
    }
    return YES;
}
- (IBAction)getCodeClick:(id)sender {
    [self eventActionClick:2];
}
- (IBAction)registerClick:(id)sender {
    [self eventActionClick:3];
}


@end
