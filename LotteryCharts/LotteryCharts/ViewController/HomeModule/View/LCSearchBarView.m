//
//  LCSearchBarView.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/8.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSearchBarView.h"

@implementation LCSearchBarView
{
    UITextField *_searchField;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = ColorHexadecimal(0xdcdcdc, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UITextField *inputText = [LSKViewFactory initializeTextFieldWithDelegate:nil text:nil placeholder:nil textFont:14 textColor:ColorHexadecimal(0x434343, 1.0) placeholderColor:ColorHexadecimal(0xbfbfbf, 1.0) textAlignment:0 borStyle:0 returnKey:UIReturnKeySearch keyBoard:UIKeyboardTypeDefault cleanModel:0];
    _searchField = inputText;
    
}

- (void)setCurrentSearchType:(NSInteger)currentSearchType {
    if (_currentSearchType != currentSearchType) {
        _currentSearchType = currentSearchType;
        switch (currentSearchType) {
            case 0:
                
                break;
                
            default:
                break;
        }
    }
}
@end
