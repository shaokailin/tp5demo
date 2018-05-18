//
//  LCMeCareCell.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCMeCareCell = @"LCMeCareCell";
@interface LCMeCareCell : UITableViewCell
- (void)setupCellContent:(NSString *)name time:(NSString *)time img:(NSString *)image isRead:(BOOL)isRead;
@end
