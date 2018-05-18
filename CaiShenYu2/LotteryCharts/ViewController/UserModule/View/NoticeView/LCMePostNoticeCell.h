//
//  LCMePostNoticeCell.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCMePostNoticeCell = @"LCMePostNoticeCell";
@interface LCMePostNoticeCell : UITableViewCell
- (void)setupCellContent:(NSString *)name time:(NSString *)time img:(NSString *)image content:(NSString *)content isRead:(BOOL)isRead;
@end
