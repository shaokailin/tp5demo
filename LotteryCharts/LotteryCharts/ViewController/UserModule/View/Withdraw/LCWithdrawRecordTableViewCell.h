//
//  LCWithdrawRecordTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/16.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCWithdrawRecordTableViewCell = @"LCWithdrawRecordTableViewCell";
@interface LCWithdrawRecordTableViewCell : UITableViewCell
- (void)setupContentWithType:(NSString *)type time:(NSString *)time money:(NSString *)money;
@end
