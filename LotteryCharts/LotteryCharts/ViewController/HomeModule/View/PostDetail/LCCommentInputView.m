//
//  LCCommentInputView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCCommentInputView.h"

@implementation LCCommentInputView

- (instancetype)init {
    if (self = [super init]) {
        self.layer.shadowColor=[[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
        self.layer.shadowOffset=CGSizeMake(2,2);
        self.layer.shadowOpacity=0.5;
        self.layer.shadowRadius=0;
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)sendAction {
    
}
- (void)_layoutMainView {
    UIButton *sendBtn = [LSKViewFactory initializeButtonWithTitle:@"发送" target:self action:@selector(sendAction) textfont:15 textColor:ColorHexadecimal(0x434343, 1.0)];
    [self addSubview:sendBtn];
    WS(ws)
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(ws);
        make.width.mas_equalTo(60);
    }];
    
    UITextField *inputField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"请输入评论内容" textFont:15 textColor:ColorHexadecimal(0x434343, 1.0) placeholderColor:ColorHexadecimal(0xa0a0a0, 1.0) textAlignment:0 borStyle:0 returnKey:UIReturnKeyDone keyBoard:UIKeyboardTypeDefault cleanModel:0];
    inputField.leftViewMode = UITextFieldViewModeAlways;
    inputField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    ViewRadius(inputField, 5.0);
    ViewBorderLayer(inputField, ColorHexadecimal(0xbfbfbf, 1.), 0.5);
    self.inputField = inputField;
    [self addSubview:inputField];
    [inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(10);
        make.top.equalTo(ws).with.offset(5);
        make.bottom.equalTo(ws).with.offset(-5);
        make.right.equalTo(sendBtn.mas_left);
    }];
}
@end
