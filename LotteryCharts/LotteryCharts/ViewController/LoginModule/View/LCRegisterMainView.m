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
    UIButton *eyeBtn = [LSKViewFactory initializeButtonNornalImage:@"login_show" selectedImage:@"pwdnoshow" target:self action:@selector(changeEyeType:)];
    eyeBtn.frame = CGRectMake(0, (45 - 30) / 2.0, 30, 30);
    self.pwdField.rightViewMode = UITextFieldViewModeAlways;
    self.pwdField.rightView = eyeBtn;
    self.pwdField.delegate = self;
    self.accountField.delegate = self;
    self.inviteField.delegate = self;
    self.codeField.delegate = self;
    @weakify(self)
    [RACObserve(kUserMessageManager, loginCodeTime) subscribeNext:^(id x) {
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if (range.length != 1) {
        if (textField == self.pwdField) {
            if (range.location > 23) {
                return NO;
            }
        }else if(textField == self.accountField) {
            if (range.location > 10) {
                return NO;
            }
        }else if (textField == self.inviteField){
            if (range.location > 5) {
                return NO;
            }
        }else {
            if (range.location > 5) {
                return NO;
            }
        }
    }
    return YES;
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
- (IBAction)weixinClick:(id)sender {
    [self eventActionClick:4];
}
- (IBAction)qqClick:(id)sender {
    [self eventActionClick:5];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
