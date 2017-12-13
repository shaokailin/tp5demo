//
//  LCSignTableViewCell.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/12/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCSignTableViewCell = @"LCSignTableViewCell";
@interface LCSignTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
- (void)setupContentWithIndex:(NSInteger)index content:(NSString *)content;
@end
