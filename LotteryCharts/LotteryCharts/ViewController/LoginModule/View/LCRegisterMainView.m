//
//  LCRegisterMainView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRegisterMainView.h"
@interface LCRegisterMainView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end
@implementation LCRegisterMainView
- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.sureBtn, 5.0);
    ViewRadius(self.codeBtn, 5.0);
    UIButton *eyeBtn = [LSKViewFactory initializeButtonNornalImage:@"login_show" selectedImage:@"loginnoshow" target:self action:@selector(changeEyeType:)];
    eyeBtn.frame = CGRectMake(0, (45 - 30) / 2.0, 30, 30);
    self.pwdField.rightViewMode = UITextFieldViewModeAlways;
    self.pwdField.rightView = eyeBtn;
}
- (void)changeEyeType:(UIButton *)btn {
    if (!btn.selected) {
        btn.selected = YES;
        self.pwdField.secureTextEntry = YES;
        [self.pwdField becomeFirstResponder];
    }else {
        btn.selected = NO;
        self.pwdField.secureTextEntry = NO;
        [self.pwdField becomeFirstResponder];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)eventActionClick:(NSInteger)type {
    [self endEditing:YES];
    if (self.registerBlock) {
        self.registerBlock(type);
    }
}
- (IBAction)backClick:(id)sender {
    [self eventActionClick:1];
}
- (IBAction)getCodeClick:(id)sender {
    [self eventActionClick:2];
}
- (IBAction)registerClick:(id)sender {
    [self eventActionClick:3];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
