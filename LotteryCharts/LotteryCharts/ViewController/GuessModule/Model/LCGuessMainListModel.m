//
//  LCGuessMainListModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/7.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessMainListModel.h"

@implementation LCGuessMainListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCGuessMainModel class],
             };
    
}
@end
@implementation LCGuessMainModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"quiz_list" : [LCGuessModel class],
             };
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"create_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    NSNumber *endTime = dic[@"end_time"];
    BOOL isEndTime = ([endTime isKindOfClass:[NSNumber class]] || [endTime isKindOfClass:[NSString class]]);
    if (isStartTime || isEndTime) {
        NSString *formar = @"yyyy年MM月dd日";
        BOOL result = NO;;
        if (isStartTime) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[createTime integerValue]];
            NSString *dateString = [date dateTransformToString:formar];
            _create_time = NSStringFormat(@"%@    %@",dateString,[date getWeekDate]);
            result = YES;
        }
        if (isEndTime) {
            NSString *endFormar = @"yyyy年MM月dd日  HH:mm";
            _end_time = [[NSDate dateWithTimeIntervalSince1970:[endTime integerValue]]dateTransformToString:endFormar];
            result = YES;
        }
        return result;
    }
    return NO;
}
- (void)setPeriod_count:(NSString *)period_count {
    _period_count = NSStringFormat(@"%@条新竞争",KNullTransformNumber(period_count));
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"mid" : @"id",
             };
}
@end
