//
//  LCSpaceSendRecordListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpaceSendRecordListModel.h"

@implementation LCSpaceSendRecordListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [LCSendRecordModel class]
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"data" : @"response.post_reward",
             @"all_money" : @"response.all_money",
             @"all_row" : @"response.all_row"
             };
}
@end
