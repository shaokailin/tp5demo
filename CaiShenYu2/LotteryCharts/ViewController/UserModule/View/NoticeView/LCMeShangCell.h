//
//  LCMeShangCell.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCMeShangCell = @"LCMeShangCell";
@interface LCMeShangCell : UITableViewCell
- (void)setupCellContent:(NSString *)name money:(NSString *)money time:(NSString *)time img:(NSString *)image;
@end
