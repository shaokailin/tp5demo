//
//  LCTeamCountModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/1.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCTeamCountModel.h"

@implementation LCTeamCountModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"teamcount" : @"response.teamcount",
             @"onlinecount" : @"response.onlinecount",
             };
}
@end
