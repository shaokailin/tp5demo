//
//  LCVipTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^VipBlock)(id clickCell);
static NSString * const kLCVipTableViewCell = @"LCVipTableViewCell";
@interface LCVipTableViewCell : UITableViewCell
@property (nonatomic, copy) VipBlock vipBlock;
- (void)setupContent:(NSInteger)index photo:(NSString *)photo postTitle:(NSString *)postTitle name:(NSString *)name money:(NSString *)money robMoney:(NSString *)robMoney userId:(NSString *)userId isShowBtn:(BOOL)isShow ;
@end
