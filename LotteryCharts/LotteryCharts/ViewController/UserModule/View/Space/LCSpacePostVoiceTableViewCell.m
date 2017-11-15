//
//  LCSpacePostVoiceTableViewCell.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpacePostVoiceTableViewCell.h"
@interface LCSpacePostVoiceTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *pushTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *postContentLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *voiceTopHeight;
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;
@property (weak, nonatomic) IBOutlet UILabel *rewardLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *voiceLbl;

@end
@implementation LCSpacePostVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContentWithPostId:(NSString *)postId pushTime:(NSString *)pushTime postContent:(NSString *)postContent commment:(NSString *)commentCount rewardCount:(NSString *)rewardCount money:(NSString *)money voiceSecond:(NSString *)voiceSecond {
    self.postIdLbl.text = postId;
    self.pushTimeLbl.text = pushTime;
    self.postContentLbl.text = postContent;
    self.commentLbl.text = commentCount;
    self.rewardLbl.text = rewardCount;
    self.voiceTopHeight.constant = KJudgeIsNullData(postContent) ? 13 : 0;
    self.moneyLbl.text = NSStringFormat(@"%@金币查看内容",money);
    self.voiceLbl.text = NSStringFormat(@"%@''",voiceSecond);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
