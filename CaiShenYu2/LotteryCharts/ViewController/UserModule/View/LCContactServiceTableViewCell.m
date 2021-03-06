//
//  LCContactServiceTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCContactServiceTableViewCell.h"
@interface LCContactServiceTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UILabel *wxLbl;
@property (weak, nonatomic) IBOutlet UILabel *qqLbl;
@property (weak, nonatomic) IBOutlet UILabel *mobileLbl;

@end
@implementation LCContactServiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImageView, 20);
}
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name detail:(NSString *)detail wxNumber:(NSString *)wxNumber qqNumber:(NSString *)qqNumber mobile:(NSString *)mobile{
    if (KJudgeIsNullData(photo)) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }else {
        self.photoImageView.image = nil;
    }
    self.nameLbl.text = name;
    self.detailLbl.text = detail;
    self.wxLbl.text = wxNumber;
    self.qqLbl.text = qqNumber;
    self.mobileLbl.text = mobile;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
