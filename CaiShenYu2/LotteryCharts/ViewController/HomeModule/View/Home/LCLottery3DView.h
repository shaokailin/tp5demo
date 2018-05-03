//
//  LCLottery3DView.h
//  LotteryCharts
//
//  Created by linshaokai on 2017/11/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCLotteryFiveModel.h"
typedef void (^LotteryMoreBlock)(NSInteger type);
@interface LCLottery3DView : UIView
@property (nonatomic, copy) LotteryMoreBlock block;
- (void)setupLottertMessage:(NSArray *)data;
- (void)setupLottertFiveMessage:(LCLotteryFiveModel *)model;
@end
