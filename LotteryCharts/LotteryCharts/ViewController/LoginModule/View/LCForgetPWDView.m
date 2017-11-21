//
//  LCForgetPWDView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCForgetPWDView.h"
@interface LCForgetPWDView ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFild;
@property (weak, nonatomic) IBOutlet UITextField *againPwdField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
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
- (IBAction)getCodeClick:(id)sender {
    [self eventActionClick:2];
}
- (IBAction)registerClick:(id)sender {
    [self eventActionClick:3];
}


@end
