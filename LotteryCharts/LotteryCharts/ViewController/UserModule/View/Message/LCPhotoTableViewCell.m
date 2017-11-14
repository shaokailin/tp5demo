//
//  LCPhotoTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPhotoTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface LCPhotoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImage;

@end
@implementation LCPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.userPhotoImage, 25);
}
- (void)setupUserPhoto:(NSString *)photoString {
    if (KJudgeIsNullData(photoString)) {
        [self.userPhotoImage sd_setImageWithURL:[NSURL URLWithString:photoString] placeholderImage:nil];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
