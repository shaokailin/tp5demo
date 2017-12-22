//
//  LCRechargeHeaderView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRechargeHeaderView.h"
@interface LCRechargeHeaderView ()
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, weak) UITextField *moneyField;
@end
@implementation LCRechargeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)sureInputClick {
    [self.moneyField resignFirstResponder];
    if (KJudgeIsNullData(self.moneyField.text) && [self.moneyField.text integerValue] > 0) {
        [self cancleSelect];
        if (self.moneyBlock) {
            self.moneyBlock(self.moneyField.text);
        }
    }
}
- (void)selectEvent:(UIButton *)btn {
    [self.moneyField resignFirstResponder];
    if (!btn.selected) {
        [self cancleSelect];
        _currentIndex = btn.tag / 100;
        btn.layer.borderColor = ColorHexadecimal(0xf6a623, 1.0).CGColor;
        UILabel *titleLbl = [btn viewWithTag:btn.tag + 1];
        titleLbl.textColor = ColorHexadecimal(0xf6a623, 1.0);
        UILabel *detailLbl = [btn viewWithTag:btn.tag + 2];
        detailLbl.textColor = ColorHexadecimal(0xf6a623, 0.6);
        btn.selected = YES;
        if (self.moneyBlock) {
            self.moneyBlock(@"100");
        }
    }
}
- (void)setupPayMoneyType:(NSArray *)array {
    for (int i = 1; i <= 4; i++) {
        
        if (array && array.count > 0 && i <= array.count) {
            
        }else {
            
        }
    }
}
- (void)cancleSelect {
    if (_currentIndex != 0) {
        NSInteger tag = _currentIndex * 100;
        UIButton *otherBtn = [self viewWithTag:tag];
        otherBtn.selected = NO;
        otherBtn.layer.borderColor = ColorHexadecimal(0xbfbfbf, 1.0).CGColor;
        UILabel *titleLbl = [otherBtn viewWithTag:tag + 1];
        titleLbl.textColor = ColorHexadecimal(0x434343, 1.0);
        UILabel *detailLbl = [otherBtn viewWithTag:tag + 2];
        detailLbl.textColor = ColorHexadecimal(0x7d7d7d, 1.0);
        _currentIndex = 0;
    }
}
- (void)_layoutMainView {
    _currentIndex = 1;
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"金币充值" font:15 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.top.equalTo(ws).with.offset(18);
    }];
    
    UIButton *btn1 = [self customBtnViewWithTopTitle:@"100币" detail:@"售100.00元" flag:100];
    btn1.layer.borderColor = ColorHexadecimal(0xf6a623, 1.0).CGColor;
    UILabel *titleLbl1 = [btn1 viewWithTag:101];
    titleLbl1.textColor = ColorHexadecimal(0xf6a623, 1.0);
    UILabel *detailLbl = [btn1 viewWithTag: 102];
    detailLbl.textColor = ColorHexadecimal(0xf6a623, 0.6);
    btn1.selected = YES;
    [self addSubview:btn1];
    UIButton *btn2 = [self customBtnViewWithTopTitle:@"100币" detail:@"售100.00元" flag:200];
    [self addSubview:btn2];
    UIButton *btn3 = [self customBtnViewWithTopTitle:@"100币" detail:@"售100.00元" flag:300];
    [self addSubview:btn3];
    UIButton *btn4 = [self customBtnViewWithTopTitle:@"100币" detail:@"售100.00元" flag:400];
    [self addSubview:btn4];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(10);
        make.height.mas_equalTo(55);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1.mas_right).with.offset(10);
        make.top.bottom.equalTo(btn1);
        make.right.equalTo(ws).with.offset(-20);
        make.width.equalTo(btn1);
    }];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(btn1);
        make.top.equalTo(btn1.mas_bottom).with.offset(10);
    }];
    
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(btn2);
        make.top.equalTo(btn3);
    }];
    
    UILabel *titleLbl2 = [LSKViewFactory initializeLableWithText:@"手动输入" font:12 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:titleLbl2];
    [titleLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(18);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(18 + 10 + 55 + 10 + 55);
    }];
    
    UITextField *inputField = [LSKViewFactory initializeTextFieldWithDelegate:nil text:nil placeholder:@"请输入您的充值币数" textFont:12 textColor:ColorHexadecimal(0x434343, 1.0) placeholderColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:0 borStyle:UITextBorderStyleRoundedRect returnKey:UIReturnKeyDone keyBoard:UIKeyboardTypeNumberPad cleanModel:0];
    inputField.leftViewMode = UITextFieldViewModeAlways;
    inputField.rightViewMode = UITextFieldViewModeAlways;
    UILabel *leftView = [LSKViewFactory initializeLableWithText:@"充值" font:12 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:1 backgroundColor:nil];
    leftView.frame = CGRectMake(0, 0, 44, 35);
    inputField.leftView = leftView;
    
    UILabel *rightView = [LSKViewFactory initializeLableWithText:@"币" font:12 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:1 backgroundColor:nil];
    rightView.frame = CGRectMake(0, 0, 32, 35);
    inputField.rightView = rightView;
    
    self.moneyField = inputField;
    [self addSubview:inputField];
    [inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1);
        make.right.equalTo(btn2);
        make.top.equalTo(titleLbl2.mas_bottom).with.offset(10);
        make.height.mas_equalTo(35);
    }];
    
    UIButton *sureBtn = [LSKViewFactory initializeButtonWithTitle:@"确认" target:self action:@selector(sureInputClick) textfont:15 textColor:[UIColor whiteColor]];
    ViewRadius(sureBtn, 5.0);
    [sureBtn setBackgroundColor:[UIColor redColor]];
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputField.mas_bottom).with.offset(20);
        make.centerX.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(162, 40));
    }];
}
- (UIButton *)customBtnViewWithTopTitle:(NSString *)topTitle detail:(NSString *)detail flag:(NSInteger)flag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    ViewRadius(btn, 5.0);
    ViewBorderLayer(btn, ColorHexadecimal(0xbfbfbf, 1.0), kLineView_Height);
    UILabel *topLble = [LSKViewFactory initializeLableWithText:topTitle font:15 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    topLble.tag = flag + 1;
    [btn addSubview:topLble];
    [topLble mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btn.mas_centerY);
        make.centerX.equalTo(btn.mas_centerX);
    }];
    
    UILabel *detailLbl = [LSKViewFactory initializeLableWithText:detail font:10 textColor:ColorHexadecimal(0x7d7d7d, 1.0) textAlignment:0 backgroundColor:nil];
    detailLbl.tag = flag + 2;
    [btn addSubview:detailLbl];
    [detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLble.mas_bottom).with.offset(5);
        make.centerX.equalTo(btn.mas_centerX);
    }];
    btn.tag = flag;
    [btn addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
