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

@end
@implementation LCUserHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
- (void)setupContentTitle:(NSString *)title detail:(NSString *)detail icon:(NSString *)icon {
    self.iconImageView.image = ImageNameInit(icon);
    self.titleLbl.text = title;
    self.detailLbl.text = detail;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
