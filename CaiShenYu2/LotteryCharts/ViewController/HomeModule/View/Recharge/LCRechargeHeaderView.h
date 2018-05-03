//
//  LCRechargeHeaderView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RechargeMoneyBlock)(NSString *money);
typedef void (^RechargeTypeBlock) (NSInteger type);
@interface LCRechargeHeaderView : UIView
@property (nonatomic, copy) RechargeTypeBlock typeBlock;
@property (nonatomic, copy) RechargeMoneyBlock moneyBlock;
- (void)setupPayMoneyType:(NSArray *)array;
@end
