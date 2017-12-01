//
//  LCTaskModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTaskModel.h"

@implementation LCTaskModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"all_money" : @"response.all_money",
             @"fish_ing" : @"response.fish_ing",
             @"is_sign" : @"response.is_sign",
             @"all_sign" : @"response.all_sign",
             @"is_share" : @"response.is_share"
             };
}
@end
