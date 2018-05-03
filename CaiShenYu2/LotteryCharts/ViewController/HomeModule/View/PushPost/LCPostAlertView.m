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
@property (weak, nonatomic) IBOutlet UIButton *alertBtn;

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
    NSInteger tag = btn.tag - 300;
    if (tag == 1) {
        if (self.alertBlock) {
            if (self.alertBtn.selected) {
                [kUserMessageManager setMessageManagerForBoolWithKey:kPushPost_Alter value:YES];
            }
            self.alertBlock(tag);
        }
    }
    
    [self removeFromSuperview];
}

@end
