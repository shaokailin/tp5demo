//
//  LCRewardRecordTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCRewardRecordTableViewCell = @"LCRewardRecordTableViewCell";
@interface LCRewardRecordTableViewCell : UITableViewCell
- (void)setupContentWithId:(NSString *)postId time:(NSString *)time count:(NSString *)count money:(NSString *)money;
@end
