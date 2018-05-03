//
//  LCGuessMainTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/19.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCGuessMainTableViewCell = @"LCGuessMainTableViewCell";
typedef void (^GuessCellBlock) (id clickCell);
@interface LCGuessMainTableViewCell : UITableViewCell
@property (nonatomic, copy) PhotoClickBlock photoBlock;
@property (nonatomic, copy) GuessCellBlock cellBlock;
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name userId:(NSString *)userId postId:(NSString *)postId pushTime:(NSString *)pushTime money:(NSString *)money count:(NSInteger)count openTime:(NSString *)openTime type:(NSInteger)type tieziName:(NSString *)tieziName;
@end
