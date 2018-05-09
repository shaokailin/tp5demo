//
//  LCMeShangCell.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCMeShangCell.h"
@interface LCMeShangCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;


@end
@implementation LCMeShangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImg, 17.0);
}
- (void)setupCellContent:(NSString *)name money:(NSString *)money time:(NSString *)time img:(NSString *)image{
    if (KJudgeIsNullData(image)) {
        [self.photoImg sd_setImageWithURL:[NSURL URLWithString:image]];
    }else {
        self.photoImg.image = nil;
    }
    self.nameLbl.text = name;
    self.timeLbl.text = time;
    self.moneyLbl.text = NSStringFormat(@"%@金币",money);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
