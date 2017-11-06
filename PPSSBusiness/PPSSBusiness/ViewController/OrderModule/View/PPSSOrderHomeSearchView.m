//
//  PPSSOrderHomeSearchView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/18.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSOrderHomeSearchView.h"
#import "PPSSOrderHomeButtonView.h"
#import "UISearchBar+Extend.h"
@interface PPSSOrderHomeSearchView()<UISearchBarDelegate>
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) PPSSOrderHomeButtonView *dateBtn;
@property (nonatomic, weak) PPSSOrderHomeButtonView *shopBtn;
@end
@implementation PPSSOrderHomeSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
#pragma mark -private
- (NSString *)dateString {
    return self.dateBtn.dateString;
}
- (void)dateClickEvent {
    if (self.clickBlock) {
        self.clickBlock(OrderHomeSearchClickType_Date);
    }
}
- (void)shopClickEvent {
    if (self.clickBlock) {
        self.clickBlock(OrderHomeSearchClickType_Shop);
    }
}
- (void)changeBtnText:(NSString *)text type:(OrderHomeSearchClickType)type {
    if (type == OrderHomeSearchClickType_Date) {
        [self.dateBtn setupTitle:text];
    }else {
        [self.shopBtn setupTitle:text];
    }
}
- (void)searchClickEvent {
    if (self.clickBlock) {
        self.clickBlock(OrderHomeSearchClickType_Search);
    }
}
- (NSString *)searchText {
    return self.searchBar.text;
}
#pragma mark -界面初始化
- (void)_layoutMainView {
    [self _layoutSearchView];
    [self _layoutButtonView];
}
- (void)_layoutSearchView {
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    searchBar.showsCancelButton = YES;
    searchBar.placeholder = @"请输入定单号或用户名";
   [searchBar settingSearchBarBackgroundColor:COLOR_WHITECOLOR textFieldBackgroundColor:ColorHexadecimal(kMainBackground_Color, 1.0) returnKeyType:UIReturnKeySearch textColor:ColorHexadecimal(Color_Text_3333, 1.0) placeholderColor:ColorHexadecimal(Color_Text_6666, 1.0) btnTitle:@"搜索" btnColor:ColorHexadecimal(Color_Text_6666,1.0)];
    searchBar.delegate = self;
    self.searchBar = searchBar;
    [self addSubview:searchBar];
    WS(ws)
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(ws);
        make.height.mas_equalTo(44);
    }];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self searchClickEvent];
    [searchBar resignFirstResponder];
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [searchBar resignFirstResponder];
        [self searchClickEvent];
        return NO;
    }
    return YES;
}

- (void)_layoutButtonView {
    UIView *selectView = [[UIView alloc]init];
    selectView.backgroundColor = COLOR_WHITECOLOR;
    UIView *lineView = [PPSSPublicViewManager initializeLineView];
    [selectView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LINEVIEW_WIDTH, 16));
        make.center.equalTo(selectView);
    }];
    PPSSOrderHomeButtonView *dateBtn = [[PPSSOrderHomeButtonView alloc]initWithType:OrderHomeButtonType_Date];
    [dateBtn addTarget:self action:@selector(dateClickEvent) forControlEvents:UIControlEventTouchUpInside];
    self.dateBtn = dateBtn;
    [selectView addSubview:dateBtn];
    
    PPSSOrderHomeButtonView *shopBtn = [[PPSSOrderHomeButtonView alloc]initWithType:OrderHomeButtonType_Shop];
    [shopBtn addTarget:self action:@selector(shopClickEvent) forControlEvents:UIControlEventTouchUpInside];
    self.shopBtn = shopBtn;
    [selectView addSubview:shopBtn];
    
    [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(selectView);
    }];
    [shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateBtn.mas_right).with.offset(LINEVIEW_WIDTH);
        make.right.bottom.top.equalTo(selectView);
        make.width.equalTo(dateBtn.mas_width);
    }];
    [self addSubview:selectView];
    WS(ws)
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(ws).with.offset(-LINEVIEW_WIDTH);
        make.height.mas_equalTo(44);
    }];
}
@end
