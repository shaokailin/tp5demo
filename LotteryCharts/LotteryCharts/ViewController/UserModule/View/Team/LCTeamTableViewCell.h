//
//  LCTeamTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/17.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCTeamTableViewCell = @"LCTeamTableViewCell";
@interface LCTeamTableViewCell : UITableViewCell
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId glodCount:(NSString *)glodCount yinbiCount:(NSString *)ybcount type:(NSInteger)type state:(NSInteger)state;
@end
