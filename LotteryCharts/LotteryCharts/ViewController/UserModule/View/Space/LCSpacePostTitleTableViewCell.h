//
//  LCSpacePostTitleTableViewCell.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCSpacePostTitleTableViewCell = @"LCSpacePostTitleTableViewCell";
@interface LCSpacePostTitleTableViewCell : UITableViewCell
- (void)setupCellContentWithPostId:(NSString *)postId pushTime:(NSString *)pushTime postContent:(NSString *)postContent commment:(NSString *)commentCount rewardCount:(NSString *)rewardCount money:(NSString *)money;
@end
