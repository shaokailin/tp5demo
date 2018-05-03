//
//  LCHistoryGuessTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCHistoryGuessTableViewCell = @"LCHistoryGuessTableViewCell";
@interface LCHistoryGuessTableViewCell : UITableViewCell
- (void)setupCellContent:(NSString *)postId time:(NSString *)time type:(NSInteger)type title:(NSString *)title payMoney:(NSString *)money hasBuy:(NSString *)hasBuy betState:(NSInteger)state;
@end
