//
//  LCUserMessageTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCUserMessageTableViewCell = @"LCUserMessageTableViewCell";
@interface LCUserMessageTableViewCell : UITableViewCell
- (void)setupCellContentWithTitle:(NSString *)title detail:(NSString *)detail isShowArrow:(BOOL)isShow;
@end
