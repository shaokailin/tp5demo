//
//  LCLoginMainView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCLoginMainView.h"
@interface LCLoginMainView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end
@implementation LCLoginMainView

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewRadius(self.sureBtn, 5.0);
    self.accountField.delegate = self;
    self.passwordField.delegate = self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)eventClickWithType:(NSInteger)type {
    [self endEditing:YES];
    if (self.loginBlock) {
        self.loginBlock(type);
    }
}
- (void)hidenBackBtn:(BOOL)isHiden {
    self.backBtn.hidden = !isHiden;
}
- (IBAction)backClick:(id)sender {
    [self eventClickWithType:1];
}
- (IBAction)forgetClick:(id)sender {
    [self eventClickWithType:2];
}
- (IBAction)loginClick:(id)sender {
    [self eventClickWithType:3];
}
- (IBAction)registerClick:(id)sender {
    [self eventClickWithType:4];
}
- (IBAction)wxLoginClick:(id)sender {
    [self eventClickWithType:5];
}
- (IBAction)qqLoginClick:(id)sender {
    [self eventClickWithType:6];
}

@end
