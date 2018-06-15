//
//  LCHomeHotPostTableViewCell.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomeHotPostTableViewCell.h"
@interface LCHomeHotPostTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *postTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *postNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *sendTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeWidth;


@end
@implementation LCHomeHotPostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImage, 15);
    self.photoImage.backgroundColor = ColorHexadecimal(0xb5b5b5, 1.0);
    _timeWidth.constant = SCREEN_WIDTH == 320 ?  42 : WIDTH_RACE_5S(60);
    self.photoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpUserSpace)];
    [self.photoImage addGestureRecognizer:tap];
}
- (void)jumpUserSpace {
    if (self.photoBlock) {
        self.photoBlock(self);
    }
}
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId postId:(NSString *)postId time:(NSString *)time title:(NSString *)title showCount:(NSString *)showCount money:(NSString *)money funs:(NSString *)funs_count comtent:(NSInteger)comtent {
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }else {
        self.photoImage.image = nil;
    }
    self.postNameLbl.text = name;
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    self.sendTimeLbl.text = time;
    self.postTitleLbl.text = title;
    self.countLbl.text = NSStringFormat(@"评论数:%ld   阅读数:%@   粉丝:%@",comtent,showCount,funs_count);
    self.moneyLbl.text = money;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
