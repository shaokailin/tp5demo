//
//  LCPostReplyModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/14.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCPostReplyModel.h"

@implementation LCPostReplyModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"create_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    if (isStartTime) {
        BOOL result = NO;;
        if (isStartTime) {
            NSString *endFormar = @"MM月dd日  HH:mm";
            _create_time = [[NSDate dateWithTimeIntervalSince1970:[createTime integerValue]]dateTransformToString:endFormar];
            result = YES;
        }
        return result;
    }
    return NO;
}
@end
