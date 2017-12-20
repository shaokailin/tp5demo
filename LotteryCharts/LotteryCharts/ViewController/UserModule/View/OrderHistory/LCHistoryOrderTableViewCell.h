//
//  LCHistoryOrderTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCHistoryOrderTableViewCell = @"LCHistoryOrderTableViewCell";
@interface LCHistoryOrderTableViewCell : UITableViewCell
@property (nonatomic, copy) PhotoClickBlock photoBlock;
- (void)setupContentWithPostId:(NSString *)postId pushTime:(NSString *)pushTime photoImage:(NSString *)photoImage name:(NSString *)name userId:(NSString *)userId detail:(NSString *)detail money:(NSString *)money;
@end
