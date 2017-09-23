//
//  PPSSCollectInputView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/23.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSCollectInputView.h"

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
        make.height.mas_equalTo(WIDTH_RACE_6S(70));
    }];
    UITextField *allmoneyField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"收款总额" textFont:16 textColor:ColorHexadecimal(Color_Text_3333, 1.0) placeholderColor:ColorHexadecimal(Color_Text_3333, 1.0) textAlignment:1 borStyle:UITextBorderStyleRoundedRect returnKey:UIReturnKeyDefault keyBoard:0 cleanModel:0];
    allmoneyField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    self.allMoneyField = allmoneyField;
    [allMoneyView addSubview:allmoneyField];
    [allmoneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allMoneyView).with.offset(WIDTH_RACE_6S(15));
        make.right.equalTo(allMoneyView).with.offset(WIDTH_RACE_6S(-15));
        make.top.equalTo(allMoneyView).with.offset(WIDTH_RACE_6S(8));
        make.bottom.equalTo(allMoneyView).with.offset(WIDTH_RACE_6S(-12));
    }];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"gengduo_ico")];
    [self addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_RACE_6S(133 / 2.0));
        make.top.equalTo(allMoneyView.mas_bottom);
        make.centerX.equalTo(ws);
    }];
    
    UITextField *discountField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"不参与优惠金额" textFont:16 textColor:ColorHexadecimal(Color_Text_9999, 1.0) placeholderColor:ColorHexadecimal(Color_Text_9999, 1.0) textAlignment:1 borStyle:UITextBorderStyleRoundedRect returnKey:UIReturnKeyDefault keyBoard:0 cleanModel:0];
    ViewBorderLayer(discountField, ColorHexadecimal(Color_Text_9999, 1.0), LINEVIEW_WIDTH);
    ViewRadius(discountField, 6);
    discountField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    self.discountField = discountField;
    [self addSubview:discountField];
    [discountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(allmoneyField);
        make.top.equalTo(arrowImg.mas_bottom).with.offset(WIDTH_RACE_6S(20));
        make.height.mas_equalTo(WIDTH_RACE_6S(50));
    }];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.allMoneyField && self.currentType != 1) {
        self.discountField.enabled = YES;
        self.allMoneyField.enabled = NO;
        self.currentType = 1;
    }else if (textField == self.discountField && self.currentType != 2){
        self.allMoneyField.enabled = YES;
        self.discountField.enabled = NO;
        self.currentType = 2;
    }
    return YES;
}
@end
