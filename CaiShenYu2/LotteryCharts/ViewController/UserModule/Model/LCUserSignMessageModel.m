//
//  LCUserSignMessageModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCUserSignMessageModel.h"

@implementation LCUserSignMessageModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"this_week_sign_list" : [LCUserSignModel class]
              };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"today_sign" : @"response.today_sign",
             @"this_week_sign_list" : @"response.this_week_sign_list",
             @"earn_sign_week" : @"response.earn_sign_week",
             @"earn_sign_total" : @"response.earn_sign_total"
             };
}
@end
@implementation LCUserSignModel
- (void)setSign_time:(NSString *)sign_time {
    _sign_time = sign_time;
    if (KJudgeIsNullData(sign_time)) {
        _week = [[NSDate dateWithTimeIntervalSince1970:[sign_time integerValue]] getWeekIndex];
    }
}
@end
