//
//  LCVipRankingTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^VipRankingBlock)(id clickCell);
static NSString * const kLCVipRankingTableViewCell = @"LCVipRankingTableViewCell";
@interface LCVipRankingTableViewCell : UITableViewCell
@property (nonatomic, copy) VipRankingBlock vipRankingBlock;
- (void)setupContent:(NSInteger)index photo:(NSString *)photo postTitle:(NSString *)postTitle name:(NSString *)name money:(NSString *)money robMoney:(NSString *)robMoney userId:(NSString *)userId isShowBtn:(NSInteger)isShow;
- (void)setupTypeThreeContent:(NSString *)money isThree:(BOOL)isThree;
@end
