//
//  LCRankingRenListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRankingRenListModel.h"

@implementation LCRankingRenListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [LCRankingRenModel class],
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list" : @"response"
             };
}
@end
