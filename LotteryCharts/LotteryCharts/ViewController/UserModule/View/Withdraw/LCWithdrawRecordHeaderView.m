//
//  LCWithdrawRecordHeaderView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/16.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCWithdrawRecordHeaderView.h"
@interface LCWithdrawRecordHeaderView ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *yearField;
@property (nonatomic, weak) UITextField *mouthField;
@end
@implementation LCWithdrawRecordHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorHexadecimal(kMainBackground_Color, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithLeft:(NSString *)left right:(NSString *)right {
    if (left) {
        self.yearField.text = left;
    }
    if (right) {
        self.mouthField.text = right;
    }
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
        make.width.mas_equalTo(64);
    }];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"按" font:15 textColor:ColorHexadecimal(0x434343, 1.0) textAlignment:1 backgroundColor:nil];
    [searchView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchView);
        make.centerY.equalTo(searchView);
        make.width.mas_equalTo(34);
    }];
    
    
    UITextField *yearField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"年份" textFont:14 textColor:ColorHexadecimal(0x434343, 1.0) placeholderColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:0 borStyle:0 returnKey:UIReturnKeySearch keyBoard:UIKeyboardTypeNamePhonePad cleanModel:0];
    yearField.backgroundColor = [UIColor whiteColor];
    ViewRadius(yearField, 5);
    yearField.leftViewMode = UITextFieldViewModeAlways;
    yearField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    arrowImage.image = ImageNameInit(@"home_arrow");
    arrowImage.contentMode = UIViewContentModeCenter;
    arrowImage.tag = 200;
    yearField.rightViewMode = UITextFieldViewModeAlways;
    yearField.rightView = arrowImage;
    self.yearField = yearField;
    [searchView addSubview:yearField];
    [yearField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl.mas_right).with.offset(10);
        make.height.mas_equalTo(25);
        make.centerY.equalTo(searchView);
    }];
    
    UITextField *mouthField = [LSKViewFactory initializeTextFieldWithDelegate:self text:nil placeholder:@"月份" textFont:14 textColor:ColorHexadecimal(0x434343, 1.0) placeholderColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:0 borStyle:0 returnKey:UIReturnKeySearch keyBoard:UIKeyboardTypeNamePhonePad cleanModel:0];
    mouthField.backgroundColor = [UIColor whiteColor];
    ViewRadius(mouthField, 5);
    mouthField.leftViewMode = UITextFieldViewModeAlways;
    mouthField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    UIImageView *arrowImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 25)];
    arrowImage1.contentMode = UIViewContentModeCenter;
    arrowImage1.tag = 201;
    arrowImage1.image = ImageNameInit(@"home_arrow");
    mouthField.rightViewMode = UITextFieldViewModeAlways;
    mouthField.rightView = arrowImage1;
    self.mouthField = mouthField;
    [searchView addSubview:mouthField];
    [mouthField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yearField.mas_right).with.offset(15);
        make.height.mas_equalTo(25);
        make.centerY.equalTo(searchView);
        make.right.equalTo(searchBtn.mas_left);
        make.width.equalTo(yearField);
    }];
    
}
- (void)searchClick {
    if (self.searchBlock) {
        self.searchBlock(2, nil);
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.searchBlock) {
        NSInteger type = textField == self.yearField ? 0:1;
        UIImageView *imageView = [self viewWithTag:200 + type];
        self.searchBlock(type, imageView);
    }
    return NO;
}
@end
