//
//  LCPublicNoticeListModel.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCPublicNoticeListModel.h"

@implementation LCPublicNoticeListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCPublicNoticeModel class],
             };
}
@end
@implementation LCPublicNoticeModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"update_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    if (isStartTime) {
        NSString *formar = @"yyyy年MM月dd日 HH:mm";
        BOOL result = NO;;
        if (isStartTime) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[createTime integerValue]];
            NSString *dateString = [date dateTransformToString:formar];
            _update_time = dateString;
            result = YES;
        }
        return result;
    }
    return NO;
}
- (void)setContent:(NSString *)content {
    _content = content;
    CGFloat height = [content calculateTextHeight:13 width:SCREEN_WIDTH - 38];
    self.height = height;
}
@end
