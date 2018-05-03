//
//  LCPostShowTypeView.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostShowTypeView.h"
@interface LCPostShowTypeView ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *alertLbl;
@end
@implementation LCPostShowTypeView
- (void)awakeFromNib {
    [super awakeFromNib];
    _currentShow = -1;
    self.bgView.layer.borderWidth = 1.0;
    self.bgView.layer.borderColor = ColorHexadecimal(0xc9c9c9, 1.0).CGColor;
    self.bgView.hidden = YES;
    self.alertLbl.hidden = YES;
}
- (IBAction)changeShow:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (!btn.selected) {
        if (_currentShow != -1) {
            UIButton *otherBtn = [self viewWithTag:300 + _currentShow];
            otherBtn.selected = NO;
        }
        _currentShow = btn.tag - 300;
        btn.selected = YES;
    }else {
        btn.selected = NO;
        _currentShow = -1;
    }
    if (_currentShow != 1) {
        self.bgView.hidden = YES;
        self.alertLbl.hidden = YES;
    }else {
        self.bgView.hidden = NO;
        self.alertLbl.hidden = NO;
    }
    if (self.typeBlock) {
        self.typeBlock(_currentShow);
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
