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

@end
@implementation LCRankingPushTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBoundsRadius(self.photoImage, 30.0);
}
- (void)setupContentWithIndex:(NSInteger)index photo:(NSString *)photo name:(NSString *)name userId:(NSString *)userId pushTime:(NSString *)pushTime postId:(NSString *)postId postTitle:(NSString *)postTitle count:(NSString *)count {
    self.indexLbl.text = NSStringFormat(@"%zd",index);
    self.nameLbl.text = name;
    self.userIdLbl.text = userId;
    self.pushTimeLbl.text = pushTime;
    self.postIdLbl.text = postId;
    self.postTitleLbl.text = postTitle;
    self.countLbl.text = count;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
