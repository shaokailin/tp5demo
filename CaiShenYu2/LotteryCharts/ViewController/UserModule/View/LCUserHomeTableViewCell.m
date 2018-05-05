//
//  LCUserHomeTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserHomeTableViewCell.h"
@interface LCUserHomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UILabel *redLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redWidth;

@end
@implementation LCUserHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    ViewBoundsRadius(self.redLable, 23 / 2.0);
    // Initialization code
}
- (void)setupContentTitle:(NSString *)title detail:(NSString *)detail icon:(NSString *)icon count:(NSInteger)count{
    self.iconImageView.image = ImageNameInit(icon);
    self.titleLbl.text = title;
    self.detailLbl.text = detail;
    if(count < 1) {
        self.redLable.hidden = YES;
    }else {
        self.redLable.hidden = NO;
        if (count < 100){
            self.redLable.text = NSStringFormat(@"%@",@(count));
            self.redWidth.constant = 23;
        }else {
            self.redLable.text = @"99+";
            self.redWidth.constant = 32;
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
