//
//  LCPostAlertView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostAlertView.h"
@interface LCPostAlertView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation LCPostAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)alterClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
}
- (IBAction)buttonClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.alertBlock) {
        self.alertBlock(btn.tag - 300);
    }
    [self removeFromSuperview];
}

@end
