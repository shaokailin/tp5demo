//
//  LCHistoryVipTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCHistoryVipTableViewCell = @"LCHistoryVipTableViewCell";
@interface LCHistoryVipTableViewCell : UITableViewCell
- (void)setupCellContent:(NSString *)postId time:(NSString *)time title:(NSString *)title payMoney:(NSString *)money;
@end
