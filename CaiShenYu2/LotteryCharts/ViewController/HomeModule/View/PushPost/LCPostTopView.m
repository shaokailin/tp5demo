//
//  LCPostTopView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostTopView.h"
@interface LCPostTopView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation LCPostTopView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.borderWidth = 1.0;
    self.bgView.layer.borderColor = ColorHexadecimal(0xc9c9c9, 1.0).CGColor;
}
- (IBAction)pushClick:(id)sender {
    if (self.pushBlock) {
        self.pushBlock(YES);
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
