//
//  LCHomePostModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCHomePostModel.h"

@implementation LCHomePostModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"create_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    if (isStartTime) {
        BOOL result = NO;
//        NSString *endFormar = @"yyyy年MM月dd日  HH:mm";
        _create_time = [LSKPublicMethodUtil timeStr:[createTime floatValue]];
        result = YES;
        return result;
    }
    return NO;
}
@end
