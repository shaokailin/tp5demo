//
//  LCTeamTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTeamTableViewCell.h"
@interface LCTeamTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *glodLbl;
@property (weak, nonatomic) IBOutlet UILabel *yinbiLbl;
@property (weak, nonatomic) IBOutlet UILabel *stateLbl;

@end
@implementation LCTeamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImageView, 20);
}
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId glodCount:(NSString *)glodCount yinbiCount:(NSString *)ybcount type:(NSInteger)type state:(NSInteger)state {
    if (KJudgeIsNullData(photo)) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
    self.nameLbl.text = name;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.glodLbl.text = glodCount;
    self.yinbiLbl.text = ybcount;
    if (type == 0) {
        if (state == 0) {
            self.stateLbl.text = @"离线";
        }else {
            self.stateLbl.text = @"在线";
        }
    }else {
        if (state == 0) {
            self.stateLbl.text = @"未签到";
        }else {
            self.stateLbl.text = @"已签到";
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
