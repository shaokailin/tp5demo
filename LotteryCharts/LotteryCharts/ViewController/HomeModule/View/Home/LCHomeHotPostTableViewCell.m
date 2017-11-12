//
//  LCHomeHotPostTableViewCell.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeHotPostTableViewCell.h"
@interface LCHomeHotPostTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *postTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *postNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *sendTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeWidth;


@end
@implementation LCHomeHotPostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImage, 30);
    self.photoImage.backgroundColor = ColorHexadecimal(0xb5b5b5, 1.0);
    _timeWidth.constant = SCREEN_WIDTH == 320 ?  42 : WIDTH_RACE_5S(60);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
