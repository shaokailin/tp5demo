//
//  LCAttentionTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCAttentionTableViewCell.h"
@interface LCAttentionTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *glodLbl;
@property (weak, nonatomic) IBOutlet UILabel *yinbiLbl;

@end
@implementation LCAttentionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImageView, 20);
    self.photoImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpUserSpace)];
    [self.photoImageView addGestureRecognizer:tap];
}
- (void)jumpUserSpace {
    if (self.photoBlock) {
        self.photoBlock(self);
    }
}
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId glodCount:(NSString *)glodCount yinbiCount:(NSString *)ybcount{
    if (KJudgeIsNullData(photo)) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:photo]];
    }
    self.nameLbl.text = name;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.glodLbl.text = NSStringFormat(@"金币:%@",glodCount);
    self.yinbiLbl.text = NSStringFormat(@"银币:%@",ybcount);;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
