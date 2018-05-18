//
//  LCPhotoTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPhotoTableViewCell.h"
@interface LCPhotoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImage;

@end
@implementation LCPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.userPhotoImage, 25);
    self.userPhotoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePhotoClick)];
    [self.userPhotoImage addGestureRecognizer:tap];
}
- (void)changePhotoClick {
    if (self.block) {
        self.block(YES);
    }
}
- (void)setupUserPhoto:(id)photoString {
    if ([photoString isKindOfClass:[UIImage class]]) {
        self.userPhotoImage.image = photoString;
    }else {
        if (KJudgeIsNullData(photoString)) {
            [self.userPhotoImage sd_setImageWithURL:[NSURL URLWithString:photoString] placeholderImage:nil];
        }else {
            self.userPhotoImage.image = nil;
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
