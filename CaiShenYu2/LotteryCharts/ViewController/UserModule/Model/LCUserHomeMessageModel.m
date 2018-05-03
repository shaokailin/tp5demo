//
//  LCUserHomeMessageModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserHomeMessageModel.h"

@implementation LCUserHomeMessageModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user_info" : [LCUserMessageModel class],
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"user_info" : @"response.user_info",
             @"follow_count" : @"response.follow_count",
             @"team_count" : @"response.team_count",
             };
}
@end
