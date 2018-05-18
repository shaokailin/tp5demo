//
//  LCRankingPushTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/19.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRankingPushTableViewCell.h"
@interface LCRankingPushTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *pushTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *postTitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;

@end
@implementation LCRankingPushTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImage, 30.0);
    self.moneyLbl.text = nil;
}
- (void)setupContentWithIndex:(NSInteger)index photo:(NSString *)photo name:(NSString *)name userId:(NSString *)userId pushTime:(NSString *)pushTime postId:(NSString *)postId postTitle:(NSString *)postTitle count:(NSString *)count {
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }else {
        self.photoImage.image = nil;
    }
    self.indexLbl.text = NSStringFormat(@"%zd",index);
    self.nameLbl.text = name;
    self.userIdLbl.text = NSStringFormat(@"码师:%@",userId);
    self.pushTimeLbl.text = pushTime;
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    self.postTitleLbl.text = postTitle;
    self.countLbl.text = NSStringFormat(@"阅读数:%@",count);
}
- (void)setupTypeThreeContent:(NSString *)money isThree:(BOOL)isThree {
    if (isThree) {
        self.moneyLbl.text = NSStringFormat(@"%@金币",money);
        self.countLbl.text = @"累计：";
    }else {
        self.moneyLbl.text = nil;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
