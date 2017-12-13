//
//  LCSignTableViewCell.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSignTableViewCell.h"

@implementation LCSignTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupContentWithIndex:(NSInteger)index content:(NSString *)content {
    if (index == 0) {
        self.titleLbl.text = NSStringFormat(@"已获取%@枚签到银币",content);
    }else {
        self.titleLbl.text = NSStringFormat(@"共获得%@枚签到银币",content);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
