//
//  LCGuessUerListCell.m
//  LotteryCharts
//
//  Created by 程磊 on 2018/3/26.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCGuessUerListCell.h"

@implementation LCGuessUerListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImageView, 25);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name mashiID:(NSString *)mashiID number:(NSString *)number creattime:(NSString *)creattime money:(NSString *)money{
    if (KJudgeIsNullData(photo)) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:photo]];
    }
   
    self.nameLab.text = name;
    self.mashiIDLab.text = NSStringFormat(@"码师ID:%@",mashiID);
    self.countLab.text = NSStringFormat(@"%@份",number);
    self.moneyLab.text = NSStringFormat(@"%@银币 / 份",money);
    self.timeLab.text = NSStringFormat(@"%@",creattime);
}
@end
