//
//  LCHistoryLotteryTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/19.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCHistoryLotteryTableViewCell = @"LCHistoryLotteryTableViewCell";
@interface LCHistoryLotteryTableViewCell : UITableViewCell
- (void)setupContentWithTime:(NSString *)time issue:(NSString *)issue testRun:(NSString *)testRun number1:(NSString *)number1 number2:(NSString *)number2 number3:(NSString *)number3;
@end
