//
//  LCGuessMainListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessMainListModel.h"

@implementation LCGuessMainListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCGuessMainModel class],
             };
    
}
@end
@implementation LCGuessMainModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"quiz_list" : [LCGuessModel class],
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"mid" : @"id",
             };
}
@end
