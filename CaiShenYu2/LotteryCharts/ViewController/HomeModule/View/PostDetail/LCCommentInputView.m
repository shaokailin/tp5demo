//
//  LCCommentInputView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCCommentInputView.h"
#import "UITextView+Extend.h"
#import "UIView+FrameTool.h"
static const CGFloat BarHeight = 44;
@interface LCCommentInputView ()<UITextViewDelegate>
@property (nonatomic, assign) float keyboardHeight; //键盘高度
@property (nonatomic, assign) double keyboardTime; //键盘动画时长
@end
@implementation LCCommentInputView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        //监听键盘出现、消失
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [self _layoutMainView];
    }
    return self;
}
- (void)setPlaceholdString:(NSString *)placeholdString {
    self.inputField.placeholdString = placeholdString;
}
- (void)changeFrame:(CGFloat)height {
    CGRect frame = self.inputField.frame;
    frame.size.height = height;
    self.inputField.frame = frame; //改变输入框的frame
    //当输入框大小改变时，改变backView的frame
    CGFloat viewHeight = height + 10;
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT - self.StatusNav_Height - viewHeight - _keyboardHeight, ScreenWidth, viewHeight);
}
//键盘将要出现
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘的高度
    self.keyboardHeight = endFrame.size.height;
    //键盘的动画时长
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration delay:0 options:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] animations:^{
        self.frame = CGRectMake(0, endFrame.origin.y - self.height - self.StatusNav_Height, SCREEN_WIDTH, self.height);
    } completion:nil];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    //如果是弹出了底部视图时
//    if (self.moreClick || self.emojiClick) {
//        return;
//    }
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT - self.StatusNav_Height - self.height, SCREEN_WIDTH, self.height);
    }];
}

- (void)sendAction {
    if (self.sendBlock && KJudgeIsNullData([self.inputField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]])) {
        self.sendBlock([self.inputField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]);
        [self cleanText];
    }
    [self.inputField resignFirstResponder];
}
- (void)cleanText {
    self.inputField.text = nil;
}
- (void)_layoutMainView {
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview:lineView];
    WS(ws)
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws);
        make.height.mas_equalTo(kLineView_Height);
    }];
    UIButton *sendBtn = [LSKViewFactory initializeButtonWithTitle:@"发送" target:self action:@selector(sendAction) textfont:15 textColor:ColorHexadecimal(0x434343, 1.0)];
    [self addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(ws);
        make.height.mas_equalTo(BarHeight);
        make.width.mas_equalTo(60);
    }];
    
    DKSTextView *textView = [[DKSTextView alloc]init];
    textView.textColor = ColorHexadecimal(0x434343, 1.0);
    textView.returnKeyType = UIReturnKeySend;
    ViewRadius(textView, 5.0);
    ViewBorderLayer(textView, ColorHexadecimal(0xbfbfbf, 1.), 0.5);
    self.inputField = textView;
    [textView textValueDidChanged:^(CGFloat textHeight) {
        [self changeFrame:textHeight];
    }];
    textView.maxNumberOfLines = 5;
    textView.delegate = self;
    textView.frame = CGRectMake(10, 5, ScreenWidth - 70, 34);
    [self addSubview:textView];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self sendAction];
        [textView resignFirstResponder];
        return NO;
    }else {
        return YES;
    }
}

@end
