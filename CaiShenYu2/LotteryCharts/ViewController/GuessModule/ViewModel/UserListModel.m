//
//  UserListModel.m
//  LotteryCharts
//
//  Created by 程磊 on 2018/3/26.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "UserListModel.h"

@implementation GuessUserModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"create_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    if (isStartTime) {
        NSString *formar = @"MM月dd日";
        BOOL result = NO;;
        if (isStartTime) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[createTime integerValue]];
            NSString *dateString = [date dateTransformToString:formar];
            _create_time = NSStringFormat(@"%@",dateString);
            result = YES;
        }
        return result;
    }
    return NO;
}

@end

@implementation UserListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [GuessUserModel class],
             };
}


@end
