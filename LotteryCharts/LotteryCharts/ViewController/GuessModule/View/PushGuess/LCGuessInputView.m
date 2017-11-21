//
//  LCGuessInputView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/21.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessInputView.h"
static const NSInteger TextView_Limit = 300;
static const NSInteger Field_Limit = 20;
@interface LCGuessInputView ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *placeholdLbl;

@end
@implementation LCGuessInputView
- (void)awakeFromNib {
    [super awakeFromNib];
    @weakify(self)
    [[[self.titleField.rac_textSignal merge:RACObserve(self.titleField, text)]skip:2]subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self changeFieldLimit];
        }];
    [[[self.contentField.rac_textSignal merge:RACObserve(self.contentField, text)]skip:2]subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self changeLimit];
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *comcatstr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger caninputlen = Field_Limit - comcatstr.length;
    if (caninputlen >= 0) {
        return YES;
    } else {
        NSInteger len = string.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        if (rg.length > 0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = TextView_Limit - comcatstr.length;
    if (caninputlen >= 0) {
        return YES;
    } else {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        if (rg.length > 0) {
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}
- (void)changeLimit {
    NSString  *nsTextContent = self.contentField.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum > TextView_Limit){
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:TextView_Limit];
        [self.contentField setText:s];
    }
    self.placeholdLbl.hidden = existTextNum > 0 ? YES:NO;
}
- (void)changeFieldLimit {
    NSString  *nsTextContent = self.titleField.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum > Field_Limit){
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:Field_Limit];
        [self.titleField setText:s];
    }
}
@end
