//
//  LCWalletMoneyTableViewCell.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kLCWalletMoneyTableViewCell = @"LCWalletMoneyTableViewCell";
@interface LCWalletMoneyTableViewCell : UITableViewCell
- (void)setupCellContentWithTitle:(NSString *)title money:(NSString *)money;
@end
