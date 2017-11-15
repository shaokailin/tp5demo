//
//  LCSpacePostTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCSpacePostTableViewCell = @"LCSpacePostTableViewCell";
@interface LCSpacePostTableViewCell : UITableViewCell
- (void)setupCellContentWithPostId:(NSString *)postId pushTime:(NSString *)pushTime postContent:(NSString *)postContent commment:(NSString *)commentCount rewardCount:(NSString *)rewardCount money:(NSString *)money images:(NSArray *)images;
@end
