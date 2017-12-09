//
//  LCGuessMainMoreModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/8.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessMainMoreModel.h"

@implementation LCGuessMainMoreModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCGuessModel class],
             };
    
}
@end
