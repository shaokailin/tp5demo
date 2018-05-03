//
//  LCWalletHeaderView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/15.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WalletHeaderBlock)(NSInteger type);
@interface LCWalletHeaderView : UIView
@property (nonatomic, copy) WalletHeaderBlock headerBlock;
- (void)setupMoney:(NSString *)money;
@end
