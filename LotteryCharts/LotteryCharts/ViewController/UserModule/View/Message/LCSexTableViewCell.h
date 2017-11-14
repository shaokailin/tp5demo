//
//  LCSexTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SexSelectBlock)(NSInteger type);
static NSString * const kLCSexTableViewCell = @"LCSexTableViewCell";
@interface LCSexTableViewCell : UITableViewCell
@property (nonatomic, copy) SexSelectBlock sexBlock;
- (void)setupCurrentSex:(NSInteger)sex;
@end
