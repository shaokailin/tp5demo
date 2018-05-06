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
- (void)setMessage:(NSString *)message {
    _message = message;
    CGFloat height = [message calculateTextHeight:11 width:ScreenWidth - 162];
    if (height < 14) {
        height = 14;
    }
    self.height = 54 + height;
}
@end
