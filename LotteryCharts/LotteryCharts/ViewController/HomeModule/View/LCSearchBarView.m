//
//  LCSearchBarView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/8.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSearchBarView.h"
@interface LCSearchBarView ()<UITextFieldDelegate>
{
    UITextField *_searchField;
}
@end
@implementation LCSearchBarView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = ColorHexadecimal(0xdcdcdc, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UITextField *inputText = [LSKViewFactory initializeTextFieldWithDelegate:nil text:nil placeholder:nil textFont:14 textColor:ColorHexadecimal(0x434343, 1.0) placeholderColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:0 borStyle:0 returnKey:UIReturnKeySearch keyBoard:UIKeyboardTypeDefault cleanModel:0];
    inputText.backgroundColor = [UIColor whiteColor];
    ViewRadius(inputText, 5.0);
    inputText.leftViewMode = UITextFieldViewModeAlways;
    UIButton *arrowBtn = [LSKViewFactory initializeButtonNornalImage:@"home_arrow" selectedImage:@"home_arrow" target:self action:@selector(showSearchMeun)];
    arrowBtn.frame = CGRectMake(0, 2, 20, 20);
    inputText.leftView = arrowBtn;
    _searchField = inputText;
    [self addSubview:inputText];
    WS(ws)
    [inputText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws).with.insets(UIEdgeInsetsMake(8, 10, 8, 65));
    }];
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:@"搜索" target:self action:@selector(showSearchMeun) textfont:15 textColor:ColorHexadecimal(0x434343, 1.0)];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(inputText);
        make.left.equalTo(inputText.mas_right);
        make.right.equalTo(ws);
    }];
    self.currentSearchType = 1;
}
- (void)showSearchClick {
    [self actionClickEvent:2];
}
- (void)showSearchMeun {
    [self actionClickEvent:1];
}
- (void)actionClickEvent:(NSInteger)type {
    [_searchField resignFirstResponder];
    if (self.searchBlock) {
        self.searchBlock(type);
    }
}
- (NSString *)searchText {
    return _searchField.text;
}
- (void)setSearchText:(NSString *)searchText {
    _searchField.text = searchText;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self showSearchClick];
    return YES;
}
- (void)setCurrentSearchType:(NSInteger)currentSearchType {
    if (_currentSearchType != currentSearchType) {
        _currentSearchType = currentSearchType;
        switch (currentSearchType) {
            case 0:
                _searchField.placeholder = @"标题";
                break;
            case 1:
                _searchField.placeholder = @"码师ID";
                break;
            case 2:
                _searchField.placeholder = @"帖子ID";
                break;
            default:
                break;
        }
    }
}
@end
