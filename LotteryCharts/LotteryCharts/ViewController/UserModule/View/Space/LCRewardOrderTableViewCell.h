//
//  LCRewardOrderTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCRewardOrderTableViewCell = @"LCRewardOrderTableViewCell";
@interface LCRewardOrderTableViewCell : UITableViewCell
- (void)setupContentWithName:(NSString *)name userId:(NSString *)userId index:(NSInteger)index photo:(NSString *)photo;
@end
