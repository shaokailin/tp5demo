//
//  LCSpaceGuessTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCSpaceGuessTableViewCell = @"LCSpaceGuessTableViewCell";
@interface LCSpaceGuessTableViewCell : UITableViewCell
- (void)setupCellContentWithId:(NSString *)postId time:(NSString *)time title:(NSString *)title;
@end
