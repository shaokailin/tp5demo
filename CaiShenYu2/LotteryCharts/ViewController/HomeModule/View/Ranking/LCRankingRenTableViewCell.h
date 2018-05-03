//
//  LCRankingRenTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/20.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *kLCRankingRenTableViewCell = @"LCRankingRenTableViewCell";
@interface LCRankingRenTableViewCell : UITableViewCell
@property (nonatomic, copy) PhotoClickBlock photoBlock;


- (void)setupContent:(NSInteger)index photo:(NSString *)photo name:(NSString *)name userId:(NSString *)userId count:(NSString *)count;
@end
