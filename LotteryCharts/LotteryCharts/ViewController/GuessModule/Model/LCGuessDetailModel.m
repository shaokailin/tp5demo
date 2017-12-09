//
//  LCGuessDetailModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessDetailModel.h"

@implementation LCGuessDetailModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCGuessModel class],
             };
    
}
@end
