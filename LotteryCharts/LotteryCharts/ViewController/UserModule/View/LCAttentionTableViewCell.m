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
}
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId glodCount:(NSString *)glodCount yinbiCount:(NSString *)ybcount{
    self.nameLbl.text = name;
    self.userIdLbl.text = userId;
    self.glodLbl.text = glodCount;
    self.yinbiLbl.text = ybcount;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
