//
//  LCSpacePostModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpacePostModel.h"

@implementation LCSpacePostModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"data" : [LCPostModel class]
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"data" : @"response",
             };
}
@end
