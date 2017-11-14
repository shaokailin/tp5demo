//
//  LCUserMessageTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMessageTableViewCell.h"
@interface LCUserMessageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@end
@implementation LCUserMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContentWithTitle:(NSString *)title detail:(NSString *)detail isShowArrow:(BOOL)isShow {
    _titleLbl.text = title;
    _detailLbl.text = detail;
    _arrowImage.hidden = !isShow;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
