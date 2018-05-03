//
//  LCRankingPushTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/19.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCRankingPushTableViewCell = @"LCRankingPushTableViewCell";
@interface LCRankingPushTableViewCell : UITableViewCell
- (void)setupContentWithIndex:(NSInteger)index photo:(NSString *)photo name:(NSString *)name userId:(NSString *)userId pushTime:(NSString *)pushTime postId:(NSString *)postId postTitle:(NSString *)postTitle count:(NSString *)count;
- (void)setupTypeThreeContent:(NSString *)money isThree:(BOOL)isThree;
@end
