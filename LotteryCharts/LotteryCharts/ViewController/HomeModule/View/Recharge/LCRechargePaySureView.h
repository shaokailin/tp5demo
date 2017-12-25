//
//  LCRechargePaySureView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/12.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PayClickBlock)(NSInteger type);
@interface LCRechargePaySureView : UIView
- (void)setupPayTypeWithMoney:(NSString *)money number:(NSString *)number;
@property (nonatomic, copy) PayClickBlock clickBlock;
@end
