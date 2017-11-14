//
//  LCRewardRecordHeaderTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RewardRecordHeaderBlock)(NSInteger type);
static NSString * const kLCRewardRecordHeaderTableViewCell = @"LCRewardRecordHeaderTableViewCell";
@interface LCRewardRecordHeaderTableViewCell : UITableViewCell
@property (nonatomic, copy) RewardRecordHeaderBlock headerBlock;
- (void)setupCellContentWithMoney:(NSString *)money count:(NSString *)count;
@end
