//
//  LCUserMessageModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/30.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMessageModel.h"

@implementation LCUserMessageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"userId" : @"uid",
             };
}
@end
