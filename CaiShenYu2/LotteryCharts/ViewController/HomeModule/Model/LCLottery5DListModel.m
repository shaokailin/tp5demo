//
//  LCLottery5DListModel.m
//  LotteryCharts
//
//  Created by linshaokai on 2018/1/6.
//  Copyright © 2018年 林少凯. All rights reserved.
//

#import "LCLottery5DListModel.h"

@implementation LCLottery5DListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"response" : [LCLottery5DModel class],
             };
}
@end
@implementation LCLottery5DModel
- (void)setContent:(NSString *)content {
    _content = content;
    if (KJudgeIsNullData(_content)) {
        NSArray *numberArray = [_content componentsSeparatedByString:@","];
        if (numberArray.count > 0) {
            _number1 = [numberArray objectAtIndex:0];
        }
        if (numberArray.count > 1) {
            _number2 = [numberArray objectAtIndex:1];
        }
        if (numberArray.count > 2) {
            _number3 = [numberArray objectAtIndex:2];
        }
        if (numberArray.count > 3) {
            _number4 = [numberArray objectAtIndex:3];
        }
        if (numberArray.count > 4) {
            _number5 = [numberArray objectAtIndex:4];
        }
    }
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"create_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    if (isStartTime) {
        NSString *formar = @"yyyy年MM月dd日";
        BOOL result = NO;;
        if (isStartTime) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[createTime integerValue]];
            NSString *dateString = [date dateTransformToString:formar];
            _create_time = NSStringFormat(@"%@    %@",dateString,[date getWeekDate]);
            result = YES;
        }
        return result;
    }
    return NO;
}
@end
