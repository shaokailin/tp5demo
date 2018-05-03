//
//  LCSelectTwoYardsView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/21.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSelectTwoYardsView.h"
@interface LCSelectTwoYardsView ()
{
    NSInteger _select_1;
    NSInteger _select_2;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneBetween;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoBetween;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeBetween;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fortBetween;
@property (weak, nonatomic) IBOutlet UIView *bgView1;
@property (weak, nonatomic) IBOutlet UIView *bgView2;

@end
@implementation LCSelectTwoYardsView
- (void)awakeFromNib {
    [super awakeFromNib];
    _select_1 = -1;
    _select_2 = -1;
    CGFloat width = SCREEN_WIDTH - 20 - 40;
    _oneBetween.constant = self.twoBetween.constant = self.threeBetween.constant = self.fortBetween.constant = (width - 35 * 5) / 4.0;
    self.bgView1.layer.borderWidth = 1.0;
    self.bgView1.layer.borderColor = ColorHexadecimal(0xc9c9c9, 1.0).CGColor;
    self.bgView2.layer.borderWidth = 1.0;
    self.bgView2.layer.borderColor = ColorHexadecimal(0xc9c9c9, 1.0).CGColor;
    for (int i = 0; i < 10; i ++ ) {
        UIButton *btn = [self viewWithTag:300 + i];
        btn.layer.borderWidth = 1.0;
        btn.layer.borderColor = ColorHexadecimal(0x7d7d7d, 1.0).CGColor;
        btn.layer.cornerRadius = 35 / 2.0;
    }
}
- (NSString *)getSelect {
    if (_select_1 == -1 || _select_2 == -1) {
        return nil;
    }else {
        return NSStringFormat(@"%zd,%zd",_select_1,_select_2);
    }
}
- (IBAction)selectBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (!btn.selected) {
        if (_select_1 == -1) {
            _select_1 = btn.tag - 300;
        }else if (_select_2 == -1){
            _select_2 = btn.tag - 300;
        }else {
            UIButton *otherBtn = [self viewWithTag:_select_1 + 300];
            otherBtn.selected = NO;
            otherBtn.layer.borderWidth = 1.0;
            _select_1 = _select_2;
            _select_2 = btn.tag - 300;
        }
        btn.layer.borderWidth = 0;
        btn.selected = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
