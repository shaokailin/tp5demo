//
//  LCHistoryLotteryListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHistoryLotteryListModel.h"

@implementation LCHistoryLotteryListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LC3DLotteryModel class],
             };
}

@end
