//
//  LCUserMessageListModel.m
//  LotteryCharts
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCUserMessageListModel.h"
@implementation LCUserNoticeModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"create_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    if (isStartTime) {
//        NSString *formar = @"yyyy-MM-dd HH:mm:ss";
        BOOL result = NO;;
        if (isStartTime) {
            _create_time = [LSKPublicMethodUtil timeStr:[createTime integerValue]];
            result = YES;
        }
        return result;
    }
    return NO;
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"noticeId" : @"id",
             };
}
- (void)setExtends:(NSString *)extends {
    _extends = extends;
    if (KJudgeIsNullData(extends)) {
        _userMessage = [LSKPublicMethodUtil jsonDataTransformToDictionary:[extends dataUsingEncoding:NSUTF8StringEncoding]];
    }
}
- (void)setContent:(NSString *)content {
    _content = content;
    CGFloat height = [content calculateTextHeight:13 width:SCREEN_WIDTH - 66];
    self.height = height;
}
@end
@implementation LCUserMessageListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"response" : [LCUserNoticeModel class]
              };
}
@end
