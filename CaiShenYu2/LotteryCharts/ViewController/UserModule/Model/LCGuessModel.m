//
//  LCGuessModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/4.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LCGuessModel.h"

@implementation LCGuessModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"create_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    NSNumber *updateTime = dic[@"update_time"];
    BOOL isUpdateTime = ([updateTime isKindOfClass:[NSNumber class]] || [updateTime isKindOfClass:[NSString class]]);
    if (isStartTime || isUpdateTime) {
        NSString *formar = @"MM-dd HH:mm";
        BOOL result = NO;;
        if (isStartTime) {
            _create_time = [[NSDate dateWithTimeIntervalSince1970:[createTime integerValue]]dateTransformToString:formar];
            result = YES;
        }
        if (isUpdateTime) {
            NSString *formar1 = @"MM月dd日 HH:mm";
            _update_time = [[NSDate dateWithTimeIntervalSince1970:[updateTime integerValue]]dateTransformToString:formar1];
            result = YES;
        }
        return result;
    }
    return NO;
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"reply" : [LCPostReplyModel class]
              };
}
- (NSInteger)hasCount {
    return self.quiz_number - self.quiz_buynumber;
}
- (void)setQuiz_content:(NSString *)quiz_content {
    _quiz_content = KNullTransformString(quiz_content);
    _contentHeight = [_quiz_content calculateTextHeight:12 width:SCREEN_WIDTH - 40];
}
@end
