//
//  LCRankingVipListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCRankingVipListModel.h"

@implementation LCRankingVipListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [LCHomePostModel class],
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"list" : @"response"
             };
}
@end
