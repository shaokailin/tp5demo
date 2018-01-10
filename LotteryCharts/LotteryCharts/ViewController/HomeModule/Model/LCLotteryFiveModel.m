//
//  LCLotteryFiveModel.m
//  LotteryCharts
//
//  Created by linshaokai on 2018/1/6.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCLotteryFiveModel.h"

@implementation LCLotteryFiveModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"p_name" : @"response.p_name",
             @"content" : @"response.content",
             };
}
@end
