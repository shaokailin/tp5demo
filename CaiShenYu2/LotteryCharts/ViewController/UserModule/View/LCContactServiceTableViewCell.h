//
//  LCContactServiceTableViewCell.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/18.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCContactServiceTableViewCell = @"LCContactServiceTableViewCell";
@interface LCContactServiceTableViewCell : UITableViewCell
- (void)setupContentWithPhoto:(NSString *)photo name:(NSString *)name detail:(NSString *)detail wxNumber:(NSString *)wxNumber qqNumber:(NSString *)qqNumber mobile:(NSString *)mobile;
@end
