//
//  LCUserMessageModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/23.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserMessageModel.h"

@implementation LCUserMessageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"birthday" : @"response.birthday",
             @"sex" : @"response.sex",
             @"mchid" : @"response.mchid",
             @"mobile" : @"response.mobile",
             @"money" : @"response.money",
             @"nickname" : @"response.nickname",
             @"userId" : @"response.uid"
             };
}
@end
