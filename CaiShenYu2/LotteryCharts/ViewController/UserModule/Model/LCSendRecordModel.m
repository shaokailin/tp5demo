//
//  LCSendRecordModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCSendRecordModel.h"

@implementation LCSendRecordModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"add_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    if (isStartTime) {
//        NSString *formar = @"yyyy-MM-dd HH:mm:ss";
        BOOL result = NO;;
        if (isStartTime) {
            _add_time = [LSKPublicMethodUtil timeStr:[createTime integerValue]];
            result = YES;
        }
        return result;
    }
    return NO;
}
@end
