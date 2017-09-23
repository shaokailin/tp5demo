//
//  PPSSMemberListHeaderView.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/9/20.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSMemberListHeaderView.h"
#import "UISearchBar+Extend.h"
@interface PPSSMemberListHeaderView()<UISearchBarDelegate>
@property (nonatomic, weak) UISearchBar *searchBar;
@end
@implementation PPSSMemberListHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
#pragma mark -private
- (void)searchClickEvent {
    if (self.searchBlock) {
        self.searchBlock(self.searchBar.text);
    }
}
#pragma mark -界面初始化
- (void)_layoutMainView {
    [self _layoutSearchView];
}
- (void)_layoutSearchView {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    searchBar.showsCancelButton = YES;
    searchBar.placeholder = @"请输入手机号,姓名";
    [searchBar settingSearchBarBackgroundColor:COLOR_WHITECOLOR textFieldBackgroundColor:ColorHexadecimal(kMainBackground_Color, 1.0) returnKeyType:UIReturnKeySearch textColor:ColorHexadecimal(Color_Text_3333, 1.0) placeholderColor:ColorHexadecimal(Color_Text_6666, 1.0) btnTitle:@"搜索" btnColor:ColorHexadecimal(Color_Text_6666,1.0)];
    searchBar.delegate = self;
    self.searchBar = searchBar;
    [self addSubview:searchBar];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isHasValue]) {
        [self searchClickEvent];
    }
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
@end
