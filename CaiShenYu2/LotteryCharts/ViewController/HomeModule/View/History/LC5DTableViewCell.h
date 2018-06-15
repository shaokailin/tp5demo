//
//  LC5DTableViewCell.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/6/15.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLC5DTableViewCell = @"LC5DTableViewCell";
@interface LC5DTableViewCell : UITableViewCell
- (void)setupContentWithTime:(NSString *)time issue:(NSString *)issue number1:(NSString *)number1 number2:(NSString *)number2 number4:(NSString *)number4  number3:(NSString *)number3 number5:(NSString *)number5;
@end
