//
//  LCSpacePostListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSpacePostListModel.h"

@implementation LCSpacePostListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"user_info" : [LCUserMessageModel class],
             @"data" : [LCPostModel class]
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"user_info" : @"response.user_info",
             @"follow_count" : @"response.follow_count",
             @"team_count" : @"response.team_count",
             @"data" : @"response.post_list",
             @"quiz_count" : @"response.quiz_count",
             @"post_list_count" : @"response.post_list_count",
             
             };
}
@end
