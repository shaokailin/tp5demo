//
//  LCRankingGoldTableViewCell.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/19.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRankingGoldTableViewCell.h"
@interface LCRankingGoldTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *indexLbl;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *userIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *postTitleLbl;

@end
@implementation LCRankingGoldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImage, 25.0);
}
- (void)setupContentWithIndex:(NSInteger)index photo:(NSString *)photo name:(NSString *)name userId:(NSString *)userId postId:(NSString *)postId postTitle:(NSString *)postTitle {
    self.indexLbl.text = NSStringFormat(@"%zd",index);
    self.nameLbl.text = name;
    if (KJudgeIsNullData(photo)) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil];
    }
    self.userIdLbl.text = NSStringFormat(@"码师ID:%@",userId);
    self.postIdLbl.text = NSStringFormat(@"帖子ID:%@",postId);
    self.postTitleLbl.text = postTitle;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
