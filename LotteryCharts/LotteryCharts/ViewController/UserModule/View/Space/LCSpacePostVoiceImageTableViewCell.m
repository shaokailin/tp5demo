//
//  LCSpacePostVoiceImageTableViewCell.m
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpacePostVoiceImageTableViewCell.h"
@interface LCSpacePostVoiceImageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *postIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *pushTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *postContentLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopHeight;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;
@property (weak, nonatomic) IBOutlet UILabel *rewardLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *voiceLbl;
@end
@implementation LCSpacePostVoiceImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ViewBorderLayer(self.imageView1, ColorHexadecimal(0x7d7d7d, 1.0), 1.0);
    ViewBorderLayer(self.imageView2, ColorHexadecimal(0x7d7d7d, 1.0), 1.0);
    ViewBorderLayer(self.imageView3, ColorHexadecimal(0x7d7d7d, 1.0), 1.0);
}
- (void)setupCellContentWithPostId:(NSString *)postId pushTime:(NSString *)pushTime postContent:(NSString *)postContent commment:(NSString *)commentCount rewardCount:(NSString *)rewardCount money:(NSString *)money images:(NSArray *)images voiceSecond:(NSString *)voiceSecond {
    self.postIdLbl.text = postId;
    self.pushTimeLbl.text = pushTime;
    self.postContentLbl.text = postContent;
    self.commentLbl.text = commentCount;
    self.rewardLbl.text = rewardCount;
    self.imageTopHeight.constant = KJudgeIsNullData(postContent) ? 10 : 0;
    self.moneyLbl.text = NSStringFormat(@"%@金币查看内容",money);
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [self.contentView viewWithTag:200 + i];
        if (i < images.count) {
            imageView.hidden = NO;
        }else {
            imageView.hidden = YES;
        }
    }
    self.voiceLbl.text = NSStringFormat(@"%@''",voiceSecond);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
