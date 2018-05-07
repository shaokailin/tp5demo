//
//  LCPublicNotice1Cell.h
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCPublicNotice1Cell = @"LCPublicNotice1Cell";
@interface LCPublicNotice1Cell : UITableViewCell
- (void)setupCellContent:(NSString *)title detail:(NSString *)detail time:(NSString *)time;
@end
