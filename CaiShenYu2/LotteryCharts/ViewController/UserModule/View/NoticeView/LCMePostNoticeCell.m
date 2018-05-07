//
//  LCMePostNoticeCell.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCMePostNoticeCell.h"

@interface LCMePostNoticeCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@end
@implementation LCMePostNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.userPhoto, 17.0);
}
- (void)setupCellContent:(NSString *)name time:(NSString *)time img:(NSString *)image content:(NSString *)content {
    if (KJudgeIsNullData(image)) {
        [self.userPhoto sd_setImageWithURL:[NSURL URLWithString:image]];
    }
    self.nameLbl.text = name;
    self.timeLbl.text = time;
    self.contentLbl.text = content;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
