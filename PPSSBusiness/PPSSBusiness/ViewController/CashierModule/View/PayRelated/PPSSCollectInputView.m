//
//  PPSSCollectInputView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/23.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCollectInputView.h"
@interface PPSSCollectInputView ()
@property (nonatomic, weak) UIButton *checkBtn;
@end
@implementation PPSSCollectInputView

- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    _currentType = 0;
    UIView *allMoneyView = [[UIView alloc]init];
    allMoneyView.backgroundColor = ColorHexadecimal(Color_APP_MAIN, 1.0);
    [self addSubview:allMoneyView];
    WS(ws)
    [allMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws);
        make.height.mas_equalTo(70);
    }];
    UITextField *allmoneyField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"0.0" textFont:20 textColor:ColorHexadecimal(Color_Text_3333, 1.0) placeholderColor:ColorHexadecimal(Color_Text_3333, 1.0) textAlignment:1 borStyle:UITextBorderStyleRoundedRect returnKey:UIReturnKeyDefault keyBoard:0 cleanModel:0];
//    allmoneyField.rightViewMode = UITextFieldViewModeAlways;
    
//    UIButton *cleanBtn = [PPSSPublicViewManager initBtnWithNornalImage:@"fanhui_shanchu" target:self action:@selector(cleanText)];
//    [cleanBtn setImage:ImageNameInit(@"fanhui_shanchu") forState:UIControlStateSelected];
//    cleanBtn.frame = CGRectMake(0, 0, 24 + 20, 50);
//    allmoneyField.rightView = cleanBtn;
//    allmoneyField.leftViewMode = UITextFieldViewModeAlways;
//    allmoneyField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 24 + 20, 25)];
    allmoneyField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    self.allMoneyField = allmoneyField;
    [allMoneyView addSubview:allmoneyField];
    [allmoneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allMoneyView).with.offset(15);
        make.right.equalTo(allMoneyView).with.offset(-15);
        make.top.equalTo(allMoneyView).with.offset(8);
        make.bottom.equalTo(allMoneyView).with.offset(-12);
    }];
    
    UIButton *checkBtn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:@"collect_uncheck" selectedImage:@"collect_check" target:self action:@selector(checkInputUnDiscount) textfont:0 textColor:nil backgroundColor:nil backgroundImage:nil];
    self.checkBtn = checkBtn;
    [self addSubview:checkBtn];
    [checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(15);
        make.top.equalTo(allMoneyView.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    UILabel *remarkLbl = [LSKViewFactory initializeLableWithText:@"输入不参与优惠金额(如酒水，套餐)" font:12 textColor:ColorHexadecimal(Color_APP_MAIN, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:remarkLbl];
    [remarkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(checkBtn.mas_right);
        make.centerY.equalTo(checkBtn);
    }];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.allMoneyField && self.currentType != 1) {
        if (_discountField) {
            self.discountField.enabled = YES;
        }
        self.allMoneyField.enabled = NO;
        self.currentType = 1;
    }else if (_discountField && textField == self.discountField && self.currentType != 2){
        self.allMoneyField.enabled = YES;
        self.discountField.enabled = NO;
        self.currentType = 2;
    }
    return YES;
}
- (void)cleanText {
    self.allMoneyField.text = nil;
    if (self.inputBlock) {
        self.inputBlock(0);
    }
}
- (void)changeBecome {
    _currentType = 1;
    [self.allMoneyField becomeFirstResponder];
}
- (UITextField *)discountField {
    if (!_discountField) {
        UITextField *discountField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"不参与优惠金额" textFont:20 textColor:ColorHexadecimal(Color_Text_9999, 1.0) placeholderColor:ColorHexadecimal(Color_Text_9999, 1.0) textAlignment:1 borStyle:UITextBorderStyleRoundedRect returnKey:UIReturnKeyDefault keyBoard:0 cleanModel:0];
        ViewBorderLayer(discountField, ColorHexadecimal(Color_Text_9999, 1.0), LINEVIEW_WIDTH);
        ViewRadius(discountField, 6);
        discountField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
        _discountField = discountField;
        [self addSubview:discountField];
        WS(ws)
        [discountField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(ws.allMoneyField);
            make.top.equalTo(ws.checkBtn.mas_bottom).with.offset(5);
            make.height.mas_equalTo(50);
        }];
    }
    return _discountField;
}
- (void)checkInputUnDiscount {
    if (_checkBtn.selected) {
        self.discountField.hidden = YES;
        _checkBtn.selected = NO;
    }else {
        self.discountField.hidden = NO;
        _checkBtn.selected = YES;
    }
    if (self.inputBlock) {
        self.inputBlock(1);
    }
}
- (BOOL)isCheck {
    return _checkBtn.selected;
}
@end
