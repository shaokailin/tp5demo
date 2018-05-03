//
//  LCSpacePostTitleTableViewCell.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpacePostTitleTableViewCell.h"
@interface LCSpacePostTitleTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *pushTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *postContentLbl;
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;
@property (weak, nonatomic) IBOutlet UILabel *rewardLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@end
@implementation LCSpacePostTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContentWithPostId:(NSString *)postId pushTime:(NSString *)pushTime postContent:(NSString *)postContent commment:(NSString *)commentCount rewardCount:(NSString *)rewardCount money:(NSString *)money {
    self.postIdLbl.text = postId;
    self.pushTimeLbl.text = pushTime;
    self.postContentLbl.text = postContent;
    self.commentLbl.text = commentCount;
    self.rewardLbl.text = rewardCount;
    self.moneyLbl.text = NSStringFormat(@"%@金币查看内容",money);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
