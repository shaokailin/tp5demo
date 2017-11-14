//
//  LCSexTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSexTableViewCell.h"
@interface LCSexTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *boyBtn;
@property (weak, nonatomic) IBOutlet UIButton *girlBtn;

@end
@implementation LCSexTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCurrentSex:(NSInteger)sex {
    if (sex == 1) {
        self.girlBtn.selected = YES;
        self.boyBtn.selected = NO;
    }else {
        self.girlBtn.selected = NO;
        self.boyBtn.selected = YES;
    }
}
- (IBAction)boySelect:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (!btn.selected) {
        self.girlBtn.selected = NO;
        self.boyBtn.selected = YES;
        if (self.sexBlock) {
            self.sexBlock(0);
        }
    }
}
- (IBAction)girlSelect:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (!btn.selected) {
        self.girlBtn.selected = YES;
        self.boyBtn.selected = NO;
        if (self.sexBlock) {
            self.sexBlock(1);
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
