//
//  LCRechargeMoneyListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/22.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRechargeMoneyListModel.h"

@implementation LCRechargeMoneyListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCRechargeMoneyModel class],
             };
}
@end

@implementation LCRechargeMoneyModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"payId" : @"id"
             };
}
@end
