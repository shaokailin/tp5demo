//
//  PPSSActivityModel.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/19.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSActivityModel.h"

@implementation PPSSActivityModel
- (void)setPromotionIntensity:(NSString *)promotionIntensity {
    _promotionIntensity = NSStringFormat(@"%@%%",KNullTransformNumber(promotionIntensity));
}
- (void)setPromotionMoney:(NSString *)promotionMoney {
    _promotionMoney = KNullTransformMoney(promotionMoney);
}
- (void)setPromotionPrice:(NSString *)promotionPrice {
    _promotionPrice = KNullTransformMoney(promotionPrice);
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *endTime = dic[@"promotionEndTime"];
    NSNumber *startTime = dic[@"promotionStartTime"];

    BOOL isStartTime = [startTime isKindOfClass:[NSNumber class]];
    BOOL isEndTime = [endTime isKindOfClass:[NSNumber class]];
    if (isStartTime || isEndTime) {
        NSInteger type = [dic[@"promotionType"] integerValue];
        NSString *formar = type == 0?@"yyyy-MM-dd":@"yyyy-MM-dd HH:mm:ss";
        BOOL result = NO;;
        if (isStartTime) {
            _promotionStartTime = [[NSDate dateWithTimeIntervalSince1970:[startTime integerValue]]dateTransformToString:formar];
            result = YES;
        }
        if (isEndTime) {
            _promotionEndTime = [[NSDate dateWithTimeIntervalSince1970:[endTime integerValue]]dateTransformToString:formar];
            result = YES;
        }
        return result;
    }
    return NO;
}
- (NSString *)promotionLimitTime {
    if (!_promotionLimitTime) {
        NSInteger type = [_promotionType integerValue];
        if (type == 0) {
            if (self.promotionTime && [self.promotionTime isKindOfClass:[NSArray class]] && self.promotionTime.count > 0) {
                NSDictionary *dict = [self.promotionTime lastObject];
                NSString *start = [dict objectForKey:@"startTime"];
                NSString *end = [dict objectForKey:@"endTime"];
                NSString *time = @"";
                if (KJudgeIsNullData(end)) {
                    time = end;
                }else if (KJudgeIsNullData(start)){
                    time = start;
                }
                _promotionLimitTime = NSStringFormat(@"%@ %@",_promotionEndTime,time);
            }else {
                _promotionLimitTime = _promotionEndTime;
            }
        }else {
            _promotionLimitTime = _promotionEndTime;
        }
    }
    return _promotionLimitTime;
}
@end
