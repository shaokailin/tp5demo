//
//  LCHomeHotPostTableViewCell.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCHomeHotPostTableViewCell = @"LCHomeHotPostTableViewCell";
@interface LCHomeHotPostTableViewCell : UITableViewCell
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId postId:(NSString *)postId time:(NSString *)time title:(NSString *)title showCount:(NSString *)showCount money:(NSString *)money;
@end
