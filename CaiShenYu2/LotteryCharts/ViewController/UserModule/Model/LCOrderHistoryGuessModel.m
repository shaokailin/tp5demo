//
//  LCOrderHistoryGuessModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/26.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCOrderHistoryGuessModel.h"

@implementation LCOrderHistoryGuessModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"response" : [LCHistoryGuessModel class]
              };
}
@end
@implementation LCHistoryGuessModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"create_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    if (isStartTime) {
        NSString *formar = @"yyyy-MM-dd HH:mm:ss";
        BOOL result = NO;;
        if (isStartTime) {
            _create_time = [[NSDate dateWithTimeIntervalSince1970:[createTime integerValue]]dateTransformToString:formar];
            result = YES;
        }
        return result;
    }
    return NO;
}
@end
