//
//  LCMeCareCell.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCMeCareCell.h"
@interface LCMeCareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImg;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end
@implementation LCMeCareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImg, 17.0);
    ViewRadius(self.redView, 5.0);
}
- (void)setupCellContent:(NSString *)name time:(NSString *)time img:(NSString *)image isRead:(BOOL)isRead {
    if (KJudgeIsNullData(image)) {
        [self.photoImg sd_setImageWithURL:[NSURL URLWithString:image]];
    }else {
        self.photoImg.image = nil;
    }
    self.redView.hidden = isRead;
    self.nameLbl.text = name;
    self.timeLbl.text = time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
