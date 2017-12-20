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
@property (nonatomic, copy) PhotoClickBlock photoBlock;
- (void)setupContent:(NSInteger)index photo:(NSString *)photo postTitle:(NSString *)postTitle name:(NSString *)name money:(NSString *)money robMoney:(NSString *)robMoney userId:(NSString *)userId isShowBtn:(NSInteger)isShow time:(NSString *)time postId:(NSString *)postId mch_no:(NSString *)mch_no;
- (void)setupTypeThreeContent:(NSString *)money isThree:(BOOL)isThree;
- (void)setupPushContent:(NSInteger)index photo:(NSString *)photo postTitle:(NSString *)postTitle name:(NSString *)name showCount:(NSString *)showCount userId:(NSString *)userId isShowBtn:(NSInteger)isShow time:(NSString *)time postId:(NSString *)postId;
- (void)setupShangContent:(NSInteger)index photo:(NSString *)photo postTitle:(NSString *)postTitle name:(NSString *)name money:(NSString *)money userId:(NSString *)userId isShowBtn:(NSInteger)isShow time:(NSString *)time postId:(NSString *)postId;
@end
