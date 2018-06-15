//
//  LC3DLotteryModel.m
//  LotteryCharts
//
//  Created by hsPlan on 2017/12/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LC3DLotteryModel.h"

@implementation LC3DLotteryModel
- (void)setLottery_result_kill:(NSString *)lottery_result_kill {
    _lottery_result_kill = lottery_result_kill;
    if (KJudgeIsNullData(_lottery_result_kill)) {
        NSArray *numberArray = [_lottery_result_kill componentsSeparatedByString:@","];
        if (numberArray.count > 0) {
            _number1 = [numberArray objectAtIndex:0];
        }
        if (numberArray.count > 1) {
            _number2 = [numberArray objectAtIndex:1];
        }
        if (numberArray.count > 2) {
            _number3 = [numberArray objectAtIndex:2];
        }
    }
}
- (void)setTest_number:(NSString *)test_number {
    if (KJudgeIsNullData(test_number)) {
        NSArray *numberArray = [test_number componentsSeparatedByString:@","];
        if (numberArray.count > 0) {
            _number4 = [numberArray objectAtIndex:0];
        }
        if (numberArray.count > 1) {
            _number5 = [numberArray objectAtIndex:1];
        }
        if (numberArray.count > 2) {
            _number6 = [numberArray objectAtIndex:2];
        }
    }
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *createTime = dic[@"betting_time"];
    BOOL isStartTime = ([createTime isKindOfClass:[NSNumber class]] || [createTime isKindOfClass:[NSString class]]);
    if (isStartTime) {
        NSString *formar = @"yyyy年MM月dd日";
        BOOL result = NO;;
        if (isStartTime) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[createTime integerValue]];
            NSString *dateString = [date dateTransformToString:formar];
            _betting_time = NSStringFormat(@"%@  %@",dateString,[date getWeekDate]);
            result = YES;
        }
        return result;
    }
    return NO;
}
@end
