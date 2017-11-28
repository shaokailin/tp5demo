//
//  LCSelectSizeView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/21.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSelectSizeView.h"
@interface LCSelectSizeView ()
@property (weak, nonatomic) IBOutlet UIView *bgView1;
@property (weak, nonatomic) IBOutlet UIView *bgView2;
@property (nonatomic, assign) NSInteger currentType;
@end
@implementation LCSelectSizeView

- (void)awakeFromNib {
    [super awakeFromNib];
    _currentType = 0;
    self.bgView1.layer.borderWidth = 1.0;
    self.bgView1.layer.borderColor = ColorHexadecimal(0xc9c9c9, 1.0).CGColor;
    self.bgView2.layer.borderWidth = 1.0;
    self.bgView2.layer.borderColor = ColorHexadecimal(0xc9c9c9, 1.0).CGColor;
    
}

- (IBAction)changeType:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (!btn.selected) {
        UIButton *otherBtn = [self viewWithTag:300 + _currentType];
        otherBtn.selected = NO;
        _currentType = btn.tag - 300;
        btn.selected = YES;
    }
}
- (NSString *)getSelect {
    return _currentType == 0 ? @"大":@"小";
}
@end
