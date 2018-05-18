//
//  LCRankingRenTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRankingRenTableViewCell.h"
@interface LCRankingRenTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *rangkingImage;
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UIImageView *rankingImage1;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UIButton *atentionBtn;

@end
@implementation LCRankingRenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     ViewBoundsRadius(self.photoImage, 20.0);
    self.atentionBtn.layer.cornerRadius = 5;
    self.atentionBtn.layer.borderWidth = 1;
    self.atentionBtn.layer.masksToBounds = YES;
    self.atentionBtn.layer.borderColor = ColorHexadecimal(0xf6a623, 1.0).CGColor;
    self.photoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpUserSpace)];
    [self.photoImage addGestureRecognizer:tap];
}
- (void)jumpUserSpace {
    if (self.photoBlock) {
        self.photoBlock(self);
    }
}
- (void)setupContent:(NSInteger)index photo:(NSString *)photo name:(NSString *)name userId:(NSString *)userId count:(NSString *)count {
    self.indexLbl.text = NSStringFormat(@"%zd",index);
    self.nameLbl.text = name;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.countLbl.text = count;
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }else {
        self.photoImage.image = nil;
    }
    if (index < 4) {
        self.indexLbl.textColor = ColorHexadecimal(0xffffff, 1.0);
        self.rangkingImage.hidden = NO;
        self.rankingImage1.hidden = NO;
    }else {
        self.indexLbl.textColor = ColorHexadecimal(0xf6a623, 1.0);
        self.rangkingImage.hidden = YES;
        self.rankingImage1.hidden = YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
