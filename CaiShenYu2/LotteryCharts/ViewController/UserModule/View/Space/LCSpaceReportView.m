//
//  LCSpaceReportView.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/5.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCSpaceReportView.h"
#import "UITextView+Extend.h"
@interface LCSpaceReportView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldId;
@property (weak, nonatomic) IBOutlet UILabel *placeholdLbl;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation LCSpaceReportView

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewBoundsRadius(self.bgView, 12);
    ViewBorderLayer(self.textFieldId, ColorHexadecimal(0xbfbfbf, 1.0), 0.5);
    ViewBorderLayer(self.textView, ColorHexadecimal(0xbfbfbf, 1.0), 0.5);
    self.textFieldId.leftViewMode = UITextFieldViewModeAlways;
    self.textFieldId.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 10)];
    self.textFieldId.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registerFirst)];
    [self addGestureRecognizer:tap];
    self.placeholdLbl.hidden = YES;
    [self.textView setPlaceholder:@"投诉内容..." placeholdColor:ColorHexadecimal(0xb2b2b2, 1.0)];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)registerFirst {
    [self.textFieldId resignFirstResponder];
    [self.textView resignFirstResponder];
}
- (IBAction)sureButton:(id)sender {
    [self registerFirst];
    if (!KJudgeIsNullData(self.textFieldId.text) ||[self.textFieldId.text stringBySpaceTrim].length == 0) {
        [SKHUD showMessageInWindowWithMessage:@"请输入要投诉的帖子Id"];
        return;
    }
    if (!KJudgeIsNullData(self.textView.text) ||[self.textView.text stringBySpaceTrim].length == 0) {
        [SKHUD showMessageInWindowWithMessage:@"请输入要投诉的内容"];
        return;
    }
    if (self.block) {
        self.block(self.textFieldId.text,self.textView.text);
    }
    [self removeFromSuperview];
}
- (IBAction)cancleButton:(id)sender {
    [self registerFirst];
    [self removeFromSuperview];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
