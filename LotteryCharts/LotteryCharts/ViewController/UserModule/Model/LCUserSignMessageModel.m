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
    return @{ @"list_sign" : [LCUserSignModel class]
              };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"today_issign" : @"response.today_issign",
             @"list_sign" : @"response.list_sign",
             @"zhou_sign" : @"response.zhou_sign",
             @"my_count" : @"response.my_count"
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
