//
//  LCUserHomeTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCUserHomeTableViewCell = @"LCUserHomeTableViewCell";
@interface LCUserHomeTableViewCell : UITableViewCell
- (void)setupContentTitle:(NSString *)title detail:(NSString *)detail icon:(NSString *)icon count:(NSInteger)count;
@end
