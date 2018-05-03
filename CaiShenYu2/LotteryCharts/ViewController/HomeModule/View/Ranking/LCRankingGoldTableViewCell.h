//
//  LCRankingGoldTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/19.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCRankingGoldTableViewCell = @"LCRankingGoldTableViewCell";
@interface LCRankingGoldTableViewCell : UITableViewCell
- (void)setupContentWithIndex:(NSInteger)index photo:(NSString *)photo name:(NSString *)name userId:(NSString *)userId postId:(NSString *)postId postTitle:(NSString *)postTitle;
@end
