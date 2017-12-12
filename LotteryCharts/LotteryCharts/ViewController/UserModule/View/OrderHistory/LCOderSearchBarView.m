//
//  LCOderSearchBarView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCOderSearchBarView.h"
@interface LCOderSearchBarView ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *searchField;
@property (nonatomic, weak) UILabel *typelLbl;
@end
@implementation LCOderSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContent:(NSString *)title {
    self.typelLbl.text = title;
}
- (void)_layoutMainView {
    UIView *searchView = [[UIView alloc]init];
    searchView.backgroundColor = ColorHexadecimal(0xdcdcdc, 1.0);
    [self addSubview:searchView];
    WS(ws)
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    UIButton *searchBtn = [LSKViewFactory initializeButtonWithTitle:@"搜索" target:self action:@selector(searchClick) textfont:15 textColor:ColorHexadecimal(0x434343, 1.0)];
    [searchView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(searchView);
        make.width.mas_equalTo(WIDTH_RACE_6S(64));
    }];
    
    UIButton *enumBtn = [LSKViewFactory initializeButtonWithTitle:nil target:self action:@selector(showEnumClick) textfont:0 textColor:nil];
    enumBtn.backgroundColor = [UIColor whiteColor];
    ViewRadius(enumBtn, 5.0);
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:nil font:14 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:0 backgroundColor:nil];
    self.typelLbl = titleLbl;
    [enumBtn addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(enumBtn).with.offset(10);
        make.centerY.equalTo(enumBtn);
    }];
    UIImageView *arrowImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"home_arrow")];
    [enumBtn addSubview:arrowImage];
    arrowImage.tag = 3001;
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(enumBtn).with.offset(-5);
        make.centerY.equalTo(enumBtn);
        make.width.mas_equalTo(10);
    }];
    [self addSubview:enumBtn];
    [enumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(searchBtn.mas_left);
        make.centerY.equalTo(searchView);
        make.size.mas_equalTo(CGSizeMake(WIDTH_RACE_6S(127), 25));
    }];
    
    UITextField *searchField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"请输入帖子ID号" textFont:14 textColor:ColorHexadecimal(0x434343, 1.0) placeholderColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:0 borStyle:0 returnKey:UIReturnKeySearch keyBoard:UIKeyboardTypeNamePhonePad cleanModel:0];
    searchField.backgroundColor = [UIColor whiteColor];
    ViewRadius(searchField, 5);
    searchField.leftViewMode = UITextFieldViewModeAlways;
    searchField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    self.searchField = searchField;
    [searchView addSubview:searchField];
    [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView).with.offset(10);
        make.right.equalTo(enumBtn.mas_left).with.offset(-10);
        make.height.mas_equalTo(25);
        make.centerY.equalTo(searchView);
    }];
    
}
- (void)showEnumClick {
    [self.searchField resignFirstResponder];
    if (self.searchBlock) {
        UIImageView *arrow = [self viewWithTag:3001];
        self.searchBlock(0, arrow);
    }
}
- (void)searchClick {
    if (self.searchBlock) {
        self.searchBlock(1, self.searchField.text);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchClick];
    return YES;
}
- (void)setupSearchType:(NSInteger)type {
    if (type == 1) {
        self.searchField.keyboardType = UIKeyboardTypeNumberPad;
        self.searchField.placeholder = @"请输入查询期数";
    }
}
@end
