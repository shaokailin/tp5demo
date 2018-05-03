//
//  LCUserLoginMessageModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserLoginMessageModel.h"

@implementation LCUserLoginMessageModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCUserMessageModel class],
             };
}
@end
