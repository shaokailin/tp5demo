//
//  LCPostHeaderTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCPostHeaderTableViewCell = @"LCPostHeaderTableViewCell";
@interface LCPostHeaderTableViewCell : UITableViewCell
- (void)setupCount:(NSString *)count type:(NSInteger)type ;
@end
