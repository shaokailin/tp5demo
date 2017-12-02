//
//  LCExchangeMainVC.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/16.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef void (^ExchangeSuccess)(BOOL isSuccess);
@interface LCExchangeMainVC : LSKBaseViewController
@property (nonatomic, copy) ExchangeSuccess success;
@end
