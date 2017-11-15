//
//  LCSearchBarView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSearchBarView.h"
@interface LCSearchBarView ()<UITextFieldDelegate>
@property (nonatomic, weak) UITextField *searchField;
@property (nonatomic, weak) UILabel *typelLbl;
@end
@implementation LCSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ColorHexadecimal(0xdcdcdc, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContent:(NSString *)title {
    self.typelLbl.text = title;
}
- (void)_layoutMainView {
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (KJudgeIsNullData(textField.text)) {
        if (self.searchBlock) {
            self.searchBlock(1, textField.text);
        }
    }
    return YES;
}
@end
