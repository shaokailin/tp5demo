//
//  LCRechargeHeaderView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RechargeMoneyBlock)(NSString *money);
@interface LCRechargeHeaderView : UIView
@property (nonatomic, copy) RechargeMoneyBlock moneyBlock;
@end
