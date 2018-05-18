//
//  LCRewardOrderTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRewardOrderTableViewCell.h"
@interface LCRewardOrderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;

@end
@implementation LCRewardOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.userPhoto, 25);
    self.userPhoto.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpUserSpace)];
    [self.userPhoto addGestureRecognizer:tap];
}
- (void)jumpUserSpace {
    if (self.photoBlock) {
        self.photoBlock(self);
    }
}
- (void)setupContentWithName:(NSString *)name userId:(NSString *)userId index:(NSInteger)index photo:(NSString *)photo money:(NSString *)money {
    self.nameLbl.text = name;
    self.moneyLbl.text = money;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.indexLbl.text = NSStringFormat(@"%zd",index);
    if (KJudgeIsNullData(photo)) {
        [self.userPhoto sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }else {
        self.userPhoto.image = nil;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
