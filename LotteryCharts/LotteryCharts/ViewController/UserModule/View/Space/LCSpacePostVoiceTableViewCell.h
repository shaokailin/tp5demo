//
//  LCSpacePostVoiceTableViewCell.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCSpacePostVoiceTableViewCell = @"LCSpacePostVoiceTableViewCell";
@interface LCSpacePostVoiceTableViewCell : UITableViewCell
- (void)setupCellContentWithPostId:(NSString *)postId pushTime:(NSString *)pushTime postContent:(NSString *)postContent commment:(NSString *)commentCount rewardCount:(NSString *)rewardCount money:(NSString *)money voiceSecond:(NSString *)voiceSecond;
@end
