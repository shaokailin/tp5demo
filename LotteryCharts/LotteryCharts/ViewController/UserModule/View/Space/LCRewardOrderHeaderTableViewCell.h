//
//  LCRewardOrderHeaderTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RewardOrderHeaderBlock)(NSInteger type);
static NSString * const kLCRewardOrderHeaderTableViewCell = @"LCRewardOrderHeaderTableViewCell";
@interface LCRewardOrderHeaderTableViewCell : UITableViewCell
@property (nonatomic, copy) RewardOrderHeaderBlock headerBlock;
- (void)setupCellContentWithCount:(NSString *)count;
- (void)setupState:(NSInteger)type;
@end
