//
//  LCTaskTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCTaskTableViewCell = @"LCTaskTableViewCell";
@interface LCTaskTableViewCell : UITableViewCell
- (void)setupLeftContent:(NSString *)left right:(NSString *)right;
@end
